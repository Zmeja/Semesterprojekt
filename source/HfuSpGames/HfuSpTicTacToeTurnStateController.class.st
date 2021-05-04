Class {
	#name : 'HfuSpTicTacToeTurnStateController',
	#superclass : 'HfuSpTurnStateController',
	#category : 'HfuSpGames'
}

{ #category : 'Not categorized' }
HfuSpTicTacToeTurnStateController >> endGameHandling [

	"<^self>"
	"Checks if Game should end and adjusts Game State if it should"
	self currentBoardState getVictor = -1
		ifFalse: [ self announceVictorToPlayers: (self currentBoardState getVictor) ].
	self currentBoardState isGameDraw
		ifTrue: [self announceVictorToPlayers: -1]
]

{ #category : 'Not categorized' }
HfuSpTicTacToeTurnStateController >> exectueOrder: anGameOrder [

	"<^self>"
	"executes a order without checking its validity. 
	 should only be called via receiveGameOrder"
	
	self currentBoardState setField: (anGameOrder fieldID) asPlayerOwned: (anGameOrder playerID).
	^self currentBoardState
]

{ #category : 'Not categorized' }
HfuSpTicTacToeTurnStateController >> initializeBoardState [

	"<^self>"
	"creates the games Board"
		| myBoardState |

	self playerViewControllers: Dictionary new.
	
	myBoardState:= HfuSpTicTacToeBoardState new.
	myBoardState initializeBoardState.
	self currentBoardState: myBoardState
	

]

{ #category : 'Not categorized' }
HfuSpTicTacToeTurnStateController >> initializeState [

	"<^self>"
	"initializes object state"
	self playerViewControllers: Dictionary new.
	self initializeBoardState.
]

{ #category : 'Not categorized' }
HfuSpTicTacToeTurnStateController >> updateBoardState: aGameOrder [

	"<^aInteget> aGameOrder playerID if order was Processed else -1 "
	"updates own board state according to a order."
	|board|
	self currentBoardState setField: (aGameOrder fieldID) asPlayerOwned: (aGameOrder playerID).
	^ aGameOrder playerID

	
]
