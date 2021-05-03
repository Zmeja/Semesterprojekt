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
HfuSpGameSessionsManager class >> addPlayerToSession: anPlayerIdInteger [

	"<^aHfuSpPlayerView>"
	"ads a Player to a currently ongoing Game and returns the view of newly added player"

	self
]

{ #category : 'API' }
HfuSpGameSessionsManager class >> createGameSession: aGameNameString [

	"<^anInteger> representing the GameSession "
	"creates a new session of a game with name aGameNameString (TicTacToe for example) 
	 and adds it to activeGameSessions"
	|newGameSession newGameSessionID|
	self activeGameSessions = nil
		ifTrue: [self activeGameSessions: Dictionary new ].
	aGameNameString = 'TicTacToe'
		ifTrue: [
			newGameSession:= HfuSpTurnStateController new.
			newGameSession initializeState.
			newGameSessionID:= self getNextGameID.
			self activeGameSessions add: ( Association new key: newGameSessionID value: newGameSession ).
			^newGameSessionID
			].

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
