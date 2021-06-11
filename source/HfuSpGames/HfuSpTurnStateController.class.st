Class {
	#name : 'HfuSpTurnStateController',
	#superclass : 'Object',
	#instVars : [
		'type',
		'name',
		'turnNumber',
		'currentBoardState',
		'playerViewControllers',
		'gameOngoing'
	],
	#category : 'HfuSpGames'
}

{ #category : 'Internal' }
HfuSpTurnStateController >> addPlayer: anPlayerViewController [

	"<^PlayerViewController>"
	"Adds Player ViewController to playerViewController list"

	self playerViewControllers = nil 
		ifTrue: [self initializeState].
	self currentBoardState addPlayerToTurnOrder: (anPlayerViewController player).
	anPlayerViewController turnStateController: self.
	self playerViewControllers add: (Association new key: (anPlayerViewController player) value: anPlayerViewController ).

]

{ #category : 'Internal' }
HfuSpTurnStateController >> announceVictorToPlayers: aPlayer [

	"<^self>"
	"Notifies all players about the potenital Game end. 
	 aPlayerID is the Victors ID 
	 If there is no Victor aPlayerID is -1"

	self playerViewControllers do: [:aController| aController announceVictor: aPlayer]
]

{ #category : 'API' }
HfuSpTurnStateController >> containsPlayer: anPlayer [

	"<^boolean>"
	"checks wether a player identified by an Id is already active in this game"
	|found|
	^self   containsPlayerWithIdInSession: anPlayer
]

{ #category : 'API' }
HfuSpTurnStateController >> containsPlayerWithIdInSession: aInteger [

	"<^self>"
	"Answer the receiver"
	self playerViewControllers do:[:eachPlayerViewController| eachPlayerViewController player  id = aInteger ifTrue: [^true]].
	^false
]

{ #category : 'API' }
HfuSpTurnStateController >> createPlayer: anPlayer [

	"<^PlayerViewController>"
	"Creates a NewPlayerViewController, ads it to playerViewController list"
	|newPlayer|
	newPlayer:= self createPlayerViewController.
	newPlayer player: anPlayer.
	self addPlayer: newPlayer.
	^newPlayer
]

{ #category : 'Internal' }
HfuSpTurnStateController >> createPlayerSpecificBoardState: anPlayerId [

	"<^self>"
	"creates a board state that contains only information availible to the player"
	"When not overriden by a subclass returns entire board State"

	^ self currentBoardState copy
]

{ #category : 'Internal' }
HfuSpTurnStateController >> createPlayerViewController [

	"<^aPlayerViewController>"
	"Creates a Player View Controller of games type "

	self subclassResponsibility
]

{ #category : 'API' }
HfuSpTurnStateController >> currentBoardState [

	"<^iOf Object>"
	"Answer the currentBoardState of the receiver"

	^currentBoardState
]

{ #category : 'API' }
HfuSpTurnStateController >> currentBoardState: anBoardState [

	"<anObject: iOf Object, ^self>"
	"Set the currentBoardState of the receiver"

	currentBoardState := anBoardState
]

{ #category : 'Internal' }
HfuSpTurnStateController >> endGameHandling [

	"<^self>"
	"Checks if Game should end and adjusts Game State if it should"
	"!!This is de default behaviour. certain games may implement this method differently"
	self currentBoardState getVictor = -1
		ifFalse: [ self announceVictorToPlayers: (self currentBoardState getVictor).
					self gameOngoing:1.
					^nil].
	self currentBoardState isGameDraw
		ifTrue: [
					self announceVictorToPlayers: -99.
					self gameOngoing: 1.
					^nil.
		]
]

{ #category : 'Internal' }
HfuSpTurnStateController >> executeOrder: anOrder [

	"<^self>"
	"executes a order without checking its validity. 
	 should only be called ba receiveGameOrder"
	
	self subclassResponsibility
]

{ #category : 'API' }
HfuSpTurnStateController >> gameOngoing [

	"<^iOf Integer>"
	"Answer the gameOngoing of the receiver"

	^gameOngoing
]

{ #category : 'API' }
HfuSpTurnStateController >> gameOngoing: anInteger [

	"<anInteger: iOf Integer, ^self>"
	"Set the gameOngoing of the receiver"
	"anInteger<0 means game didnt start yet
	 anInteger >0 means the game is already over 
	 anInteger=0 means the game is ongoing"

	gameOngoing := anInteger
]

{ #category : 'Internal' }
HfuSpTurnStateController >> initializeBoardState [

	"<^self>"
	"creates the games Board"

	self subclassResponsibility
]

{ #category : 'API' }
HfuSpTurnStateController >> initializeState [

	"<^self>"
	"initializes object state"
	self subclassResponsibility.
	

]

{ #category : 'API' }
HfuSpTurnStateController >> name [

	^name
	
]

{ #category : 'API' }
HfuSpTurnStateController >> name: anObject [

	name := anObject
]

{ #category : 'Internal' }
HfuSpTurnStateController >> playerViewControllers [

	"<^iOf Object>"
	"Answer the playerViewControllers of the receiver"

	^playerViewControllers
]

{ #category : 'Internal' }
HfuSpTurnStateController >> playerViewControllers: anDictionary [

	"<anObject: iOf Object, ^self>"
	"Set the playerViewControllers of the receiver"

	playerViewControllers := anDictionary
]

{ #category : 'API' }
HfuSpTurnStateController >> receiveGameOrder: aGameOrder [

	"<^>"
	"Receives a Game Order, checks its Validity and executes it if it is  Valid"
	
	self gameOngoing =0 
		ifFalse: [^nil].
	self currentBoardState turnOrder first id = (aGameOrder playerID)
		ifFalse:[^nil].
	(self currentBoardState isValidOrder:  aGameOrder)
		ifFalse:[
					^nil].
	self executeOrder: aGameOrder.
	self endGameHandling.
	self currentBoardState makeTurnOrderStep.
	self updateGameStateOfAllPlayers.
]

{ #category : 'API' }
HfuSpTurnStateController >> startGame [

	"^self"
	"sets the game as active"
	self gameOngoing: 0.
	self updateGameStateOfAllPlayers.
]

{ #category : 'API' }
HfuSpTurnStateController >> turnNumber [

	"<^iOf Object>"
	"Answer the turnNumber of the receiver"

	^self currentBoardState turnNumber
]

{ #category : 'API' }
HfuSpTurnStateController >> turnNumber: anInteger [

	"<anObject: iOf Object, ^self>"
	"Set the turnNumber of the receiver"

	self currentBoardState turnNumber: anInteger
]

{ #category : 'API' }
HfuSpTurnStateController >> type [

	^type
]

{ #category : 'API' }
HfuSpTurnStateController >> type: anObject [

	type := anObject
]

{ #category : 'Internal' }
HfuSpTurnStateController >> updateBoardState: aGameOrder [

	"<^self>"
	"Updates Board State Based on aOrder"
	self subclassResponsibility
	
]

{ #category : 'Internal' }
HfuSpTurnStateController >> updateGameStateOfAllPlayers [

	"<^self>"
	"hands each player a board state and tells them to display it.
	 depending on the game a player specific BoardState is Created
	 (for example a players hand in Poker)"
	

	self playerViewControllers do: [:aController| 
		aController currentBoardState: (self createPlayerSpecificBoardState:  aController player). 	
		aController displayCurrentBoardState
		]										
]
