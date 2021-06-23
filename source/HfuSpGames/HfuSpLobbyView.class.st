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

	|theTable thePlayer chatView|
	thePlayer := HfuSpPlayer addPlayerIfAbsent: (self userDataDictionary).
	self
	addChild:(Me5Portlet new
	title: 'Lobby';		
	addChildToHead: (Me5Img newImgResponsive
		src: (self userDataDictionary at: 'picture');
		yourself);
		addChildToBody: (Me5Section new
			title: 'Games:';
			addChildToBody:(Me5Row new
				addChild: (Me5ViewHolder new
					holdingView: (HfuSpPlayerView new playerViewController: 
											(HfuSpPlayerViewController new player: thePlayer ; yourself)
											;yourself)
					yourself);
						
				addChild:  Me5SectionSeparator new;
				addChild:  Me5SectionSeparator new;
				addChild: (Me5ViewHolder new
					holdingView: (chatView := HfuSpChatView new
						username: thePlayer playerName;
						yourself);
					yourself);
				yourself);
			yourself);
		yourself);
yourself.
HfuSpChatView addChatUser: chatView.
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
HfuSpLobbyView >> updateSite [

	""
]

{ #category : 'Not categorized' }
HfuSpLobbyView >> userDataDictionary [

	^userDataDictionary
]

{ #category : 'Not categorized' }
HfuSpLobbyView >> userDataDictionary: anObject [

	userDataDictionary := anObject
]
