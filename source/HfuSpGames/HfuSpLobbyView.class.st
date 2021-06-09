Class {
	#name : 'HfuSpLobbyView',
	#superclass : 'Me5BaseView',
	#instVars : [
		'lobbyViewController',
		'sessionHolder',
		'holdingView',
		'userDataDictionary'
	],
	#category : 'HfuSpGames'
}

{ #category : 'Not categorized' }
HfuSpLobbyView >> createComponents [

	|theTable|
	self
	addChild:(Me5Portlet new
	title: 'Lobby';		
		addChildToBody: (Me5Section new
			title: 'Games:';
			
			addChildToBody:(Me5Row new
				addChild: (Me5ViewHolder new
					holdingView: HfuSpPlayerView new;
					yourself);
						
				addChild:  Me5SectionSeparator new;
				
			"	addChild: (Me5ViewHolder new
					holdingView: (HfuSpGameSessionLobbyRepresentationView new
						gameID: '3013101';
						gameType: 'TicTacToe';
						yourself);
					yourself);"
					
				addChild:  Me5SectionSeparator new;
				
				addChild: (Me5ViewHolder new
					holdingView: (HfuSpChatView new
						yourself);
					yourself);
				yourself);
			yourself);
		yourself);
		
			
yourself.
self userDataDictionary notNil
			ifTrue: [self
			addChild: (Me5Portlet new
				text: 'Your Personal Data';
				addChildToBody: (Me5Row new
					addChild: (Me5Div new
						addCssClassCol12;
						addCssClassColLg9;
						addChild: (theTable:= Me5Table new
							addCssClassTableBordered;
							addChildToHead: (Me5TableRow new
								addTableHeaderWithText: 'Attribute';
								addTableHeaderWithText: 'Value';
								yourself);
							yourself);
						yourself);
					addChild: (Me5Div new
						addCssClassCol12;
						addCssClassColLg3;
						addChild: (Me5Img newImgResponsive
							src: (self userDataDictionary at: 'picture');
							yourself);
						yourself);
					yourself);
				yourself).
			self userDataDictionary keysAndValuesDo: [ :eachKey :eachValue |
				theTable addChildToBody: (Me5TableRow new 
					addTableDataWithText: eachKey;
					addTableDataWithText: eachValue;
					yourself)]]
		



	

]

{ #category : 'Not categorized' }
HfuSpLobbyView >> holdingView [

	^holdingView
]

{ #category : 'Not categorized' }
HfuSpLobbyView >> holdingView: anObject [

	holdingView := anObject
]

{ #category : 'Not categorized' }
HfuSpLobbyView >> lobbyViewController [

	^lobbyViewController
]

{ #category : 'Not categorized' }
HfuSpLobbyView >> lobbyViewController: anaLobbyViewController [

	lobbyViewController := anaLobbyViewController
]

{ #category : 'Not categorized' }
HfuSpLobbyView >> sessionHolder [

	^sessionHolder
]

{ #category : 'Not categorized' }
HfuSpLobbyView >> sessionHolder: anObject [

	sessionHolder := anObject
]

{ #category : 'Not categorized' }
HfuSpLobbyView >> startUp [
	
	| theHttpServer |
	"HfuSpPlayer startUp."
	theHttpServer := (Me5SstHttpServer startUpHttpServerOnPort: '9009' serverApplicationClass: HfuSpLobbyView).
	theHttpServer addViewClass: HfuSpLobbyView.
	theHttpServer addViewClass: HfuSpGameSessionLobbyRepresentationView.
	theHttpServer addViewClass: HfuSpPlayerView.
	theHttpServer addViewClass: HfuSpChatView;
	yourself
]

{ #category : 'Not categorized' }
HfuSpLobbyView >> userDataDictionary [

	^userDataDictionary
]

{ #category : 'Not categorized' }
HfuSpLobbyView >> userDataDictionary: anObject [

	userDataDictionary := anObject
]
