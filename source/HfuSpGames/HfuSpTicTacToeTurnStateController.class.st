Class {
	#name : 'HfuSpTicTacToeTurnStateController',
	#superclass : 'HfuSpTurnStateController',
	#category : 'HfuSpGames'
}

{ #category : 'Not categorized' }
HfuSpTicTacToeTurnStateController >> exectueOrder: anGameOrder [

	"<^self>"
	"executes a order without checking its validity. 
	 should only be called ba receiveGameOrder"
	
	self currentBoardState setField: (anGameOrder fieldID) asPlayerOwned: (anGameOrder playerID).
	^self currentBoardState
]

{ #category : 'Not categorized' }
HfuSpTicTacToeTurnStateController >> receiveGameOrder: aGameOrder [

	"<^>"
	"Receives a Game Order, checks its Validity and executes it"
	(self currentBoardState isValidOrder:  aGameOrder)
		ifFalse:[
					self demandPlayerInput: (aGameOrder playerID).
					^nil].
	self updateBoardState: aGameOrder.
	self currentBoardState makeTurnOrderStep.
		
]

{ #category : 'Not categorized' }
HfuSpTicTacToeTurnStateController >> updateBoardState: aGameOrder [

	"<^aInteget> aGameOrder playerID if order was Processed else -1 "
	"updates own Board State According to a Order."
	|board|
	self currentBoardState setField: (aGameOrder fieldID) asPlayerOwned: (aGameOrder playerID).
	^ aGameOrder playerID

	
]
