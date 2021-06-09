Class {
	#name : 'HfuSpConnectFourPlayerView',
	#superclass : 'HfuSpPlayerView',
	#instVars : [
		'connectRows',
		'connectFormPortlet'
	],
	#category : 'HfuSpConnectFour'
}

{ #category : 'Not categorized' }
HfuSpConnectFourPlayerView >> createComponents [

	 connectRows:= OrderedCollection new.
	
	self	renderBaseGameState.
	self playerViewController displayCurrentBoardState.
	self addChild: (Me5Timeout new addIntervalSeconds: 3 selector:#updateSite:; activate ;yourself).
]

{ #category : 'Not categorized' }
HfuSpConnectFourPlayerView >> renderBaseGameState [

	self
		addChild: (connectFormPortlet := Me5FormPortlet new
			title:'ConnectFour!';
			yourself);
					
	yourself.
			
			1 to: 8 do: [:eachNumber | connectFormPortlet addChildToBody: (connectRows add: (Me5Div new))].
			Me5Section new.
			
			1 to: 8 do: [:eachColumn | eachColumn < 8 
					ifTrue: [(connectRows at: 1) addChild: (Me5Button newAirButton
						text: eachColumn asString;
						name: eachColumn asString;
						addClickEventSelector: #rowClicked:;
						yourself)].
					].
	
				Me5Section new.
			2 to: 8 do: [:eachRow | 
					1 to: 8 do: [:eachColumn | eachColumn < 8 
					ifTrue: [(connectRows at: eachRow) addChild: (Me5Badge new
						text: eachColumn asString;
						yourself)].		
				].
			].
]

{ #category : 'Not categorized' }
HfuSpConnectFourPlayerView >> rowClicked: anEventFromCon [
	self showInfoNotificationWithMessage:  'row was clicked'.
	self playerViewController transmitOrder: anEventFromCon component name asInteger.
]

{ #category : 'Not categorized' }
HfuSpConnectFourPlayerView >> setGame: boardState [

	"<^self>"
	"Answer the receiver"

	self
]

{ #category : 'Not categorized' }
HfuSpConnectFourPlayerView >> updateSite: updateSiteEvent [
	"
	todo
	self removeChild: connectRows.
	self removeChild: connectFormPortlet."
]
