Class {
	#name : 'HfuSpConnectFourPlayerView',
	#superclass : 'HfuSpPlayerView',
	#instVars : [
		'connectRows',
		'connectFormPortlet',
		'startButton'
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
			
	
			
self addChild: (Me5Timeout new addIntervalSeconds: 4 selector:#updateSite:; activate ;yourself).
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
					ifTrue: [(connectRows at: 1) addChild: (Me5Button newAirButton
						text: eachColumn asString;
						name: eachColumn asString;
						addClickEventSelector: #rowClicked:;
						yourself)].
					].
	
				Me5Section new.
			2 to: 7 do: [:eachRow | 
					1 to: 8 do: [:eachColumn | eachColumn < 8 
					ifTrue: [(connectRows at: eachRow) addChild: (Me5Badge new
						text: '.';
						"name: eachColumn asString;"
						yourself)].		
				].
			].
]

{ #category : 'Not categorized' }
HfuSpConnectFourPlayerView >> rowClicked: anEventFromCon [
	self playerViewController transmitOrder: anEventFromCon component name asInteger.
]

{ #category : 'Not categorized' }
HfuSpConnectFourPlayerView >> setGame: boardState [

	"<^self>"
	"Answer the receiver"

	self
]

{ #category : 'Not categorized' }
HfuSpConnectFourPlayerView >> startGameClicked [
	
	self playerViewController startGame.
	self removeChild: startButton.
	self initConnectFour.
]

{ #category : 'Not categorized' }
HfuSpConnectFourPlayerView >> updateSite: updateSiteEvent [


]
