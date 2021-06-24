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

{ #category : 'Internal' }
HfuSpPlayerView >> activateCreateGameView [

	self lobbyRepresentation createGameForm show.
	self lobbyRepresentation sessionForm hide.
]

{ #category : 'Internal' }
HfuSpPlayerView >> activateJoinGameView: anEvent [
	
	self lobbyRepresentation buildSessionForm: anEvent component name asInteger.
	self lobbyRepresentation sessionForm show.
	self lobbyRepresentation createGameForm hide.
]

{ #category : 'Internal' }
HfuSpPlayerView >> addGameButtonClicked: aForm [
	|tempID createdGameSession children|
	children := aForm portletBody.
	tempID := HfuSpGameSessionsManager createGameSession: (children firstChild value).
	createdGameSession := HfuSpGameSessionsManager getGameSessionById: tempID.
	createdGameSession name: ((children children at: 2) value).
	createdGameSession type: children firstChild value.
	self updateSite.
	^tempID.
	
]

{ #category : 'Internal' }
HfuSpPlayerView >> addPlayerButtonClicked: anIDOfaGame [
	|aGameView|
	aGameView:= HfuSpGameSessionsManager addPlayer: self playerViewController player id ToSession: anIDOfaGame.
	aGameView= nil ifTrue: [^nil].
	self replaceView: aGameView.
	
	
	
	
]

{ #category : 'Internal' }
HfuSpPlayerView >> announceVictor: aPlayerID [
	aPlayerID ~= -1
	ifTrue: [
	| winnerString |
	aPlayerID < 0
	ifTrue:[	winnerString := 'The Game  is a draw'. ] 
	ifFalse:[ winnerString := 'Player ', aPlayerID asString, ' won!'.].
	self showInfoNotificationWithMessage: winnerString.].

]

{ #category : 'Internal' }
HfuSpPlayerView >> closeGamesClicked [

	HfuSpGameSessionsManager activeGameSessions: nil.
]

{ #category : 'Initialization' }
HfuSpPlayerView >> createComponents [

	self playerViewController playerView: self.
	self sessionHolder: (Me5Portlet new
										addChildToHead: (Me5H5 newWithText: 'Games:');
										yourself).
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
	self addChild: (Me5Timeout new 
								addIntervalSeconds: 3 selector:#updateSite; 
								activate;
								yourself).
	self lobbyRepresentation: (HfuSpGameSessionLobbyRepresentationView new
													buildGameForm; 
													buildSessionForm:-1;
													yourself).
	self addChild: (Me5ViewHolder new
							holdingView: (self lobbyRepresentation);
							yourself).
					
]

{ #category : 'Internal' }
HfuSpPlayerView >> displayBoardState: anBoardState [

	"<^self>"
	"displays a board State on Screen"

	self subclassResponsibility
]

{ #category : 'Initialization' }
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

{ #category : 'Internal' }
HfuSpPlayerView >> removePlayerButtonClicked: anPlayerAddEvent [

	HfuSpGameSessionsManager  removeActiveGameSession:  anPlayerAddEvent.



	
	
]

{ #category : 'Accessing' }
HfuSpPlayerView >> sessionHolder [

	^sessionHolder
]

{ #category : 'Accessing' }
HfuSpPlayerView >> sessionHolder: anObject [

	sessionHolder := anObject
]

{ #category : 'Internal' }
HfuSpPlayerView >> updateSite [
		
		"updates main-lobby with all available game-lobbies"
		
		self sessionHolder removeAllChildrenFromBody.
		HfuSpGameSessionsManager listAllActiveSessions size >= 1
		ifTrue: [
		self playerViewController getAllActiveSessions do:[:eachSession| 
				  self sessionHolder addChildToBody: (Me5Button newAirSecondary
												text: ((HfuSpGameSessionsManager getGameSessionById: eachSession) name);
												addClickEventSelector: #activateJoinGameView:;
												name:eachSession;
												yourself).
		]]
		ifFalse: [].
]
