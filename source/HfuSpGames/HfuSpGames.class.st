Class {
	#name : 'HfuSpGames',
	#superclass : 'Application',
	#category : 'HfuSpGames'
}

{ #category : 'Tonel-Metadata' }
HfuSpGames class >> startUp [

	"Starts the server automatically"
	| theHttpServer |
	HfuSpPlayer startUp.
	theHttpServer := (Me5SstHttpServer startUpHttpServerOnPort: '9009' serverApplicationClass: HfuSpLoginView).
	theHttpServer addViewClass: HfuSpLoginView;
	addViewClass: HfuSpLobbyView;
	addViewClass: HfuSpPlayerView;
	addViewClass: HfuSpTicTacToePlayerView;
	addViewClass: HfuSpManDontGetAngryPlayerView;
	addViewClass: HfuSpGameSessionLobbyRepresentationView;
	addViewClass: HfuSpPlayerView;
	addViewClass: HfuSpChatView;
		yourself
]
