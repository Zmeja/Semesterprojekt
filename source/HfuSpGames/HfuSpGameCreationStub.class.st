Class {
	#name : 'HfuSpGameCreationStub',
	#superclass : 'Object',
	#instVars : [
		'myTurnStateController',
		'myPlayer1',
		'myPlayer2',
		'globalViewForTest'
	],
	#category : 'HfuSpGames'
}

{ #category : 'Not categorized' }
HfuSpGameCreationStub >> createGame [

	"<^self>"
	"Answer the receiver"
	| myBoardState |
	myTurnStateController:= HfuSpTicTacToeTurnStateController new.
	myTurnStateController initializeState.
	
	myBoardState:= HfuSpTicTacToeBoardState new.
	myBoardState initializeBoardState.
	
	myTurnStateController currentBoardState: myBoardState.
	
	globalViewForTest:= HfuSpTicTacToePlayerView new.
	
	self myPlayer1: HfuSpTicTacToePlayerViewController new.
	self myPlayer1 playerID: 1.
	self myPlayer1 globalView: globalViewForTest.
	myTurnStateController addPlayer: self myPlayer1 .
	
	self myPlayer2: HfuSpTicTacToePlayerViewController new.
	self myPlayer2 playerID: 2.
	self myPlayer2 globalView: globalViewForTest.
	myTurnStateController addPlayer: self myPlayer2.
	
	myTurnStateController updateGameStateOfAllPlayers
	
]

{ #category : 'Not categorized' }
HfuSpGameCreationStub >> createGame: curGlobalView [

	"<^self>"
	"Answer the receiver"
	| myBoardState |
	myTurnStateController:= HfuSpTicTacToeTurnStateController new.
	myTurnStateController initializeState.
	
	myBoardState:= HfuSpTicTacToeBoardState new.
	myBoardState initializeBoardState.
	
	myTurnStateController currentBoardState: myBoardState.
	
	self myPlayer1: HfuSpTicTacToePlayerViewController new.
	self myPlayer1 playerID: 1.
	self myPlayer1 globalView: curGlobalView.
	myTurnStateController addPlayer: self myPlayer1.
	
	self myPlayer2: HfuSpTicTacToePlayerViewController new.
	self myPlayer2 playerID: 2.
	self myPlayer2 globalView: curGlobalView.
	myTurnStateController addPlayer: self myPlayer2.
	
	"myTurnStateController updateGameStateOfAllPlayers"
]

{ #category : 'Not categorized' }
HfuSpGameCreationStub >> createTicTacToeOrderForPlayer: aPlayerID To: aFieldID [

	"<^self>"
	"Answer the receiver"
	|order controller|
	order:= HfuSpTicTacToeOrder new.
	order playerID: aPlayerID.
	order fieldID: aFieldID.
	
	controller := self myTurnStateController playerViewControllers at:  aPlayerID.
	
	controller transmitOrder: order.
	
]

{ #category : 'Accessing' }
HfuSpGameCreationStub >> myPlayer1 [

	"<^iOf Object>"
	"Answer the myPlayer1 of the receiver"

	^myPlayer1
]

{ #category : 'Accessing' }
HfuSpGameCreationStub >> myPlayer1: anObject [

	"<anObject: iOf Object, ^self>"
	"Set the myPlayer1 of the receiver"

	myPlayer1 := anObject
]

{ #category : 'Accessing' }
HfuSpGameCreationStub >> myPlayer2 [

	"<^iOf Object>"
	"Answer the myPlayer2 of the receiver"

	^myPlayer2
]

{ #category : 'Accessing' }
HfuSpGameCreationStub >> myPlayer2: anObject [

	"<anObject: iOf Object, ^self>"
	"Set the myPlayer2 of the receiver"

	myPlayer2 := anObject
]

{ #category : 'Accessing' }
HfuSpGameCreationStub >> myTurnStateController [

	"<^iOf Object>"
	"Answer the myTurnStateController of the receiver"

	^myTurnStateController
]

{ #category : 'Accessing' }
HfuSpGameCreationStub >> myTurnStateController: anObject [

	"<anObject: iOf Object, ^self>"
	"Set the myTurnStateController of the receiver"

	myTurnStateController := anObject
]
