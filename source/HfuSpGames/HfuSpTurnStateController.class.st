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

{ #category : 'ViewControllerNotifying' }
HfuSpTurnStateController >> announceVictorToPlayers: aPlayerID [

	"<^self>"
	"Notifies all players about the potenital Game end. 
	 aPlayerID is the Victors ID 
	 If there is no Victor aPlayerID is -1"

	self playerViewControllers do: [:aController| aController announceVictor: aPlayerID]
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

{ #category : 'Accessing',
 #vaCategories : ['Accessing','ViewControllerNotifying'] }
HfuSpTurnStateController >> demandPlayerInput: aPlayerID [

	"<^self>"
	"Answer the receiver"
	
	self
]

{ #category : 'InternalStateHandling' }
HfuSpTurnStateController >> endGameHandling [

	"<^self>"
	"Checks if Game should end and adjusts Game State if it should"
	self currentBoardState getVictor = -1
		ifFalse: [ self announceVictorToPlayers: (self currentBoardState getVictor) ].
	self currentBoardState isGameDraw
		ifTrue: [self announceVictorToPlayers: -1]
]

{ #category : 'InternalStateHandling' }
HfuSpTurnStateController >> exectueOrder: anOrder [

	"<^self>"
	"executes a order without checking its validity. 
	 should only be called ba receiveGameOrder"
	
	self subclassResponsibility
]

{ #category : 'InternalStateHandling' }
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

{ #category : 'Accessing',
 #vaCategories : ['Accessing','ViewControllerNotifying'] }
HfuSpTurnStateController >> receiveGameOrder: aGameOrder [

	"<^>"
	"Receives a Game Order, checks its Validity and executes it if it is  Valid"
	(self currentBoardState isValidOrder:  aGameOrder)
		ifFalse:[
					self demandPlayerInput: (aGameOrder playerID).
					^nil].
	self updateBoardState: aGameOrder.
	self endGameHandling.
	self currentBoardState makeTurnOrderStep.
	self updateGameStateOfAllPlayers.
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

{ #category : 'InternalStateHandling' }
HfuSpTurnStateController >> updateBoardState: aGameOrder [

	"<^self>"
	"Updates Board State Based on aOrder"
	self subclassResponsibility
	
]

{ #category : 'ViewControllerNotifying' }
HfuSpTurnStateController >> updateGameStateOfAllPlayers [

	"<^self>"
	"distributes it to all players and tells them to display it"

	self playerViewControllers do: [:aController| 
		aController currentBoardState: (self currentBoardState copy). 
		aController resetViewBoardState ]
]
