Class {
	#name : 'HfuSpManDontGetAngryPlayerView',
	#superclass : 'HfuSpPlayerView',
	#instVars : [
		'startGameButton',
		'boardPortlet',
		'boardRows',
		'boardIndexBadgeMap',
		'player1WinDictionary',
		'player2WinDictionary',
		'player3WinDictionary',
		'player4WinDictionary',
		'player1FiguresField',
		'player2FiguresField',
		'player3FiguresField',
		'player4FiguresField',
		'rollButton',
		'figureButton',
		'turnLabel',
		'turnLabelVisibleBool'
	],
	#category : 'HfuSpManDontGetAngry'
}

{ #category : 'Not categorized' }
HfuSpManDontGetAngryPlayerView class >> startUp [

	"<^self>"
	"Set http sever and connect with views"

	| theHttpServer |
	theHttpServer := (Me5SstHttpServer startUpHttpServerOnPort: '9010' serverApplicationClass: HfuSpManDontGetAngryPlayerView).
	theHttpServer addViewClass: HfuSpManDontGetAngryPlayerView;
		yourself
]

{ #category : 'Internal' }
HfuSpManDontGetAngryPlayerView >> announceVictor: aColorString [

	"<^self>"
	"Answer the receiver"

	| winnerString |

	winnerString := 'Player ', aColorString, ' won!'.
	self showInfoNotificationWithMessage: winnerString.
]

{ #category : 'Accessing' }
HfuSpManDontGetAngryPlayerView >> boardIndexBadgeMap [

	^boardIndexBadgeMap
]

{ #category : 'Accessing' }
HfuSpManDontGetAngryPlayerView >> boardIndexBadgeMap: anObject [

	boardIndexBadgeMap := anObject
]

{ #category : 'Accessing' }
HfuSpManDontGetAngryPlayerView >> boardPortlet [

	^boardPortlet
]

{ #category : 'Accessing' }
HfuSpManDontGetAngryPlayerView >> boardPortlet: anObject [

	boardPortlet := anObject
]

{ #category : 'Accessing' }
HfuSpManDontGetAngryPlayerView >> boardRows [

	^boardRows
]

{ #category : 'Accessing' }
HfuSpManDontGetAngryPlayerView >> boardRows: anObject [

	boardRows := anObject
]

{ #category : 'Internal' }
HfuSpManDontGetAngryPlayerView >> colorBadge: aBadge playerNumber: anInteger [
"Changes the color of the badge parameter to the color of the given player number where: 
		0 = empty field
		1 = blue
		2 = red
		3 = green
		4 = yellow"
	anInteger = 0
		ifTrue: [aBadge removeAllStylesAndSetPrimary].
	anInteger = 1
		ifTrue: [aBadge removeAllStylesAndSetInfo].
	anInteger = 2
		ifTrue: [aBadge removeAllStylesAndSetDanger].
	anInteger = 3
		ifTrue: [aBadge removeAllStylesAndSetSuccess].
	anInteger = 4
		ifTrue: [aBadge removeAllStylesAndSetWarning]
]

{ #category : 'Internal' }
HfuSpManDontGetAngryPlayerView >> colorBadgeAtIndex: anInteger toPlayerNumber: aPlayerNumber [

	"Sets the color of the field at Index anInteger to the corresponding player number"
	self colorBadge: (self boardIndexBadgeMap at: anInteger) playerNumber: aPlayerNumber.
]

{ #category : 'Initial events' }
HfuSpManDontGetAngryPlayerView >> createComponents [

	"create view components"
	|color|
	boardRows := OrderedCollection new.
	boardPortlet := Me5Portlet new.
	self playerViewController offset = 0
		ifTrue: [color:= 'Blue']
		ifFalse: [
			self playerViewController offset = 1
				ifTrue: [color:= 'Red']
				ifFalse: [
					self playerViewController offset = 2
						ifTrue: [color:= 'Green']
							ifFalse: [color:='Yellow']]].
	self 
			addChild: (Me5Label new
			text: 'Man, dont be angry. You are ', color,' (', ((self playerViewController offset) + 1) asString, ')';
			yourself).
	self addChild: (Me5Div new).
	self addChild: (startGameButton:= (Me5Button newAirSecondary
					text: 'Start Game';
					addClickEventSelector: #startGameClicked;
					yourself)).
	self addChild: (rollButton := Me5Button newAirSecondary
					text: 'Roll';
					addClickEventSelector: #exEvent:;
					yourself).
	self addChild: (figureButton := Me5Button newAirSecondary
					text: 'Put Figure on Board';
					addClickEventSelector: #exEvent:;
					yourself).
	self addChild: (Me5Div new).
	self addChild: (turnLabel := Me5Label newWithText: 'Its your turn!' ).
	self renderBaseGameState.
	self turnLabelVisibleBool: false.
	self turnLabel show: false.
	self playerViewController displayCurrentBoardState.
	self addChild: (Me5Timeout new addIntervalSeconds: 4 selector:#updateSite:; activate ;yourself).
		

]

{ #category : 'Internal' }
HfuSpManDontGetAngryPlayerView >> displayBoardState: anBoardState [

	"displays the BoardState on the screen"
	self setGame: anBoardState
]

{ #category : 'Internal' }
HfuSpManDontGetAngryPlayerView >> exEvent: event [

	"Communication with the playerViewController"
	event component text = 'Roll'
		ifTrue: [self playerViewController transmitOrder: 0.^nil].
	event component text = 'Put Figure on Board'
		ifTrue:[self playerViewController transmitOrder: -1. ^nil].
	event component .
	self playerViewController transmitOrder: (self getIndexbyBadge: event component).
	
]

{ #category : 'Internal' }
HfuSpManDontGetAngryPlayerView >> getFieldByRow: aRow Column: aColumn [

	"Returns the Field specified by the coordinates."
	^((boardRows at: aRow) childAt: aColumn)
]

{ #category : 'Accessing' }
HfuSpManDontGetAngryPlayerView >> getIndexbyBadge: aBadge [
	"Returns the index number of the given badge on the field"
	self boardIndexBadgeMap keysAndValuesDo: [:eachKey :eachValue |
		(eachValue = aBadge) ifTrue: [^eachKey]].
	self player1WinDictionary keysAndValuesDo: [:eachKey :eachValue |
		(eachValue = aBadge) ifTrue: [^eachKey+40]].
	self player2WinDictionary keysAndValuesDo: [:eachKey :eachValue |
		(eachValue = aBadge) ifTrue: [^eachKey+44]].
	self player3WinDictionary keysAndValuesDo: [:eachKey :eachValue |
		(eachValue = aBadge) ifTrue: [^eachKey+48]].
	self player4WinDictionary keysAndValuesDo: [:eachKey :eachValue |
		(eachValue = aBadge) ifTrue: [^eachKey+52]].
	^false
]

{ #category : 'Initial events' }
HfuSpManDontGetAngryPlayerView >> initializeBoardIndexMap [

"Initializes the boardIndexMap Dictionary to map the indizies to the corresponding badge."
	| theMap theIndex whileLoopInt|
	theMap := Dictionary new.
	theIndex := 1.
	1 to: 4 do: [:eachRow | theMap at: theIndex put: (self getFieldByRow: eachRow Column: 7).
		theIndex := theIndex + 1.].
	7 to: 11 do: [:eachColumn | theMap at: theIndex put: (self getFieldByRow: 5 Column: eachColumn).
		theIndex := theIndex + 1.].
	theMap at: theIndex put: (self getFieldByRow: 6 Column: 11).
	theIndex := theIndex + 1.
	whileLoopInt := 11.
	[whileLoopInt >= 7 ] whileTrue: [
		theMap at: theIndex put: (self getFieldByRow: 7 Column: whileLoopInt).
		whileLoopInt := whileLoopInt - 1.
		theIndex := theIndex + 1.].
	8 to: 11 do: [:eachRow | theMap at: theIndex put: (self getFieldByRow: eachRow Column: 7).
		theIndex := theIndex + 1.].
	theMap at: theIndex put: (self getFieldByRow: 11 Column: 6).
	theIndex := theIndex + 1.
	whileLoopInt := 11.
	[whileLoopInt >= 7] whileTrue: [
		theMap at: theIndex put: (self getFieldByRow: whileLoopInt Column: 5).
		whileLoopInt := whileLoopInt - 1.
		theIndex := theIndex + 1].
	whileLoopInt := 4.
	[whileLoopInt >= 1] whileTrue: [
		theMap at: theIndex put: (self getFieldByRow: 7 Column: whileLoopInt).
		whileLoopInt := whileLoopInt - 1.
		theIndex := theIndex + 1.].
	theMap at: theIndex put: (self getFieldByRow: 6 Column: 1 ).
	theIndex := theIndex + 1.
	1 to: 4 do: [:eachColumn | theMap at: theIndex put: (self getFieldByRow: 5 Column: eachColumn).
		theIndex := theIndex + 1.].
	whileLoopInt := 5.
	[whileLoopInt >= 1] whileTrue: [
		theMap at: theIndex put: (self getFieldByRow: whileLoopInt Column: 5).
		whileLoopInt := whileLoopInt - 1.
		theIndex := theIndex + 1].
	theMap at: theIndex put: (self getFieldByRow: 1 Column: 6).

	self boardIndexBadgeMap: theMap.
]

{ #category : 'Internal' }
HfuSpManDontGetAngryPlayerView >> initializePlayerFiguresFields [

	"Initializes the FiguresFields"
		self player1FiguresField: OrderedCollection new.
		self player2FiguresField: OrderedCollection new.
		self player3FiguresField: OrderedCollection new.
		self player4FiguresField: OrderedCollection new.

		self player1FiguresField add: (self getFieldByRow: 1 Column: 10).
		self player1FiguresField add: (self getFieldByRow: 1 Column: 11).
		self player1FiguresField add: (self getFieldByRow: 2 Column: 10).
		self player1FiguresField add: (self getFieldByRow: 2 Column: 11).
		
		self player2FiguresField add: (self getFieldByRow: 10 Column: 10).
		self player2FiguresField add: (self getFieldByRow: 10 Column: 11).
		self player2FiguresField add: (self getFieldByRow: 11 Column: 10).
		self player2FiguresField add: (self getFieldByRow: 11 Column: 11).
		
		self player3FiguresField add: (self getFieldByRow: 10 Column: 1).
		self player3FiguresField add: (self getFieldByRow: 10 Column: 2).
		self player3FiguresField add: (self getFieldByRow: 11 Column: 1).
		self player3FiguresField add: (self getFieldByRow: 11 Column: 2).
		
		self player4FiguresField add: (self getFieldByRow: 1 Column: 1).
		self player4FiguresField add: (self getFieldByRow: 1 Column: 2).
		self player4FiguresField add: (self getFieldByRow: 2 Column: 1).
		self player4FiguresField add: (self getFieldByRow: 2 Column: 2).
	
]

{ #category : 'Initial events' }
HfuSpManDontGetAngryPlayerView >> initializePlayerWinDictionaries [
	"Initializes the Win Dictionaries for easier accessing"
	| tempDictionary |
	"Initialize Player1WinDictionary"
	tempDictionary := Dictionary new.
	tempDictionary at: 1 put: (self getFieldByRow: 2 Column: 6).
	tempDictionary at: 2 put: (self getFieldByRow: 3 Column: 6).
	tempDictionary at: 3 put: (self getFieldByRow: 4 Column: 6).
	tempDictionary at: 4 put: (self getFieldByRow: 5 Column: 6).
	self player1WinDictionary: tempDictionary.
	"Initialize Player2WinDictionary"
	tempDictionary := Dictionary new.
	tempDictionary at: 1 put: (self getFieldByRow: 6 Column: 10).
	tempDictionary at: 2 put: (self getFieldByRow: 6 Column: 9).
	tempDictionary at: 3 put: (self getFieldByRow: 6 Column: 8).
	tempDictionary at: 4 put: (self getFieldByRow: 6 Column: 7).
	self player2WinDictionary: tempDictionary.
	"Initialize Player3WinDictionary"
	tempDictionary := Dictionary new.
	tempDictionary at: 1 put: (self getFieldByRow: 7 Column: 6).
	tempDictionary at: 2 put: (self getFieldByRow: 8 Column: 6).
	tempDictionary at: 3 put: (self getFieldByRow: 9 Column: 6).
	tempDictionary at: 4 put: (self getFieldByRow: 10 Column: 6).
	self player3WinDictionary: tempDictionary.
	"Initialize Player4WinDictionary"
	tempDictionary := Dictionary new.
	tempDictionary at: 1 put: (self getFieldByRow: 6 Column: 5).
	tempDictionary at: 2 put: (self getFieldByRow: 6 Column: 4).
	tempDictionary at: 3 put: (self getFieldByRow: 6 Column: 3).
	tempDictionary at: 4 put: (self getFieldByRow: 6 Column: 2).
	self player4WinDictionary: tempDictionary.
]

{ #category : 'Accessing' }
HfuSpManDontGetAngryPlayerView >> player1FiguresField [

	^player1FiguresField
]

{ #category : 'Accessing' }
HfuSpManDontGetAngryPlayerView >> player1FiguresField: anObject [

	player1FiguresField := anObject
]

{ #category : 'Accessing' }
HfuSpManDontGetAngryPlayerView >> player1WinDictionary [

	^player1WinDictionary
]

{ #category : 'Accessing' }
HfuSpManDontGetAngryPlayerView >> player1WinDictionary: anObject [

	player1WinDictionary := anObject
]

{ #category : 'Accessing' }
HfuSpManDontGetAngryPlayerView >> player2FiguresField [

	^player2FiguresField
]

{ #category : 'Accessing' }
HfuSpManDontGetAngryPlayerView >> player2FiguresField: anObject [

	player2FiguresField := anObject
]

{ #category : 'Accessing' }
HfuSpManDontGetAngryPlayerView >> player2WinDictionary [

	^player2WinDictionary
]

{ #category : 'Accessing' }
HfuSpManDontGetAngryPlayerView >> player2WinDictionary: anObject [

	player2WinDictionary := anObject
]

{ #category : 'Accessing' }
HfuSpManDontGetAngryPlayerView >> player3FiguresField [

	^player3FiguresField
]

{ #category : 'Accessing' }
HfuSpManDontGetAngryPlayerView >> player3FiguresField: anObject [

	player3FiguresField := anObject
]

{ #category : 'Accessing' }
HfuSpManDontGetAngryPlayerView >> player3WinDictionary [

	^player3WinDictionary
]

{ #category : 'Accessing' }
HfuSpManDontGetAngryPlayerView >> player3WinDictionary: anObject [

	player3WinDictionary := anObject
]

{ #category : 'Accessing' }
HfuSpManDontGetAngryPlayerView >> player4FiguresField [

	^player4FiguresField
]

{ #category : 'Accessing' }
HfuSpManDontGetAngryPlayerView >> player4FiguresField: anObject [

	player4FiguresField := anObject
]

{ #category : 'Accessing' }
HfuSpManDontGetAngryPlayerView >> player4WinDictionary [

	^player4WinDictionary
]

{ #category : 'Accessing' }
HfuSpManDontGetAngryPlayerView >> player4WinDictionary: anObject [

	player4WinDictionary := anObject
]

{ #category : 'Internal' }
HfuSpManDontGetAngryPlayerView >> renderBaseGameState [

	"Renders the game state with an empty board state"
		self
		addChild: (boardPortlet := Me5Portlet new).
		1 to: 11 do: [:eachNumber | boardPortlet addChildToBody: (boardRows add: (Me5Div new))].
		"Initialize the first row"
		1 to: 11 do: [:eachColumn | eachColumn < 5 
			ifTrue: [(boardRows at: 1) addChild: (Me5Badge new
				text: ' ';
				addClickEventSelector:#exEvent: ;
				yourself)].
			(eachColumn between: 5 and: 7) 
			ifTrue: [(boardRows at: 1) addChild:(Me5Badge newPrimary
				text: ' ';
				addClickEventSelector:#exEvent: ;
				yourself)].
			eachColumn > 7 
			ifTrue: [(boardRows at:1) addChild: (Me5Badge new
				text: ' ';
				addClickEventSelector:#exEvent: ;
				yourself)].
			].
		"Initialize row 2 - 4"
		2 to: 4 do: [:eachRow | 
			1 to: 4 do: [:eachColumn | (boardRows at: eachRow) addChild:(Me5Badge new
				text: ' ';
				addClickEventSelector:#exEvent: ;
				yourself).].
			(boardRows at: eachRow) addChild: (Me5Badge newPrimary
				text: ' ';
				addClickEventSelector:#exEvent: ;
				yourself).
			(boardRows at: eachRow) addChild: (Me5Badge newInfo
				text: ' ';
				addClickEventSelector:#exEvent: ;
				yourself).
			(boardRows at: eachRow) addChild: (Me5Badge newPrimary
				text: ' ';
				addClickEventSelector:#exEvent: ;
				yourself).
			1 to: 4 do: [:eachColumn | (boardRows at: eachRow) addChild:(Me5Badge new
				text: ' ';
				addClickEventSelector:#exEvent: ;
				yourself).].
		].
		"Initialize row 5"
		1 to: 5 do: [:eachColumn | (boardRows at: 5) addChild: (Me5Badge newPrimary
			text: ' ';
			addClickEventSelector:#exEvent: ;
			yourself).].
		(boardRows at: 5) addChild: (Me5Badge newInfo
			text: ' ';
			addClickEventSelector:#exEvent: ;
			yourself).
		7 to: 11 do: [:eachColumn | (boardRows at: 5) addChild: (Me5Badge newPrimary
			text: ' ';
			addClickEventSelector:#exEvent: ;
			yourself).].
		"Initialize row 6"
		(boardRows at: 6) addChild: (Me5Badge newPrimary
			text: ' ';
			addClickEventSelector:#exEvent: ;
			yourself).
		2 to: 5 do: [:eachColumn | (boardRows at: 6) addChild: (Me5Badge newWarning
			text: ' ';
			addClickEventSelector:#exEvent: ;
			yourself)]. 
		(boardRows at: 6) addChild: (Me5Badge new
			text: ' ';
			addClickEventSelector:#exEvent: ;
			yourself).
		7 to: 10 do: [:eachColumn | (boardRows at: 6) addChild: (Me5Badge newDanger
			text: ' ';
			addClickEventSelector:#exEvent: ;
			yourself)].
		(boardRows at: 6) addChild: (Me5Badge newPrimary
				text: ' ';
				addClickEventSelector:#exEvent: ;
				yourself).
		"Initialize row 7"
		1 to: 5 do: [:eachColumn | (boardRows at: 7) addChild: (Me5Badge newPrimary
			text: ' ';
			addClickEventSelector:#exEvent: ;
			yourself).].
		(boardRows at: 7) addChild: (Me5Badge newSuccess
			text: ' ';
			addClickEventSelector:#exEvent: ;
			yourself).
		7 to: 11 do: [:eachColumn | (boardRows at: 7) addChild: (Me5Badge newPrimary
			text: ' ';
			addClickEventSelector:#exEvent: ;
			yourself).].
		"Initialize rows 8 to 10"
		8 to: 10 do: [:eachRow | 
			1 to: 4 do: [:eachColumn | (boardRows at: eachRow) addChild:(Me5Badge new
				text: ' ';
				addClickEventSelector:#exEvent: ;
				yourself).].
			(boardRows at: eachRow) addChild: (Me5Badge newPrimary
				text: ' ';
				addClickEventSelector:#exEvent: ;
				yourself).
			(boardRows at: eachRow) addChild: (Me5Badge newSuccess
				text: ' ';
				addClickEventSelector:#exEvent: ;
				yourself).
			(boardRows at: eachRow) addChild: (Me5Badge newPrimary
				text: ' ';
				addClickEventSelector:#exEvent: ;
				yourself).
			1 to: 4 do: [:eachColumn | (boardRows at: eachRow) addChild:(Me5Badge new
				text: ' ';
				addClickEventSelector:#exEvent: ;
				yourself).].
		].
		"Initialize row 11"
		1 to: 11 do: [:eachColumn | eachColumn < 5 
			ifTrue: [(boardRows at: 11) addChild: (Me5Badge new
				text: ' ';
				addClickEventSelector:#exEvent: ;
				yourself)].
			(eachColumn between: 5 and: 7) 
			ifTrue: [(boardRows at: 11) addChild:(Me5Badge newPrimary
				text: ' ';
				addClickEventSelector:#exEvent: ;
				yourself)].
			eachColumn > 7 
			ifTrue: [(boardRows at:11) addChild: (Me5Badge new
				text: ' ';
				addClickEventSelector:#exEvent: ;
				yourself)].
			].
		self initializeBoardIndexMap.
		self initializePlayerWinDictionaries.
		self initializePlayerFiguresFields.
]

{ #category : 'Internal' }
HfuSpManDontGetAngryPlayerView >> setGame: aBoardState [

	"displays the given BoardState"
	| index |
	index := 1.
	aBoardState board do: [:eachValue | self colorBadgeAtIndex: index toPlayerNumber: eachValue.
		index := index + 1.].
	1 to: 4 do: [:eachNumber | self setPlayerNumber: 1 WinFieldAt: eachNumber To: (aBoardState lastFields at: eachNumber)].
	1 to: 4 do: [:eachNumber | self setPlayerNumber: 2 WinFieldAt: eachNumber To: (aBoardState lastFields at: (eachNumber + 4))].
	1 to: 4 do: [:eachNumber | self setPlayerNumber: 3 WinFieldAt: eachNumber To: (aBoardState lastFields at: (eachNumber + 8))].
	1 to: 4 do: [:eachNumber | self setPlayerNumber: 4 WinFieldAt: eachNumber To: (aBoardState lastFields at: (eachNumber + 12))].
	
	1 to: (aBoardState figureFields at: 1 ) do:[:eachField | (self player1FiguresField at: eachField )addCssClassMBadgeInfo].
	1 to: (aBoardState figureFields at: 2 ) do:[:eachField | (self player2FiguresField at: eachField )addCssClassMBadgeDanger].
	1 to: (aBoardState figureFields at: 3 ) do:[:eachField | (self player3FiguresField at: eachField )addCssClassMBadgeSuccess].
	1 to: (aBoardState figureFields at: 4 ) do:[:eachField | (self player4FiguresField at: eachField )addCssClassMBadgeWarning].
	self playerViewController isActingPlayer
	ifTrue: [self turnLabel show: self turnLabelVisibleBool.
		self turnLabelVisibleBool: true]
	ifFalse: [self turnLabel show: self turnLabelVisibleBool.
		self turnLabelVisibleBool: false]


]

{ #category : 'Internal' }
HfuSpManDontGetAngryPlayerView >> setPlayerNumber: aPlayerNumberInteger WinFieldAt: anInteger To: aBoolean [

	"Sets the WinField according to the given boolean"
	(aPlayerNumberInteger = 1 and: [aBoolean]) ifTrue: [(self player1WinDictionary at: anInteger) 
				removeAllStylesAndSetPrimary].
	(aPlayerNumberInteger = 2 and: [aBoolean]) ifTrue: [(self player2WinDictionary at: anInteger)
					removeAllStylesAndSetPrimary].
	(aPlayerNumberInteger = 3 and: [aBoolean]) ifTrue: [(self player3WinDictionary at: anInteger)
					removeAllStylesAndSetPrimary].
	(aPlayerNumberInteger = 4 and: [aBoolean]) ifTrue: [(self player4WinDictionary at: anInteger)
					removeAllStylesAndSetPrimary].
	
	(aPlayerNumberInteger = 1 and: [aBoolean not]) ifTrue: [(self player1WinDictionary at: anInteger)
					removeAllStylesAndSetInfo].
	(aPlayerNumberInteger = 2 and: [aBoolean not]) ifTrue: [(self player2WinDictionary at: anInteger)
					removeAllStylesAndSetDanger].
	(aPlayerNumberInteger = 3 and: [aBoolean not]) ifTrue: [(self player3WinDictionary at: anInteger)
					removeAllStylesAndSetSuccess].
	(aPlayerNumberInteger = 4 and: [aBoolean not]) ifTrue: [(self player4WinDictionary at: anInteger)
					removeAllStylesAndSetWarning].
]

{ #category : 'Internal' }
HfuSpManDontGetAngryPlayerView >> startGameClicked [

	"Starts the game"
	self playerViewController startGame.

]

{ #category : 'Accessing' }
HfuSpManDontGetAngryPlayerView >> turnLabel [

	^turnLabel
]

{ #category : 'Accessing' }
HfuSpManDontGetAngryPlayerView >> turnLabel: anObject [

	turnLabel := anObject
]

{ #category : 'Accessing' }
HfuSpManDontGetAngryPlayerView >> turnLabelVisibleBool [

	^turnLabelVisibleBool
]

{ #category : 'Accessing' }
HfuSpManDontGetAngryPlayerView >> turnLabelVisibleBool: anObject [

	turnLabelVisibleBool := anObject
]

{ #category : 'Internal' }
HfuSpManDontGetAngryPlayerView >> updateSite: updateSiteEvent [

	"Event for the timer to update the view"
	self removeChild: self boardPortlet.
	boardRows := OrderedCollection new.
	boardPortlet := Me5Portlet new.
	self renderBaseGameState.
	self playerViewController displayCurrentBoardState.
]
