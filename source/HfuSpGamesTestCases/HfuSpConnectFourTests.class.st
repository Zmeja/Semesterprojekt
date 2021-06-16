Class {
	#name : 'HfuSpConnectFourTests',
	#superclass : 'TestCase',
	#category : 'HfuSpGamesTestCases'
}

{ #category : 'Not categorized' }
HfuSpConnectFourTests class >> testAll [

	"<^self>"
	"Answer the receiver"

	self testOrders.
	self testGameState.
]

{ #category : 'Not categorized' }
HfuSpConnectFourTests class >> testGameState [

	"<^self>"
	"tests gameState functionality 
	 the games rules are mostly disregarded for these tests"

	|boardState|
	
	boardState:= HfuSpConnectFourBoardState new initializeBoardState yourself.
	
	"does initialisation work"
	boardState board do: [:aColumn|
		aColumn do: [:aField| self assert: aField= -1 description: 'initialisation failed']
		].

	"can field ownership be changed"
	boardState setFieldAtColumn: 1 Row: 1  asPlayerOwned:1.
	self assert:  (boardState getFieldAtColumn: 1 Row:1 ) =1 description: 'error when seting field ownership'.

	"can the first empty field in a column be detected"
	self assert: (boardState getFirstEmptyFieldInColumn: 1)= 2 description: 'error when geting first empty field'.
	boardState setFieldAtColumn: 1 Row: 2  asPlayerOwned:1.
	self assert: (boardState getFirstEmptyFieldInColumn: 1)= 3 description: 'error when geting first empty field'.
	boardState setFieldAtColumn: 1 Row: 3  asPlayerOwned:1.
	boardState setFieldAtColumn: 1 Row: 4  asPlayerOwned:2.
	boardState setFieldAtColumn: 1 Row: 5  asPlayerOwned:1.
	boardState setFieldAtColumn: 1 Row: 6  asPlayerOwned:1.
	self assert: (boardState getFirstEmptyFieldInColumn: 1)= -1 description: 'error when geting first empty field'.

	"can the first element of a out f bounds field be detected"
	self assert: (boardState getFirstEmptyFieldInColumn: 0)= -1 description: 'wrong result for out of bounds field'.
	self assert: (boardState getFirstEmptyFieldInColumn: (boardState boardWidth +1))= -1 description: 'wrong result for out of bounds field'.
	
	"are horizontal lines (rows) detected propperly"
	boardState initializeBoardState. 
	boardState setFieldAtColumn: 1 Row: 1  asPlayerOwned:1.
	boardState setFieldAtColumn: 2 Row: 1  asPlayerOwned:2.
	boardState setFieldAtColumn: 4 Row: 1  asPlayerOwned:2.
	boardState setFieldAtColumn: 5 Row: 1  asPlayerOwned:2.
	self assert: ((boardState getHorizontalBoardLine: 1) = (#(1 2 -1 2 2 -1 -1) asOrderedCollection)) description:'error when geting horizontal line'.
	boardState setFieldAtColumn: 2 Row: 4  asPlayerOwned: 2.
	boardState setFieldAtColumn: 4 Row: 4  asPlayerOwned: 2.
	boardState setFieldAtColumn: 5 Row: 4  asPlayerOwned: 2.
	boardState setFieldAtColumn: 6 Row: 4  asPlayerOwned: 2.
	boardState setFieldAtColumn: 7 Row: 4  asPlayerOwned: 2.
	self assert: ((boardState getHorizontalBoardLine: 4) = (#(-1 2 -1 2 2 2 2) asOrderedCollection)) description:'error when geting horizontal line'.

	"are diagonaI Iinesdetected propperly"
	boardState initializeBoardState.
	boardState setFieldAtColumn: 1 Row: 6  asPlayerOwned: 1.
	boardState setFieldAtColumn: 2 Row: 6  asPlayerOwned: 1.
	boardState setFieldAtColumn: 1 Row: 1  asPlayerOwned: 2.
	boardState setFieldAtColumn: 4 Row: 4  asPlayerOwned: 2.
	boardState setFieldAtColumn: 2 Row: 2  asPlayerOwned: 2.
	self assert: ((boardState getRisingDiagonalBoardLine:  1) = (#(1) asOrderedCollection)) description:'error when geting diagonaI line'.
	self assert: ((boardState getRisingDiagonalBoardLine:  6) = (#(2 2 -1 2 -1 -1 ) asOrderedCollection)) description:'error when geting diagonaI line'.

	boardState setFieldAtColumn: 3 Row: 1  asPlayerOwned: 2.
	boardState setFieldAtColumn: 4 Row: 2  asPlayerOwned: 1.
	boardState setFieldAtColumn: 6 Row: 4  asPlayerOwned: 2.
	boardState setFieldAtColumn: 7 Row: 5  asPlayerOwned: 2.
	self assert: ((boardState getRisingDiagonalBoardLine:  8) = (#(2 1 -1 2 2) asOrderedCollection)) description:'error when geting diagonaI line'.

	boardState initializeBoardState.
	boardState setFieldAtColumn: 1 Row: 1  asPlayerOwned: 2.
	self assert: ((boardState getDescendingDiagonalBoardLine:  1) = (#(2) asOrderedCollection)) description:'error when geting diagonaI line'.

	boardState setFieldAtColumn: 1 Row: 2  asPlayerOwned: 2.
	self assert: ((boardState getDescendingDiagonalBoardLine:  2) = (#(2 -1) asOrderedCollection)) description:'error when geting diagonaI line'.

	boardState setFieldAtColumn: 7 Row: 6  asPlayerOwned: 2.
	self assert: ((boardState getDescendingDiagonalBoardLine:  1) = (#(2) asOrderedCollection)) description:'error when geting diagonaI line'.
	
	boardState setFieldAtColumn: 2 Row: 6  asPlayerOwned: 2.
	boardState setFieldAtColumn: 4 Row: 4  asPlayerOwned: 1.
	boardState setFieldAtColumn: 5 Row: 3  asPlayerOwned: 2.
	self assert: ((boardState getDescendingDiagonalBoardLine:  7) = (#(2 -1 1 2 -1 -1) asOrderedCollection)) description:'error when geting diagonaI line'.

	
	"can the victor be determined"

	"horizontal winning line"	
	boardState initializeBoardState.
	boardState setFieldAtColumn: 1 Row: 1  asPlayerOwned:2.
	boardState setFieldAtColumn: 2 Row: 1  asPlayerOwned:1.
	boardState setFieldAtColumn: 3 Row: 1  asPlayerOwned:2.
	boardState setFieldAtColumn: 4 Row: 1  asPlayerOwned:2.
	boardState setFieldAtColumn: 5 Row: 1  asPlayerOwned:2.
	boardState setFieldAtColumn: 6 Row: 1  asPlayerOwned:2.
	self assert: ((boardState getVictor) = 2) description: 'horizonzal winner couldnt be determined'.
	
	"vertical winning line"
	boardState initializeBoardState.
	boardState setFieldAtColumn: 1 Row: 1  asPlayerOwned:1.
	boardState setFieldAtColumn: 1 Row: 2  asPlayerOwned:2.
	boardState setFieldAtColumn: 1 Row: 3  asPlayerOwned:1.
	boardState setFieldAtColumn: 1 Row: 4  asPlayerOwned:1.
	boardState setFieldAtColumn: 1 Row: 5  asPlayerOwned:1.
	boardState setFieldAtColumn: 1 Row: 6  asPlayerOwned:1.
	self assert: ((boardState getVictor) = 1) description: 'vertical winner couldnt be determined'.
	"rising diagonal  winning line"
	boardState initializeBoardState.
	boardState setFieldAtColumn: 1 Row: 1  asPlayerOwned:1.
	boardState setFieldAtColumn: 2 Row: 2  asPlayerOwned:2.
	boardState setFieldAtColumn: 3 Row: 3  asPlayerOwned:1.
	boardState setFieldAtColumn: 4 Row: 4  asPlayerOwned:1.
	boardState setFieldAtColumn: 5 Row: 5  asPlayerOwned:1.
	boardState setFieldAtColumn: 6 Row: 6  asPlayerOwned:1.
	self assert: ((boardState getVictor) = 1) description: 'diagonal rising winner couldnt be determined'.

	"faling diagonal  winning line"
	boardState initializeBoardState.
	boardState setFieldAtColumn: 1 Row: 4  asPlayerOwned:1.
	boardState setFieldAtColumn: 2 Row: 3  asPlayerOwned:1.
	boardState setFieldAtColumn: 3 Row: 2  asPlayerOwned:1.
	boardState setFieldAtColumn: 4 Row: 1  asPlayerOwned:1.
	self assert: ((boardState getVictor) = 1) description: 'diagonal falling winner couldnt be determined'.
	
	boardState initializeBoardState.
	boardState setFieldAtColumn: 3 Row: 6  asPlayerOwned:2.
	boardState setFieldAtColumn: 4 Row: 5  asPlayerOwned:2.
	boardState setFieldAtColumn: 5 Row: 4  asPlayerOwned:2.
	boardState setFieldAtColumn: 6 Row: 3  asPlayerOwned:2.
	self assert: ((boardState getVictor) = 2) description: 'diagonal falling winner couldnt be determined'.
	
	"no winning line"
	boardState initializeBoardState.
	boardState setFieldAtColumn: 1 Row: 1  asPlayerOwned:1.
	boardState setFieldAtColumn: 1 Row: 2  asPlayerOwned:2.
	boardState setFieldAtColumn: 1 Row: 3  asPlayerOwned:1.
	boardState setFieldAtColumn: 1 Row: 4  asPlayerOwned:1.
	boardState setFieldAtColumn: 1 Row: 5  asPlayerOwned:2.
	boardState setFieldAtColumn: 1 Row: 6  asPlayerOwned:1.
	self assert: ((boardState getVictor) = -1) description: ' winner determined when no player won'.
	
	"can a draw be detected"
	boardState initializeBoardState.
	self assert: ((boardState isGameDraw) = false) description: ' game is recognised as draw despite not being a draw'.
	1 to: (boardState boardWidth) do:[:aColumn|
			1 to: (boardState boardHeight) do:[:aRow| boardState setFieldAtColumn: aColumn Row: aRow asPlayerOwned: 1].
		].
		self assert: ((boardState isGameDraw) = true) description: ' game  is not recognised as draw despite being a draw'.


	



]

{ #category : 'Not categorized' }
HfuSpConnectFourTests class >> testOrders [
	"<^self>"
	"Tests creation and execution of Game Orders"
	|secondGamestate firstGameState theGameSession theGameSessionId view1 view2 view1Id view2Id gameState|
	HfuSpPlayer  addPlayerIfAbsent: 1.
	HfuSpPlayer  addPlayerIfAbsent: 2.
	
	theGameSessionId := HfuSpGameSessionsManager createGameSession:  'ConnectFour' . 
	view1:= HfuSpGameSessionsManager addPlayer: 1 ToSession: theGameSessionId.
	view1 createComponents.
	view1Id:= view1 playerViewController player id.
	view2 := HfuSpGameSessionsManager addPlayer: 2 ToSession: theGameSessionId.
	view2 createComponents.
	view2Id:= view2 playerViewController player id.
	theGameSession:= HfuSpGameSessionsManager getGameSessionById: theGameSessionId.
	gameState:= theGameSession currentBoardState.
	"can a player be added multiple times to the same session?"
	self assert: (HfuSpGameSessionsManager addPlayer: 1 ToSession: theGameSessionId) = nil .
	"can orders be given before a game starts?"
	self assert:  (view1 playerViewController transmitOrder: 1) = nil description: 'order was prcessed before game start'.

	theGameSession startGame.
	
	"can gameorders be processed"
	view1 playerViewController transmitOrder: 1.
	self assert: (gameState getFieldAtColumn: 1 Row:1 )=1  description: 'game order wasnt processed'.
	
	"can a player give a order when it isnt his turn"
	self assert: (view1 playerViewController transmitOrder: 1) =nil  description: 'game order was processed when it wasnt the players turn'.
	self assert: (gameState getFieldAtColumn: 1 Row:1 )=1  description: 'game order was processed when it wasnt the players turn'.
	
	"can both pIayers act in order"
	view2 playerViewController transmitOrder: 1.
	self assert: (gameState getFieldAtColumn: 1 Row:2 )=2  description: 'game order wasnt processed'.
	
	"can you waste your turn by selecting a column which is already full"
	view1 playerViewController transmitOrder: 2.
	view2 playerViewController transmitOrder: 2.
	view1 playerViewController transmitOrder: 2.
	view2 playerViewController transmitOrder: 2.
	view1 playerViewController transmitOrder: 2.
	view2 playerViewController transmitOrder: 2.
	
	self assert: (view1 playerViewController transmitOrder: 2) =nil  description: 'game order was processed when it wasnt the players turn'.

	"can a field outside of the board be set?"	
	self assert: (view1 playerViewController transmitOrder: (gameState boardWidth +1)) =nil  description: 'game order was processed when it wasnt the players turn'.


	
	
	
]
