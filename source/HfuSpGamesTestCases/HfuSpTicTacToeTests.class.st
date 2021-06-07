Class {
	#name : 'HfuSpTicTacToeTests',
	#superclass : 'TestCase',
	#category : 'HfuSpGamesTestCases'
}

{ #category : 'Not categorized' }
HfuSpTicTacToeTests class >> testAll [

	"<^self>"
	"Answer the receiver"

	self testOrders
]

{ #category : 'Not categorized' }
HfuSpTicTacToeTests class >> testOrders [
	"<^self>"
	"Tests creation and execution of Game Orders"
	|secondGamestate firstGameState theGameSession theGameSessionId view1 view2 view1Id view2Id|

	theGameSessionId := HfuSpGameSessionsManager createGameSession:  'TicTacToe' . 
	view1:= HfuSpGameSessionsManager addPlayer: 1 ToSession: theGameSessionId.
	view1 createComponents.
	view1Id:= view1 playerViewController player id.
	view2 := HfuSpGameSessionsManager addPlayer: 2 ToSession: theGameSessionId.
	view2 createComponents.
	view2Id:= view2 playerViewController player id.
	theGameSession:= HfuSpGameSessionsManager getGameSessionById: theGameSessionId.
	
	"can orders be given before a game starts?"
	view1 playerViewController transmitOrder: 1.
	self assert: (theGameSession currentBoardState getTile: 1 )= -1.
	
	theGameSession startGame.
	
	"does a simple command work?"
	view1 playerViewController transmitOrder: 1.
	self assert: (theGameSession currentBoardState getTile: 1 )= view1Id.
	
	"can one player make multiple comands"
	view1 playerViewController transmitOrder: 2.
	self assert: (theGameSession currentBoardState getTile: 2 )= -1.
	
	"can both players act in correct order ?"
	view2 playerViewController transmitOrder: 4.
	self assert: (theGameSession currentBoardState getTile: 4 )= view2Id.
	
	"can a field be overwritten?"
	view1 playerViewController transmitOrder: 4.
	self assert: (theGameSession currentBoardState getTile: 4 )= view2Id.

	"does a invalid order caus you to lose a turn? "
	view1 playerViewController transmitOrder: 9.
	self assert: (theGameSession currentBoardState getTile: 9 )= view1Id.
	
	"can a field outside of the board be set?"	
	firstGameState:=  theGameSession currentBoardState.
	view2 playerViewController transmitOrder: 10.
	self assert: (theGameSession currentBoardState = firstGameState).
	

	
	HfuSpGameSessionsManager removeActiveGameSession: theGameSessionId
	
	
	
	 
	
]
