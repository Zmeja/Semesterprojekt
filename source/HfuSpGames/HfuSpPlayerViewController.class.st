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
	self playerView setGame: (self currentBoardState)
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
		ifTrue:[self createPlayerView].
	^self playerView.
]

{ #category : 'Internal' }
HfuSpPlayerViewController >> isActingPlayer [

	"<^iOf Boolean>"
	"Answer the isActingPlayer of the receiver"

	self currentBoardState = nil 
	ifFalse: [^(self currentBoardState turnOrder first id )= (self player id) ].
	^(self currentBoardState turnOrder first id) = self player id.
	
	
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
	"Answer the playerView of the receiver"

	^playerView
]

{ #category : 'API' }
HfuSpPlayerViewController >> playerView: anaPlayerView [

	"<anaPlayerView: iOf aPlayerView, ^self>"
	"Set the playerView of the receiver"

	playerView := anaPlayerView
]

{ #category : 'API' }
HfuSpPlayerViewController >> startGame [

	"<^self>"
	"tells the controlled view to display the games vicror"

		self turnStateController startGame
]

{ #category : 'API' }
HfuSpPlayerViewController >> transmitOrder: aField [

	"<^self>"
	"Answer the receiver"
	self subclassResponsibility
]

{ #category : 'API' }
HfuSpPlayerViewController >> turnStateController [

	"<^iOf HfuSpTurnStateController>"
	"Answer the turnStateController of the receiver"

	^turnStateController
]

{ #category : 'API' }
HfuSpPlayerViewController >> turnStateController: aHfuSpTurnStateController [

	"<aHfuSpTurnStateController: iOf HfuSpTurnStateController, ^self>"
	"Set the turnStateController of the receiver"

	turnStateController := aHfuSpTurnStateController
]
