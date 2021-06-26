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

{ #category : 'API' }
HfuSpTurnStateController >> addPlayerToPlayerViewControllers: anPlayerViewController [

	"<^PlayerViewController>"
	"Adds Player ViewController to playerViewController list and adjusts Turn order accordingly"

	self playerViewControllers isNil
		ifTrue: [self initializeState].
	self currentBoardState addPlayerToTurnOrder: (anPlayerViewController player).
	anPlayerViewController turnStateController: self.
	self playerViewControllers add: (Association new key: (anPlayerViewController player) value: anPlayerViewController ).
	^anPlayerViewController
	
]

{ #category : 'Internal' }
HfuSpTurnStateController >> announceVictorToPlayers: aPlayerId [

	"<^self>"
	"Notifies all players about the potenital Game end. 
	 aPlayerID is the Victors ID 
	 If there is no Victor aPlayerID is -1"

	self playerViewControllers do: [:aController| aController announceVictor: aPlayerId]
]

{ #category : 'API' }
HfuSpTurnStateController >> containsPlayer: anPlayer [

	"<^boolean>"
	"checks wether a player identified by an Id is already active in this game"

	^self containsPlayerWithIdInSession: anPlayer
]

{ #category : 'API' }
HfuSpTurnStateController >> containsPlayerWithIdInSession: aIdString [

	"<^(true|false)>"
	"returns true if a player with Id aIteger is already in this session.
	 returns false otherwise"
	
	self playerViewControllers do:[:eachPlayerViewController| eachPlayerViewController player id = aIdString 
		ifTrue: [^true]].
	^false
]

{ #category : 'API' }
HfuSpTurnStateController >> createAndInitalizePlayerViewController: anPlayer [

	"<^PlayerViewController>"
	"Creates a NewPlayerViewController, ads it to playerViewController list"

	^self addPlayerToPlayerViewControllers: 
		(self createPlayerViewController
			player: anPlayer;
			yourself)
	
	
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
HfuSpTurnStateController >> endGameCheckAndHandling [

	"<^self>"
	"Checks if Game should end and adjusts boardState  and notifies players if it should"
	"!!This is de default behaviour. Certain games may implement this method differently"
	self currentBoardState getVictor = -1
		ifFalse: [ 
			self announceVictorToPlayers: (self currentBoardState getVictor).
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
	"aInteger<0 means game didnt start yet
	 aInteger >0 means the game is already over 
	 aInteger=0 means the game is ongoing"

	^gameOngoing
]

{ #category : 'API' }
HfuSpTurnStateController >> gameOngoing: anInteger [

	"<anInteger: iOf Integer, ^self>"
	"Set the gameOngoing of the receiver"


	gameOngoing := anInteger
]

{ #category : 'API' }
HfuSpTurnStateController >> getViewOfPlayerWithId: aIdString [

	"<^boolean>"
	"checks wether a player identified by an Id is already active in this game"

	(self containsPlayerWithIdInSession:  aIdString)
		ifTrue: [^(self playerViewControllers at: (HfuSpPlayer players at: aIdString) ) getPlayerView]
		ifFalse: [^nil].
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
HfuSpTurnStateController >> isGameAtPlayerCapacity [

	"<^(true|false)>"
	"returns wether more players may join the game"

	self subclassResponsibility
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
	"Receives a Game Order, checks its Validity and executes it if it is Valid.
	 After execution distributes new board State to all players.
	 "
	
	self gameOngoing = 0 
		ifFalse: [^nil].
	self currentBoardState getActingPlayerId = (aGameOrder playerID)
		ifFalse: [^nil].
	(self currentBoardState isValidOrder:  aGameOrder)
		ifFalse: [^nil].
	self executeOrder: aGameOrder.
	self endGameCheckAndHandling.
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
HfuSpTurnStateController >> updateGameStateOfAllPlayers [

	"<^self>"
	"hands each player a board state and tells them to display it.
	 depending on the game a player specific BoardState may be Created
	 (a players hand in Poker for example)"
	

	self playerViewControllers do: [:aController| 
		aController currentBoardState: (self createPlayerSpecificBoardState: aController player). 	
		aController displayCurrentBoardState]										
]
