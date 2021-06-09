Class {
	#name : 'HfuSpTicTacToeTests',
	#superclass : 'TestCase',
	#category : 'HfuSpGamesTestCases'
}

{ #category : 'Not categorized' }
HfuSpTicTacToeTests class >> testAll [

	"<^self>"
	"Answer the receiver"

	self testOrders.
	self testGameState.
]

{ #category : 'Not categorized' }
HfuSpTicTacToeTests class >> testGameState [
	"<^self>"
	"Tests HfuSpTicTacToeBoardState methods such as  getVictor "
	|board order|
	board:= HfuSpTicTacToeBoardState new.
	board initializeBoardState.
	
	"Does Initialisation work properly"
	(1 to: 9) do: [:aTile|self assert: (board getTile: aTile)= -1  description: 'is board state initialized properly'].
	
	"are Orders classifeid as (in)valid correctly"
	order:= HfuSpTicTacToeOrder new.
	order playerID: 1.
	order fieldID: 1.
	self assert: (board isValidOrder: order)  description:'valid order is detected'.
	self assert: (board isValidOrder: (HfuSpTicTacToeOrder createOrderForField: -1 ofPlayer: 1 ) )not
		   description: 'can a order for a out of bounds field be created?'.
	
	board setField: 1 asPlayerOwned: 1.
	self assert: (board isValidOrder: (HfuSpTicTacToeOrder createOrderForField: 1 ofPlayer: 2 )  ) not
			description: 'can a field owned by aplayer can be overwriten?'.
			
	self assert: (board isValidOrder: (HfuSpTicTacToeOrder createOrderForField: 1 ofPlayer: 1 )  ) not
			description: 'can a player give a order for a tile he already owns?'.
	
	board setField:9  asPlayerOwned: 2.
	board setField:3  asPlayerOwned: 2.
	self assert: ((board getDiagonal: 1) = #(1 -1 2) asOrderedCollection  ) description: 'are diagonals processed corectly?'.
	self assert: ((board getDiagonal: 2) = #(2 -1 -1) asOrderedCollection  ) description: 'are diagonals processed corectly?'.

	"can winners be determined?"
	board boardTiles: #(1 1 1 2 -1 2 -1 -1 -1 ).
	self assert: board getVictor = 1  description: 'top row winner detected'.
	
	board boardTiles: #(1 2 1 2 2 2 -1 -1 -1 ).
	self assert: board getVictor = 2  description: 'middle row winner detected'.
	
	board boardTiles: #(2 1 1 2 -1 2 1 1 1 ).
	self assert: board getVictor = 1  description: 'lower row winner detected'.
	
	board boardTiles: #(1 -1 2 2 1 -1 2 -1 1).
	self assert: board getVictor = 1  description: 'top left to bottom right duagonalwinner detected'.
	
	board boardTiles: #(1 -1 2 1 2 -1 2 -1 -1).
	self assert: board getVictor = 2  description: 'top left to bottom right duagonalwinner detected'.
	
	
	
	 
	
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
	"can a playe rbe added multiple times to the same session?"
	self assert: (HfuSpGameSessionsManager addPlayer: 1 ToSession: theGameSessionId) = nil .
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
