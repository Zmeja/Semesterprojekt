Class {
	#name : 'HfuSpManDontGetAngryPlayerView',
	#superclass : 'HfuSpPlayerView',
	#instVars : [
		'boardPortlet',
		'boardRows',
		'boardIndexBadgeMap'
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

{ #category : 'Accessing' }
HfuSpManDontGetAngryPlayerView >> boardIndexBadgeMap [

	^boardIndexBadgeMap
]

{ #category : 'Accessing' }
HfuSpManDontGetAngryPlayerView >> boardIndexBadgeMap: anObject [

	boardIndexBadgeMap := anObject
]

{ #category : 'Not categorized' }
HfuSpManDontGetAngryPlayerView >> colorBadge: aBadge playerNumber: anInteger [

"Changes the color of the badge parameter to the color of the given player number where: 
	0 = empty field
	1 = blue
	2 = red
	3 = green
	4 = yellow"
	anInteger = 0
		ifTrue: [aBadge addCssClassMBadgePrimary].
	anInteger = 1
		ifTrue: [aBadge addCssClassMBadgeInfo].
	anInteger = 2
		ifTrue: [aBadge addCssClassMBadgeDanger].
	anInteger = 3
		ifTrue: [aBadge addCssClassMBadgeSuccess].
	anInteger = 4
		ifTrue: [aBadge addCssClassMBadgeWarning]
]

{ #category : 'Not categorized' }
HfuSpManDontGetAngryPlayerView >> colorBadgeAtIndex: anInteger toPlayerNumber: aPlayerNumber [

"Sets the color of the field at Index anInteger to the corresponding player number"
	self colorBadge: (self boardIndexBadgeMap at: anInteger) playerNumber: aPlayerNumber.
]

{ #category : 'Not categorized' }
HfuSpManDontGetAngryPlayerView >> createComponents [

	boardRows := OrderedCollection  new.
	self 
		addChild: (Me5Label new
			text: 'Man, dont be angry';
			yourself);
		addChild: (boardPortlet := Me5Portlet new).
		1 to: 11 do: [:eachNumber | boardPortlet addChildToBody: (boardRows add: (Me5Div new))].
		"Initialize the first row"
		1 to: 11 do: [:eachColumn | eachColumn < 5 
			ifTrue: [(boardRows at: 1) addChild: (Me5Badge new
				text: ' ';
				yourself)].
			(eachColumn between: 5 and: 7) 
			ifTrue: [(boardRows at: 1) addChild:(Me5Badge newPrimary
				text: ' ';
				yourself)].
			eachColumn > 7 
			ifTrue: [(boardRows at:1) addChild: (Me5Badge new
				text: ' ';
				yourself)].
			].
		"Initialize row 2 - 4"
		2 to: 4 do: [:eachRow | 
			1 to: 4 do: [:eachColumn | (boardRows at: eachRow) addChild:(Me5Badge new
				text: ' ';
				yourself).].
			(boardRows at: eachRow) addChild: (Me5Badge newPrimary
				text: ' ';
				yourself).
			(boardRows at: eachRow) addChild: (Me5Badge newInfo
				text: ' ';
				yourself).
			(boardRows at: eachRow) addChild: (Me5Badge newPrimary
				text: ' ';
				yourself).
			1 to: 4 do: [:eachColumn | (boardRows at: eachRow) addChild:(Me5Badge new
				text: ' ';
				yourself).].
		].
		"Initialize row 5"
		1 to: 5 do: [:eachColumn | (boardRows at: 5) addChild: (Me5Badge newPrimary
			text: ' ';
			yourself).].
		(boardRows at: 5) addChild: (Me5Badge newInfo
			text: ' ';
			yourself).
		7 to: 11 do: [:eachColumn | (boardRows at: 5) addChild: (Me5Badge newPrimary
			text: ' ';
			yourself).].
		"Initialize row 6"
		(boardRows at: 6) addChild: (Me5Badge newPrimary
			text: ' ';
			yourself).
		2 to: 5 do: [:eachColumn | (boardRows at: 6) addChild: (Me5Badge newWarning
			text: ' ';
			yourself)]. 
		(boardRows at: 6) addChild: (Me5Badge new
			text: ' ';
			yourself).
		7 to: 10 do: [:eachColumn | (boardRows at: 6) addChild: (Me5Badge newDanger
			text: ' ';
			yourself)].
		(boardRows at: 6) addChild: (Me5Badge newPrimary
				text: ' ';
				yourself).
		"Initialize row 7"
		1 to: 5 do: [:eachColumn | (boardRows at: 7) addChild: (Me5Badge newPrimary
			text: ' ';
			yourself).].
		(boardRows at: 7) addChild: (Me5Badge newSuccess
			text: ' ';
			yourself).
		7 to: 11 do: [:eachColumn | (boardRows at: 7) addChild: (Me5Badge newPrimary
			text: ' ';
			yourself).].
		"Initialize rows 8 to 10"
		8 to: 10 do: [:eachRow | 
			1 to: 4 do: [:eachColumn | (boardRows at: eachRow) addChild:(Me5Badge new
				text: ' ';
				yourself).].
			(boardRows at: eachRow) addChild: (Me5Badge newPrimary
				text: ' ';
				yourself).
			(boardRows at: eachRow) addChild: (Me5Badge newSuccess
				text: ' ';
				yourself).
			(boardRows at: eachRow) addChild: (Me5Badge newPrimary
				text: ' ';
				yourself).
			1 to: 4 do: [:eachColumn | (boardRows at: eachRow) addChild:(Me5Badge new
				text: ' ';
				yourself).].
		].
		"Initialize row 11"
		1 to: 11 do: [:eachColumn | eachColumn < 5 
			ifTrue: [(boardRows at: 11) addChild: (Me5Badge new
				text: ' ';
				yourself)].
			(eachColumn between: 5 and: 7) 
			ifTrue: [(boardRows at: 11) addChild:(Me5Badge newPrimary
				text: ' ';
				yourself)].
			eachColumn > 7 
			ifTrue: [(boardRows at:11) addChild: (Me5Badge new
				text: ' ';
				yourself)].
			].
		self initializeBoardIndexMap.
		"self colorBadgeAtIndex: 40 toPlayerNumber: 3"
]

{ #category : 'Internal' }
HfuSpManDontGetAngryPlayerView >> getFieldByRow: aRow Column: aColumn [

"Returns the Field specified by the coordinates."
	^((boardRows at: aRow) childAt: aColumn)
]

{ #category : 'Not categorized' }
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
HfuSpManDontGetAngryPlayerView >> setGame: aBoard [

	^true.

	
]
