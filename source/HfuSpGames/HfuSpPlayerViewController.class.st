Class {
	#name : 'HfuSpPlayerViewController',
	#superclass : 'Object',
	#instVars : [
		'player',
		'currentBoardState',
		'turnStateController',
		'playerView'
	],
	#category : 'HfuSpGames'
}

{ #category : 'API' }
HfuSpPlayerViewController >> announceVictor: aPlayer [

	"<^self>"
	"tells the controlled view to display the games vicror"

		self playerView announceVictor: aPlayer.
]

{ #category : 'Internal' }
HfuSpPlayerViewController >> createPlayerView [

	"<^anPlayerView>"
	"returns the Player View managed by this PlayerViewController"

	self subclassResponsibility.
]

{ #category : 'API' }
HfuSpPlayerViewController >> currentBoardState [

	"<^iOf HfuSpBoardState>"
	"Answer the currentBoardState of the receiver"

	^currentBoardState
]

{ #category : 'API' }
HfuSpPlayerViewController >> currentBoardState: aHfuSpBoardState [

	"<aHfuSpBoardState: iOf HfuSpBoardState, ^self>"
	"Set the currentBoardState of the receiver"

	currentBoardState := aHfuSpBoardState
]

{ #category : 'API' }
HfuSpPlayerViewController >> displayCurrentBoardState [

	"tells view to display the Boardstate currently continaed in this PlayerViewController"
	self currentBoardState = nil
		ifTrue: [self currentBoardState: self turnStateController currentBoardState].
	self playerView setGame: self currentBoardState
]

{ #category : 'API' }
HfuSpPlayerViewController >> getAllActiveSessions [

	^HfuSpGameSessionsManager listAllActiveSessions
]

{ #category : 'API' }
HfuSpPlayerViewController >> getPlayerView [

	"<^anPlayerView>"
	"returns the Player View managed by this PlayerViewController"

	self playerView = nil
		ifTrue: [self createPlayerView].
	^self playerView.
]

{ #category : 'Internal' }
HfuSpPlayerViewController >> isActingPlayer [

	"<^iOf Boolean>"
	"returns id of active player
	 The active player is the player that may make a move"
	
	^(self currentBoardState getActingPlayerId) = self player id.
	
	
]

{ #category : 'API' }
HfuSpPlayerViewController >> player [

	^player
]

{ #category : 'API' }
HfuSpPlayerViewController >> player: anPlayer [

	player := anPlayer
]

{ #category : 'API' }
HfuSpPlayerViewController >> playerView [

	"<^iOf aPlayerView>"
	"Answer the playerView managed by this Controller"

	^playerView
]

{ #category : 'API' }
HfuSpPlayerViewController >> playerView: aPlayerView [

	"<aPlayerView: iOf aPlayerView, ^self>"
	"Set the playerView of the receiver"

	playerView := aPlayerView
]

{ #category : 'API' }
HfuSpPlayerViewController >> startGame [

	"<^self>"
	"tells the turn state controller to start the game"

		self turnStateController startGame
]

{ #category : 'API' }
HfuSpPlayerViewController >> transmitOrder: aField [

	"<^self>"
	"transmits a order from a view to the TurnStateController"
	self subclassResponsibility
]

{ #category : 'API' }
HfuSpPlayerViewController >> turnStateController [

	"<^iOf HfuSpTurnStateController>"
	"Answer the turnStateController which manages the game"

	^turnStateController
]

{ #category : 'API' }
HfuSpPlayerViewController >> turnStateController: aHfuSpTurnStateController [

	"<aHfuSpTurnStateController: iOf HfuSpTurnStateController, ^self>"
	"Set the turnStateController of the receiver"

	turnStateController := aHfuSpTurnStateController
]
