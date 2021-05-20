Class {
	#name : 'HfuSpManDontGetAngryPlayerView',
	#superclass : 'HfuSpPlayerView',
	#instVars : [
		'boardPortlet',
		'boardRows',
		'boardRowElements'
	],
	#category : 'HfuSpGames'
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

{ #category : 'Not categorized' }
HfuSpManDontGetAngryPlayerView >> createComponents [

	boardRows := OrderedCollection  new.
	boardRowElements := Dictionary new.
	1 to: 11 do: [:eachNumber | boardRowElements at: eachNumber put: OrderedCollection new].
	self 
		addChild: (Me5Label new
			text: 'Mensch Ärgere dich nicht';
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
		]
		"Initialize row 5"
		
]

{ #category : 'Not categorized' }
HfuSpManDontGetAngryPlayerView >> createTable [

		^Me5Table new
		addChildToHead: (Me5TableRow new
			addTableHeaderWithText: '0';
			addTableHeaderWithText: '1';
			addTableHeaderWithText: '2';
			addTableHeaderWithText: '3';
			yourself);
		addChildToBody: (Me5TableRow new
			addTableDataWithChild: (Me5Badge new
				text: ' ';
				yourself);
		addTableDataWithChild: (Me5Badge new
				text: ' ';
				yourself);
		addTableDataWithChild: (Me5Badge new
				text: ' ';
				yourself);
			yourself);
		addChildToBody: (Me5TableRow new
			addTableDataWithChild: (Me5Badge new
				text: ' ';
				yourself);
			addTableDataWithChild: (Me5Label new);
			yourself);
		yourself
]
