Class {
	#name : 'HfuSpLobbyView',
	#superclass : 'Me5BaseView',
	#instVars : [
		'lobbyViewController',
		'sessionHolder',
		'holdingView'
	],
	#category : 'HfuSpGames'
}

{ #category : 'Not categorized' }
HfuSpLobbyView >> createComponents [

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
			
yourself
		
		



	

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
