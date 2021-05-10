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
HfuSpGameSessionsManager class >> addPlayer: anPlayerIdInteger ToSession: anGameSessionIdInteger [

	"<^aHfuSpPlayerView>"
	"ads a Player to a currently ongoing Game and returns the view of newly added player"
	|gameTurnStateController playerViewController playerView|
	gameTurnStateController:=self getGameSessionById: anGameSessionIdInteger.
	gameTurnStateController= nil
		ifTrue:[^nil].
	(gameTurnStateController containsPlayer: anPlayerIdInteger = true)
		ifTrue:[^nil].
	playerViewController := gameTurnStateController createPlayer: anPlayerIdInteger.
	playerView:= playerViewController getPlayerView.
	playerView  initialize.
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
	|currentID|
	currentID:= self iDOfNextGame.
	(currentID = nil)
		ifTrue: [
		self iDOfNextGame: 0.
		^0].
	self iDOfNextGame:  (currentID+1).
	^currentID
]

{ #category : 'Accessing' }
HfuSpGameSessionsManager class >> iDOfNextGame [

	"<^iOf Integer>"
	"Answer the IDOfNextGame of the receiver"

	^IDOfNextGame
]

{ #category : 'Accessing' }
HfuSpGameSessionsManager class >> iDOfNextGame: anInteger [

	"<anInteger: iOf Integer, ^self>"
	"Set the IDOfNextGame of the receiver"

	IDOfNextGame := anInteger
]

{ #category : 'API' }
HfuSpGameSessionsManager class >> listAllActiveSessions [

	"<^aCollection> "
	"returns a list of  all active game session Ids "

	^self activeGameSessions keys asOrderedCollection
]

{ #category : 'API' }
HfuSpGameSessionsManager class >> removeActiveGameSession: aGameSessionIdInteger [

	"<^selfr>"
	"removes a HfuSpTurnstateController from the list of  active Sessions."

	self activeGameSessions removeKey: aGameSessionIdInteger.
]
