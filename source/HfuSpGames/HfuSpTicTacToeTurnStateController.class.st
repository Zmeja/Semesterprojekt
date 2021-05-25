Class {
	#name : 'HfuSpTicTacToeTurnStateController',
	#superclass : 'HfuSpTurnStateController',
	#category : 'HfuSpGames'
}

{ #category : 'Not categorized' }
HfuSpTicTacToeTurnStateController >> createPlayerViewController [

	"<^aPlayerViewController>"
	"Creates a Player View Controller of games type "

	^HfuSpTicTacToePlayerViewController new
]

{ #category : 'ViewControllerNotifying' }
HfuSpTicTacToeTurnStateController >> executeOrder: anGameOrder [

	"<^self>"
	"executes a order without checking its validity. 
	 should only be called via receiveGameOrder"
	
	self currentBoardState setField: (anGameOrder fieldID) asPlayerOwned: (anGameOrder playerID).
	^ anGameOrder playerID
]

{ #category : 'Not categorized' }
HfuSpTicTacToeTurnStateController >> initializeBoardState [

	"<^self>"
	"creates the games Board as it is at game Start."
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
	self gameOngoing: -1.
]
