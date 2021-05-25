Class {
	#name : 'HfuSpConnectFourTurnStateController',
	#superclass : 'HfuSpTurnStateController',
	#category : 'HfuSpGames'
}

{ #category : 'Not categorized' }
HfuSpConnectFourTurnStateController >> createPlayerViewController [

	"<^aPlayerViewController>"
	"Creates a Player View Controller of games type "

	^HfuSpConnectFourPlayerViewController new
]

{ #category : 'Not categorized' }
HfuSpConnectFourTurnStateController >> executeOrder: anGameOrder [

	"<^self>"
	"executes a order without checking its validity. 
	 should only be called via receiveGameOrder"
	|rowIndex|
	rowIndex:= self currentBoardState getFirstEmptyFieldInColumn: (anGameOrder columnId).
	self currentBoardState setFieldAtColumn: (anGameOrder columnId) Row: rowIndex AsPlayerOwned: (anGameOrder playerID).
	^ anGameOrder playerID
	

]

{ #category : 'Not categorized' }
HfuSpConnectFourTurnStateController >> initializeBoardState [

	"<^self>"
	"creates the games Board as it is at game Start."
		| myBoardState |

	self playerViewControllers = nil
	ifTrue: [self playerViewControllers: Dictionary new.].
	
	myBoardState:= HfuSpConnectFourBoardState new.
	myBoardState initializeBoardState.
	self currentBoardState: myBoardState
]

{ #category : 'Not categorized' }
HfuSpConnectFourTurnStateController >> initializeState [

	"<^self>"
	"initializes object state"
	self playerViewControllers: Dictionary new.
	self initializeBoardState.
	self gameOngoing: -1.

]
