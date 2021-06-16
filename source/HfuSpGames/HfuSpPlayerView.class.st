Class {
	#name : 'HfuSpPlayerView',
	#superclass : 'Me5BaseView',
	#instVars : [
		'playerViewController',
		'addGameButton',
		'closeGamesButton',
		'sessionHolder',
		'createGameButton',
		'lobbyRepresentation'
	],
	#category : 'HfuSpGames'
}

{ #category : 'Not categorized' }
HfuSpPlayerView >> activateCreateGameView [

	self lobbyRepresentation: (HfuSpGameSessionLobbyRepresentationView new createGameForm;yourself).
	self
			addChild: (Me5ViewHolder new
			holdingView: (self lobbyRepresentation);
			yourself);
		yourself
]

{ #category : 'Not categorized' }
HfuSpPlayerView >> activateJoinGameView: anEvent [
	
	self lobbyRepresentation: (HfuSpGameSessionLobbyRepresentationView new 
									createSessionForm: anEvent component name asInteger;yourself).
	self
			addChild: (Me5ViewHolder new
			holdingView: (self lobbyRepresentation);
			yourself);
		yourself
]

{ #category : 'Not categorized' }
HfuSpPlayerView >> addGameButtonClicked: aForm [
	|tempID createdGameSession children|
	children := aForm portletBody.
	children firstChild value= 'TicTacToe'
		ifTrue: [tempID := HfuSpGameSessionsManager createGameSession: 'TicTacToe'.].
	children firstChild value = 'Man Dont Get Angry'
		ifTrue: [tempID := HfuSpGameSessionsManager createGameSession: 'ManDontGetAngry'.].
	children firstChild value = 'Connect Four'
		ifTrue: [tempID := HfuSpGameSessionsManager createGameSession: 'ConnectFour'.].
	createdGameSession := HfuSpGameSessionsManager getGameSessionById: tempID.
	createdGameSession name: ((children children at: 2) value).
	createdGameSession type: children firstChild value.
	self lobbyRepresentation gameType: children firstChild value.
	self updateSite.
	^tempID.
	
]

{ #category : 'Not categorized' }
HfuSpPlayerView >> addPlayerButtonClicked: anPlayerAddEvent [
	|aGameView gameType|
	aGameView:= HfuSpGameSessionsManager addPlayer: self playerViewController player id ToSession: anPlayerAddEvent.
	aGameView= nil ifTrue: [^nil].
	self replaceView: aGameView.
	
	
	
]

{ #category : 'Not categorized' }
HfuSpPlayerView >> announceVictor: aPlayerID [
	aPlayerID ~= -1
	ifTrue: [
	| winnerString |
	aPlayerID < 0
	ifTrue:[	winnerString := 'The Game  is a draw'. ] 
	ifFalse:[ winnerString := 'Player ', aPlayerID asString, ' won!'.].
	self showInfoNotificationWithMessage: winnerString.].

]

{ #category : 'Not categorized' }
HfuSpPlayerView >> closeGamesClicked [

	HfuSpGameSessionsManager activeGameSessions: nil.
]

{ #category : 'Not categorized' }
HfuSpPlayerView >> createComponents [

	self playerViewController playerView: self.
	self sessionHolder: Me5Portlet new.
	self addChild: self sessionHolder.
	self updateSite.
		self addChild: (createGameButton := Me5Button newAirSecondary
					text: 'Create Game';
					addClickEventSelector: #activateCreateGameView;
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
HfuSpPlayerView >> lobbyRepresentation [

	^lobbyRepresentation
]

{ #category : 'Accessing' }
HfuSpPlayerView >> lobbyRepresentation: anObject [

	lobbyRepresentation := anObject
]

{ #category : 'Not categorized' }
HfuSpPlayerView >> player [

	^self playerViewController player
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

{ #category : 'Not categorized' }
HfuSpPlayerView >> removePlayerButtonClicked: anPlayerAddEvent [
	|aGameView gameType|

	HfuSpGameSessionsManager  removeActiveGameSession:  anPlayerAddEvent.
	self resetView.



	
	
]

{ #category : 'Not categorized' }
HfuSpPlayerView >> resetView [

	"<^self>"
	"rebuilds view as if side was just opened.
	 ->removes GameSessionReresentationViews"
	
	"Muss mit Containern gelÃƒÂ¶st werden"

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

{ #category : 'Not categorized' }
HfuSpPlayerView >> updateSite [
		
		self aboutToReplaceView.
		self sessionHolder removeAllChildrenFromBody.
		HfuSpGameSessionsManager listAllActiveSessions size >= 1
		ifTrue: [
		self playerViewController getAllActiveSessions do:[:eachSession| 
					| tempButton |
				    tempButton := Me5Button newAirSecondary.	
					(HfuSpGameSessionsManager getGameSessionById: eachSession) class = HfuSpTicTacToeTurnStateController 
					ifTrue:[tempButton text: ((HfuSpGameSessionsManager getGameSessionById: eachSession) name).
							tempButton addClickEventSelector: #activateJoinGameView:.].
							
					(HfuSpGameSessionsManager getGameSessionById: eachSession) class = HfuSpManDontGetAngryTurnStateController 
					ifTrue:[tempButton text: ((HfuSpGameSessionsManager getGameSessionById: eachSession) name).
							tempButton addClickEventSelector: #activateJoinGameView:.].
							
					(HfuSpGameSessionsManager getGameSessionById: eachSession) class = HfuSpConnectFourTurnStateController  
					ifTrue:[tempButton text: ((HfuSpGameSessionsManager getGameSessionById: eachSession) name).
							tempButton addClickEventSelector: #activateJoinGameView:.].
					tempButton name: eachSession.
					self sessionHolder addChildToBody: tempButton.
		]]
		ifFalse: [].
]
