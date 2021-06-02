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

{ #category : 'Accessing',
 #vaCategories : ['Accessing','ViewNotifying'] }
HfuSpPlayerViewController >> announceVictor: aPlayer [

	"<^self>"
	"tells the controlled view to display the games vicror"

		self playerView announceVictor: aPlayer.
]

{ #category : 'Not categorized' }
HfuSpPlayerViewController >> createPlayerView [

	"<^anPlayerView>"
	"returns the Player View managed by this PlayerViewController"

	self subclassResponsibility.
]

{ #category : 'Accessing' }
HfuSpPlayerViewController >> currentBoardState [

	"<^iOf HfuSpBoardState>"
	"Answer the currentBoardState of the receiver"

	^currentBoardState
]

{ #category : 'Accessing' }
HfuSpPlayerViewController >> currentBoardState: aHfuSpBoardState [

	"<aHfuSpBoardState: iOf HfuSpBoardState, ^self>"
	"Set the currentBoardState of the receiver"

	currentBoardState := aHfuSpBoardState
]

{ #category : 'Not categorized' }
HfuSpPlayerViewController >> displayCurrentBoardState [

	"tells view to display the Boardstate currently continaed in this PlayerViewController"
	self currentBoardState = nil
		ifTrue: [self currentBoardState: self turnStateController currentBoardState].
	self playerView setGame: (self currentBoardState)
]

{ #category : 'Not categorized' }
HfuSpPlayerViewController >> getAllActiveSessions [

	^HfuSpGameSessionsManager listAllActiveSessions
]

{ #category : 'Accessing' }
HfuSpPlayerViewController >> getPlayerView [

	"<^anPlayerView>"
	"returns the Player View managed by this PlayerViewController"

	self playerView = nil
		ifTrue:[self createPlayerView].
	^self playerView.
]

{ #category : 'Accessing' }
HfuSpPlayerViewController >> isActingPlayer [

	"<^iOf Boolean>"
	"Answer the isActingPlayer of the receiver"

	self currentBoardState = nil 
	ifFalse: [^(self currentBoardState turnOrder first )= (self player) ].
	^true
	
	
]

{ #category : 'Not categorized' }
HfuSpPlayerViewController >> join: aIdOfGame [
	
	self turnStateController: (HfuSpGameSessionsManager testaddPlayer: self ToSession: aIdOfGame)

]

{ #category : 'Accessing' }
HfuSpPlayerViewController >> player [

	^player
]

{ #category : 'Accessing' }
HfuSpPlayerViewController >> player: anPlayer [

	player := anPlayer
]

{ #category : 'Accessing' }
HfuSpPlayerViewController >> playerView [

	"<^iOf aPlayerView>"
	"Answer the playerView of the receiver"

	^playerView
]

{ #category : 'Accessing' }
HfuSpPlayerViewController >> playerView: anaPlayerView [

	"<anaPlayerView: iOf aPlayerView, ^self>"
	"Set the playerView of the receiver"

	playerView := anaPlayerView
]

{ #category : 'Not categorized' }
HfuSpPlayerViewController >> setPlayerView: aView [

	"<^anPlayerView>"
	"returns the PlayerView managed by this PlayerViewController"
	self player: (HfuSpPlayer makePlayer: 'Player').
	self playerView:  aView.
]

{ #category : 'NotifyTurnStateController' }
HfuSpPlayerViewController >> startGame [

	"<^self>"
	"tells the controlled view to display the games vicror"

		self turnStateController startGame
]

{ #category : 'Accessing',
 #vaCategories : ['Accessing','TurnStateControllerNotifying'] }
HfuSpPlayerViewController >> transmitOrder: aField [

	"<^self>"
	"Answer the receiver"
	|gameOrder|
	gameOrder := HfuSpTicTacToeOrder new.
	gameOrder playerID: self player id.
	gameOrder fieldID: aField.
	self isActingPlayer = true 
		ifFalse:[^nil].
	self turnStateController receiveGameOrder:  gameOrder
]

{ #category : 'Accessing' }
HfuSpPlayerViewController >> turnStateController [

	"<^iOf HfuSpTurnStateController>"
	"Answer the turnStateController of the receiver"

	^turnStateController
]

{ #category : 'Accessing' }
HfuSpPlayerViewController >> turnStateController: aHfuSpTurnStateController [

	"<aHfuSpTurnStateController: iOf HfuSpTurnStateController, ^self>"
	"Set the turnStateController of the receiver"

	turnStateController := aHfuSpTurnStateController
]
