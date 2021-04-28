Class {
	#name : 'HfuSpTurnStateController',
	#superclass : 'Object',
	#instVars : [
		'turnNumber',
		'currentBoardState',
		'playerViewControllers'
	],
	#category : 'HfuSpGames'
}

{ #category : 'Accessing' }
HfuSpTurnStateController >> addPlayer: anPlayerViewController [

	"<^PlayerViewController>"
	"Adds Plyer ViewController to playerViewController list"

	self playerViewControllers = nil 
		ifTrue: [self initializeState].
	self currentBoardState addPlayerToTurnOrder: (anPlayerViewController playerID).
	anPlayerViewController turnStateController: self.
	self playerViewControllers add: (Association new key: (anPlayerViewController playerID) value: anPlayerViewController )
	
]

{ #category : 'Accessing' }
HfuSpTurnStateController >> createPlayer: anPlayerID [

	"<^PlayerViewController>"
	"Creates a NewPlayerViewController, ads it to playerViewController list"
	|newPlayer|
	newPlayer:= HfuSpPlayerViewController new .
	newPlayer playerID: anPlayerID.
	self addPlayer: newPlayer.
	^newPlayer
]

{ #category : 'Accessing' }
HfuSpTurnStateController >> currentBoardState [

	"<^iOf Object>"
	"Answer the currentBoardState of the receiver"

	^currentBoardState
]

{ #category : 'Accessing' }
HfuSpTurnStateController >> currentBoardState: anBoardState [

	"<anObject: iOf Object, ^self>"
	"Set the currentBoardState of the receiver"

	currentBoardState := anBoardState
]

{ #category : 'Accessing' }
HfuSpTurnStateController >> demandPlayerInput: aPlayerID [

	"<^self>"
	"Answer the receiver"
	
	self
]

{ #category : 'Accessing' }
HfuSpTurnStateController >> exectueOrder: anOrder [

	"<^self>"
	"executes a order without checking its validity. 
	 should only be called ba receiveGameOrder"
	
	self subclassResponsibility
]

{ #category : 'Accessing' }
HfuSpTurnStateController >> initializeState [

	"<^self>"
	"initializes object state"
	playerViewControllers := Dictionary  new.
	self
]

{ #category : 'Accessing' }
HfuSpTurnStateController >> playerViewControllers [

	"<^iOf Object>"
	"Answer the playerViewControllers of the receiver"

	^playerViewControllers
]

{ #category : 'Accessing' }
HfuSpTurnStateController >> playerViewControllers: anDictionary [

	"<anObject: iOf Object, ^self>"
	"Set the playerViewControllers of the receiver"

	playerViewControllers := anDictionary
]

{ #category : 'Accessing' }
HfuSpTurnStateController >> receiveGameOrder: aGameOrder [

	"<^>"
	"Receives a Game Order, checks its Validity and executes it"
	(self currentBoardState isValidOrder:  aGameOrder)
		ifFalse:[
					self demandPlayerInput: (aGameOrder playerID).
					^nil].
	self currentBoardSt
		
]

{ #category : 'Accessing' }
HfuSpTurnStateController >> turnNumber [

	"<^iOf Object>"
	"Answer the turnNumber of the receiver"

	^self currentBoardState turnNumber
]

{ #category : 'Accessing' }
HfuSpTurnStateController >> turnNumber: anInteger [

	"<anObject: iOf Object, ^self>"
	"Set the turnNumber of the receiver"

	self currentBoardState turnNumber: anInteger
]

{ #category : 'Accessing' }
HfuSpTurnStateController >> updateBoardState: aGameOrder [

	"<^self>"
	"Updates Board State Based on aTicTacToeOrder"
	self subclassResponsibility
	
]

{ #category : 'Accessing' }
HfuSpTurnStateController >> updateGameStateOfAllPlayers [

	"<>"
	"generates  Turn State From Order and distributes it to all players"

	self playerViewControllers do: [:aController| 
		aController currentBoardState: (self currentBoardState copy). 
		aController resetViewBoardState ]
]
