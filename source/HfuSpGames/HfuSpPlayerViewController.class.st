Class {
	#name : 'HfuSpPlayerViewController',
	#superclass : 'Object',
	#instVars : [
		'playerID',
		'currentBoardState',
		'isActingPlayer',
		'turnStateController'
	],
	#category : 'HfuSpGames'
}

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

{ #category : 'Accessing' }
HfuSpPlayerViewController >> isActingPlayer [

	"<^iOf Boolean>"
	"Answer the isActingPlayer of the receiver"

	
	"^(self currentBoardState turnOrder first )= (self playerID) "
	^ isActingPlayer
	
]

{ #category : 'Accessing' }
HfuSpPlayerViewController >> isActingPlayer: aBoolean [

	"<aBoolean: iOf Boolean, ^self>"
	"Set the isActingPlayer of the receiver"

	isActingPlayer := aBoolean
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
HfuSpPlayerViewController >> resetViewBoardState [

	"<^self>"
	"Answer the receiver"

	self
]

{ #category : 'Accessing' }
HfuSpPlayerViewController >> transmitOrder: aGameOrder [

	"<^self>"
	"Answer the receiver"
	self isActingPlayer = true 
		ifFalse:[^nil].
	self isActingPlayer: false.
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
