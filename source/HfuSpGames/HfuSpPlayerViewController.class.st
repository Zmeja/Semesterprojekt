Class {
	#name : 'HfuSpPlayerViewController',
	#superclass : 'Object',
	#instVars : [
		'playerID',
		'currentBoardState',
		'turnStateController',
		'playerView'
	],
	#category : 'HfuSpGames'
}

{ #category : 'Accessing',
 #vaCategories : ['Accessing','ViewNotifying'] }
HfuSpPlayerViewController >> announceVictor: aPlayerID [

	"<^self>"
	"tells the controlled view to display the games vicror"

		self playerView announceVictor: aPlayerID.
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
	self playerView setGame: (self currentBoardState copy)
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
	ifFalse: [^(self currentBoardState turnOrder first )= (self playerID) ].
	^true
	
	
]

{ #category : 'Accessing' }
HfuSpPlayerViewController >> playerID [

	"<^iOf Integer>"
	"Answer the playerID of the receiver"

	^playerID
]

{ #category : 'Accessing' }
HfuSpPlayerViewController >> playerID: anInteger [

	"<anInteger: iOf Integer, ^self>"
	"Set the playerID of the receiver"

	playerID := anInteger
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

{ #category : 'Accessing',
 #vaCategories : ['Accessing','TurnStateControllerNotifying'] }
HfuSpPlayerViewController >> transmitOrder: aGameOrder [

	"<^self>"
	"Answer the receiver"
	self isActingPlayer = true 
		ifFalse:[^nil].
	self turnStateController receiveGameOrder:  aGameOrder
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
