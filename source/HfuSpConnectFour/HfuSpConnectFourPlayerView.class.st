Class {
	#name : 'HfuSpConnectFourPlayerView',
	#superclass : 'HfuSpPlayerView',
	#instVars : [
		'connectRows',
		'connectFormPortlet',
		'startButton',
		'aRowButton',
		'aBadge',
		'save'
	],
	#category : 'HfuSpConnectFour'
}

{ #category : 'Not categorized' }
HfuSpConnectFourPlayerView >> createComponents [

	 connectRows:= OrderedCollection new.
	 
	 self
		addChild: ( startButton := Me5Button new
			text: 'start game';
			addClickEventSelector: #startGameClicked;
			yourself).
			
	
"self initConnectFour."			
self addChild: (Me5Timeout new addIntervalSeconds: 4 selector:#updateSite:; activate ;yourself).
	self initConnectFour.
]

{ #category : 'Not categorized' }
HfuSpConnectFourPlayerView >> displayBoardState: anBoardState [

	"displays the BoardState on the screen"
	self setGame: anBoardState
]

{ #category : 'Not categorized' }
HfuSpConnectFourPlayerView >> getFieldByRow: aRow Column: aColumn [

	"Returns the Field specified by the coordinates."
	^((connectRows at: aRow) childAt: aColumn)
]

{ #category : 'Not categorized' }
HfuSpConnectFourPlayerView >> initConnectFour [
		
	self	
		addChild: (connectFormPortlet := Me5FormPortlet new
			title:'ConnectFour!';			
			yourself);
					
	yourself.
			
			1 to: 7 do: [:eachNumber | connectFormPortlet addChildToBody: (connectRows add: (Me5Div new))].
			Me5Section new.
			
			1 to: 7 do: [:eachColumn | eachColumn < 8 
					ifTrue: [(connectRows at: 1) addChild: (aRowButton:= Me5Button newAirButton
						text: eachColumn asString;
						name: eachColumn asString;
						addClickEventSelector: #rowClicked:;
						yourself)].
					].
	
				Me5Section new.
				
			2 to: 7 do: [:eachRow | 
					1 to: 8 do: [:eachColumn | eachColumn < 8 
					ifTrue: [
					eachColumn = save 
					ifFalse:[(connectRows at: eachRow) addChild: (aBadge := Me5Badge new
						text: eachColumn asString;
						yourself)].
						].		
				].
			].

]

{ #category : 'Not categorized' }
HfuSpConnectFourPlayerView >> rowClicked: anEventFromCon [
	self playerViewController transmitOrder: anEventFromCon component name asInteger.
	save := anEventFromCon component name asInteger.
	self playerViewController displayCurrentBoardState.
]

{ #category : 'Not categorized' }
HfuSpConnectFourPlayerView >> setGame: boardState [

|savedID thisID offset theBadge theNewBadge |

	offset := boardState boardHeight.

	1 to: boardState boardWidth do: [:eachColumn | 
		1 to: boardState boardHeight do:[:eachRow | 

		thisID:= ((boardState board at: eachColumn) at: eachRow). 
			thisID = -1
			ifFalse: [
				savedID isNil
					ifTrue: [savedID := thisID].
				theBadge := (self getFieldByRow: eachRow + offset Column: eachColumn).
				savedID = thisID
					ifTrue: [
						theBadge 
							removeAllCssClasses;
							addCssClass: MeCssMeBadge;
							addCssClassMBadge;
							setWideStyle;
							addCssClassMBadgePrimary;
							yourself]
					ifFalse: [
						theBadge
							removeAllCssClasses;
							addCssClass: MeCssMeBadge;
							addCssClassMBadge;
							setWideStyle;
							addCssClassMBadgeDanger;
							yourself.].
		].
		 offset := offset -2].
	offset := boardState boardHeight].
]

{ #category : 'Not categorized' }
HfuSpConnectFourPlayerView >> startGameClicked [
	
	"self initConnectFour."
	"self playerViewController displayCurrentBoardState."
	self playerViewController startGame.
	"self removeChild: startButton."
]

{ #category : 'Not categorized' }
HfuSpConnectFourPlayerView >> updateSite: updateSiteEvent [

	"Event for the timer to update the view"
	self playerViewController displayCurrentBoardState.
	"self removeChild: connectRows.
	self removeChild: connectFormPortlet."
	"self initConnectFour."
	
	"self addChild: (Me5Badge newWarning)."
]
