Class {
	#name : 'HfuSpConnectFourTurnStateController',
	#superclass : 'HfuSpTurnStateController',
	#category : 'HfuSpConnectFour'
}

{ #category : 'Internal' }
HfuSpConnectFourTurnStateController >> createPlayerViewController [

	"<^aPlayerViewController>"
	"Creates a Player View Controller of corresponding game type "

	^HfuSpConnectFourPlayerViewController new
]

{ #category : 'API' }
HfuSpConnectFourTurnStateController >> executeOrder: anGameOrder [

	"<^self>"
	"executes a order without checking its validity. 
	 should only be called via receiveGameOrder Method"
	|rowIndex|
	rowIndex := self currentBoardState getFirstEmptyFieldInColumn: (anGameOrder columnId).
	self currentBoardState setFieldAtColumn: (anGameOrder columnId) Row: rowIndex asPlayerOwned: (anGameOrder playerID).
	
	

]

{ #category : 'Internal' }
HfuSpConnectFourTurnStateController >> initializeBoardState [

	"<^self>"
	"creates the games Board as it is at game Start."

	self currentBoardState: 
		HfuSpConnectFourBoardState new 
			initializeBoardState;
			yourself.
]

{ #category : 'API' }
HfuSpConnectFourTurnStateController >> initializeState [

	"<^self>"
	"initializes object state"
	self playerViewControllers: Dictionary new.
	self initializeBoardState.
	self gameOngoing: -1.

]

{ #category : 'API' }
HfuSpConnectFourTurnStateController >> isGameAtPlayerCapacity [

	"<^(true|false)>"
	"returns wether more players may join the game"

	^self playerViewControllers size >=2
]
