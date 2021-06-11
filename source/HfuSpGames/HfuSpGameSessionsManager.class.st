Class {
	#name : 'HfuSpGameSessionsManager',
	#superclass : 'Object',
	#classVars : [
		'IDOfNextGame',
		'ActiveGameSessions'
	],
	#classInstVars : [
		'sessions'
	],
	#category : 'HfuSpGames'
}

{ #category : 'Accessing' }
HfuSpGameSessionsManager class >> activeGameSessions [

	"<^iOf aOrderedCollection>"
	"Answer the ActiveGameSessions of the receiver"

	^ActiveGameSessions
]

{ #category : 'Accessing' }
HfuSpGameSessionsManager class >> activeGameSessions: anDictionary [

	"<anaOrderedCollection: iOf aOrderedCollection, ^self>"
	"Set the ActiveGameSessions of the receiver"

	ActiveGameSessions := anDictionary
]

{ #category : 'API' }
HfuSpGameSessionsManager class >> addPlayer: anPlayer ToSession: anGameSessionIdInteger [

	"<^aHfuSpPlayerView>"
	"ads a Player to a currently ongoing Game and returns the view of newly added player"
	|gameTurnStateController playerViewController playerView|
	gameTurnStateController:=self getGameSessionById: anGameSessionIdInteger.
	gameTurnStateController= nil
		ifTrue:[^nil].
	(gameTurnStateController containsPlayer: anPlayer)= true
		ifTrue:[^nil].
	(gameTurnStateController gameOngoing = -1)
		ifFalse:[^nil].
	playerViewController := gameTurnStateController createPlayer: (HfuSpPlayer players at: (anPlayer)).																				
	playerView:= playerViewController getPlayerView.
	playerViewController playerView: playerView.
	playerView  initializeView.
	^playerView.
]

{ #category : 'API' }
HfuSpGameSessionsManager class >> createGameSession: aGameNameString [

	"<^anInteger> representing the GameSession "
	"creates a new session of a game with name aGameNameString (TicTacToe for example) 
	 and adds it to activeGameSessions. this game is then identifyable with its id which is returned as integer."
	|newGameSession newGameSessionID|
	self activeGameSessions = nil
		ifTrue: [self activeGameSessions: Dictionary new ].
	aGameNameString = 'TicTacToe'
		ifTrue: [
			newGameSession:= HfuSpTicTacToeTurnStateController new.
			newGameSession initializeState.
			newGameSessionID:= self getNextGameID.
			self activeGameSessions add: ( Association new key: newGameSessionID value: newGameSession ).
			^newGameSessionID
			].
		aGameNameString = 'ConnectFour'
		ifTrue: [
			newGameSession:= HfuSpConnectFourTurnStateController new.
			newGameSession initializeState.
			newGameSessionID:= self getNextGameID.
			self activeGameSessions add: ( Association new key: newGameSessionID value: newGameSession ).
			^newGameSessionID
			].
			
			aGameNameString = 'ManDontGetAngry'
		ifTrue: [
			newGameSession:= HfuSpManDontGetAngryTurnStateController new.
			newGameSession initializeState.
			newGameSessionID:= self getNextGameID.
			self activeGameSessions add: ( Association new key: newGameSessionID value: newGameSession ).
			^newGameSessionID
			].


]

{ #category : 'API' }
HfuSpGameSessionsManager class >> getGameSessionById: anGameIdInteger [

	"<^aHfuSpTurnStateController>"
	"Checks if there is a ongoing Game Session with the correct ID.
	If there is a Game Session its TurnStateController is Returned."

	^self  activeGameSessions at:  anGameIdInteger
]

{ #category : 'Internal' }
HfuSpGameSessionsManager class >> getNextGameID [

	"<^anInteger>"
	"returns id which identifies the next game that will be started
	 and increments IDOFNextGame"
	self iDOfNextGame = nil
		ifTrue: [
		IDOfNextGame:=-1.].
	IDOfNextGame := IDOfNextGame + 1.
	^self iDOfNextGame.
]

{ #category : 'Accessing' }
HfuSpGameSessionsManager class >> iDOfNextGame [

	"<^iOf Integer>"
	"Answer the IDOfNextGame of the receiver"

	^IDOfNextGame
]

{ #category : 'API' }
HfuSpGameSessionsManager class >> listAllActiveSessions [

	"<^aCollection> "
	"returns a list of  all active game session Ids "
	self activeGameSessions = nil
	ifTrue:[Dictionary new]
	ifFalse:[^self activeGameSessions keys asOrderedCollection].
]

{ #category : 'API' }
HfuSpGameSessionsManager class >> removeActiveGameSession: aGameSessionIdInteger [

	"<^selfr>"
	"removes a HfuSpTurnstateController from the list of  active Sessions."

	self activeGameSessions removeKey: aGameSessionIdInteger.
]
