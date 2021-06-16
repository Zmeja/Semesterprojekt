Class {
	#name : 'HfuSpTicTacToeTurnStateController',
	#superclass : 'HfuSpTurnStateController',
	#category : 'HfuSpTicTacToe'
}

{ #category : 'Internal' }
HfuSpTicTacToeTurnStateController >> createPlayerViewController [

	"<^aPlayerViewController>"
	"Creates a Player View Controller of games type "

	^HfuSpTicTacToePlayerViewController new
]

{ #category : 'API' }
HfuSpTicTacToeTurnStateController >> executeOrder: anGameOrder [

	"<^self>"
	"executes a order without checking its validity. 
	 should only be called via receiveGameOrder"
	
	self currentBoardState setField: (anGameOrder fieldID) asPlayerOwned: (anGameOrder playerID).

]

{ #category : 'Internal' }
HfuSpTicTacToeTurnStateController >> initializeBoardState [

	"<^self>"
	"creates the games Board as it is at game Start."

	self currentBoardState:  
		HfuSpTicTacToeBoardState new	
			initializeBoardState;
			yourself.

]

{ #category : 'API' }
HfuSpTicTacToeTurnStateController >> initializeState [

	"<^self>"
	"initializes object state"
	self playerViewControllers: Dictionary new.
	self initializeBoardState.
	self gameOngoing: -1.
]

{ #category : 'API' }
HfuSpTicTacToeTurnStateController >> isGameAtPlayerCapacity [

	"<^(true|false)>"
	"returns wether more players may join the game"

	^self playerViewControllers size >=2
]
