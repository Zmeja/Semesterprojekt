Class {
	#name : 'HfuSpPlayerView',
	#superclass : 'Me5BaseView',
	#instVars : [
		'playerViewController',
		'addGameButton',
		'closeGamesButton',
		'sessionHolder',
		'tictactoeButton',
		'tictactoeViewButton',
		'manDontGetAngryButton',
		'connectFourButton'
	],
	#category : 'HfuSpGames'
}

{ #category : 'Not categorized' }
HfuSpPlayerView >> addConnectFourButtonClicked [
	|tempButton createdGameSession|
	createdGameSession := HfuSpGameSessionsManager createGameSession: 'ConnectFour'.
	tempButton := Me5Button newAirSecondary.
	tempButton text: ('Join ConnectFour', (createdGameSession asString)).
	tempButton name: createdGameSession asString.
	tempButton addClickEventSelector: #addConnectFourButtonClicked:.
	self sessionHolder addChildToBody:tempButton.
]

{ #category : 'Not categorized' }
HfuSpPlayerView >> addConnectFourButtonClicked: anPlayerAddEvent [
	|aGameView|
	aGameView := (HfuSpConnectFourPlayerViewController new createPlayerView).
	aGameView playerViewController player: self playerViewController player.
	aGameView playerViewController playerView: aGameView.
	aGameView playerViewController join: anPlayerAddEvent component name asInteger.
	self replaceView: aGameView.
	
]

{ #category : 'Not categorized' }
HfuSpPlayerView >> addGameButtonClicked [
	|tempButton createdGameSession|
	createdGameSession := HfuSpGameSessionsManager createGameSession: 'TicTacToe'.
	tempButton := Me5Button newAirSecondary.
	tempButton text: ('Join TicTacToe ', (createdGameSession asString)).
	tempButton name: createdGameSession asString.
	tempButton addClickEventSelector: #addPlayerButtonClicked:.
	self sessionHolder addChildToBody:tempButton.
]

{ #category : 'Not categorized' }
HfuSpPlayerView >> addManDontGetAngryButtonClicked [
	|tempButton createdGameSession|
	createdGameSession := HfuSpGameSessionsManager createGameSession: 'ManDontGetAngry'.
	tempButton := Me5Button newAirSecondary.
	tempButton text: ('Join ManDontGetAngry ', (createdGameSession asString)).
	tempButton name: createdGameSession asString.
	tempButton addClickEventSelector: #addManDontGetAngryButtonClicked:.
	self sessionHolder addChildToBody:tempButton.
]

{ #category : 'Not categorized' }
HfuSpPlayerView >> addManDontGetAngryButtonClicked: anPlayerAddEvent [
	|aGameView|
	aGameView := (HfuSpManDontGetAngryPlayerViewController new createPlayerView).
	aGameView playerViewController player: self playerViewController player.
	aGameView playerViewController playerView: aGameView.
	aGameView playerViewController join: anPlayerAddEvent component name asInteger.
	self replaceView: aGameView.
	
]

{ #category : 'Not categorized' }
HfuSpPlayerView >> addPlayerButtonClicked: anPlayerAddEvent [
	|aGameView|
	aGameView := (HfuSpTicTacToePlayerViewController new createPlayerView).
	aGameView playerViewController player: self playerViewController player.
	aGameView playerViewController playerView: aGameView.
	aGameView playerViewController join: anPlayerAddEvent component name asInteger.
	self replaceView: aGameView.
	
]

{ #category : 'Not categorized' }
HfuSpPlayerView >> addTicTacToeButtonClicked [
	
"	self
			addChild: (Me5ViewHolder new
			holdingView: HfuSpGameSessionLobbyRepresentationView new;
			yourself);
		yourself"
	
	|tempButton createdGameSession|
	createdGameSession := HfuSpGameSessionsManager createGameSession: 'TicTacToe'.
	tempButton := Me5Button newAirSecondary.
	tempButton text: ('Join TicTacToe ', (createdGameSession asString)).
	tempButton name: createdGameSession asString.
	tempButton addClickEventSelector: #addPlayerButtonClicked:.
	self sessionHolder addChildToBody:tempButton.
]

{ #category : 'Not categorized' }
HfuSpPlayerView >> addTicTacToeButtonClicked: anPlayerAddEvent [
	|aGameView|
	aGameView := (HfuSpTicTacToePlayerViewController new createPlayerView).
	aGameView playerViewController player: self playerViewController player.
	aGameView playerViewController playerView: aGameView.
	aGameView playerViewController join: anPlayerAddEvent component name asInteger.
	self replaceView: aGameView.
	
]

{ #category : 'Not categorized' }
HfuSpPlayerView >> addTicTacToeViewClicked [
	self
			addChild: (Me5ViewHolder new
			holdingView: HfuSpGameSessionLobbyRepresentationView new;
			yourself);
		yourself
]

{ #category : 'Not categorized' }
HfuSpPlayerView >> closeGamesClicked [

	HfuSpGameSessionsManager activeGameSessions: nil.
]

{ #category : 'Not categorized' }
HfuSpPlayerView >> createComponents [

	self playerViewController: HfuSpPlayerViewController new.
	self playerViewController setPlayerView: self.
	self sessionHolder: Me5Portlet new.
	self addChild: self sessionHolder.
	self updateSite.
	self addChild: (tictactoeButton := Me5Button newAirSecondary
					text: 'Create TicTacToe';
					addClickEventSelector: #addTicTacToeButtonClicked;
					yourself).
					
		self addChild: (tictactoeViewButton := Me5Button newAirSecondary
					text: 'Create TicTacToeViewTestButton';
					addClickEventSelector: #addTicTacToeViewClicked;
					yourself).
					
		self addChild: (manDontGetAngryButton := Me5Button newAirSecondary
					text: 'Create ManDontGetAngry';
					addClickEventSelector: #addManDontGetAngryButtonClicked;
					yourself).
	self addChild: (closeGamesButton := Me5Button newAirSecondary
					text: 'Force Close all Games';
					addClickEventSelector: #closeGamesClicked;
					yourself).
	self addChild: (Me5Timeout new addIntervalSeconds: 3 selector:#updateSite; activate ;yourself).
					
]

{ #category : 'Not categorized' }
HfuSpPlayerView >> displayBoardState: anBoardState [

	"<^self>"
	"displays a board State on Screen"

	self subclassResponsibility
]

{ #category : 'Accessing' }
HfuSpPlayerView >> initializeView [

	^self
]

{ #category : 'Accessing' }
HfuSpPlayerView >> playerViewController [

	"<^iOf aPlayerViewController>"
	"Answer the playerViewController of the receiver"

	^playerViewController
]

{ #category : 'Accessing' }
HfuSpPlayerView >> playerViewController: anaPlayerViewController [

	"<anaPlayerViewController: iOf aPlayerViewController, ^self>"
	"Set the playerViewController of the receiver"

	playerViewController := anaPlayerViewController
]

{ #category : 'Accessing' }
HfuSpPlayerView >> sessionHolder [

	^sessionHolder
]

{ #category : 'Accessing' }
HfuSpPlayerView >> sessionHolder: anObject [

	sessionHolder := anObject
]

{ #category : 'Not categorized' }
HfuSpPlayerView >> startUp [
	
	| theHttpServer |
	HfuSpPlayer startUp.
	theHttpServer := (Me5SstHttpServer startUpHttpServerOnPort: '9004' serverApplicationClass: HfuSpPlayerView).
	theHttpServer addViewClass: HfuSpPlayerView.
	theHttpServer addViewClass: HfuSpTicTacToePlayerView.
	theHttpServer addViewClass: HfuSpManDontGetAngryPlayerView;
	yourself
]

{ #category : 'Accessing' }
HfuSpPlayerView >> updateSite [
		
		self aboutToReplaceView.
		self sessionHolder removeAllChildrenFromBody.
		HfuSpGameSessionsManager listAllActiveSessions size >= 1
		ifTrue: [
		self playerViewController getAllActiveSessions do:[:eachSession| 
					| tempButton |
				    tempButton := Me5Button newAirSecondary.	
					(HfuSpGameSessionsManager getGameSessionById: eachSession) class = HfuSpTicTacToeTurnStateController 
					ifTrue:[tempButton text: ('Join TicTacToe ', (eachSession asString)).
							tempButton addClickEventSelector: #addTicTacToeButtonClicked:.].
							
					(HfuSpGameSessionsManager getGameSessionById: eachSession) class = HfuSpManDontGetAngryTurnStateController 
					ifTrue:[tempButton text: ('Join ManDontGetAngry ', (eachSession asString)).
							tempButton addClickEventSelector: #addManDontGetAngryButtonClicked:.].
							
					(HfuSpGameSessionsManager getGameSessionById: eachSession) class = HfuSpConnectFourTurnStateController  
					ifTrue:[tempButton text: ('Join ConnectFour ', (eachSession asString)).
							tempButton addClickEventSelector: #addConnectFourButtonClicked:.].
							
							
					
					tempButton name: eachSession.
					
					self sessionHolder addChildToBody: tempButton.
		]]
		ifFalse: [].
]
