Class {
	#name : 'HfuSpManDontGetAngryTests',
	#superclass : 'TestCase',
	#category : 'HfuSpGamesTestCases'
}

{ #category : 'Not categorized' }
HfuSpManDontGetAngryTests class >> player1_identification [

	"<^self>"
	"Answer the receiver"

	^Dictionary new
		at: 'id' put: '00000000000000000001';
		at: 'email' put:'player1@gmail.com';
		at: 'family_name' put:'lastName1';
		at: 'given_name' put:'firstName1';
		at: 'locale' put:'de';
		at: 'name' put:'display_Name1';
		at: 'picture' put:'img_path';
		at: 'verified_email' put: false;
		yourself.
		
]

{ #category : 'Not categorized' }
HfuSpManDontGetAngryTests class >> player2_identification [

	"<^self>"
	"Answer the receiver"

	^Dictionary new
		at: 'id' put: '00000000000000000002';
		at: 'email' put:'player2@gmail.com';
		at: 'family_name' put:'lastName2';
		at: 'given_name' put:'firstName2';
		at: 'locale' put:'de';
		at: 'name' put:'display_Name2';
		at: 'picture' put:'img_path';
		at: 'verified_email' put: false;
		yourself.
		
]

{ #category : 'Not categorized' }
HfuSpManDontGetAngryTests class >> testAll [
	
	self testOrders.
	self testGameState.
]

{ #category : 'Not categorized' }
HfuSpManDontGetAngryTests class >> testGameState [

	|boardState board lastFields figureFields|
	
	"checks initialisation"
	boardState:= HfuSpManDontGetAngryBoardState new initializeBoardState yourself.
	board:= boardState board yourself. 
	lastFields:= boardState lastFields yourself.
	figureFields:= boardState figureFields yourself.
	1 to: 40 do: [:aField| self assert: ((board at: aField) = 0 ) description: 'initialisation failed' ].
	1 to: 16 do: [:aField| self assert: ((lastFields at: aField) = false ) description: 'initialisation failed' ].
	1 to: 4 do: [:aField| self assert: ((figureFields at: aField) = 4 ) description: 'initialisation failed' ].
	
	"can field ownership be changed"
	boardState setPlayerat: 1 withcolor:  1. 
	self assert:  (boardState isOwnPlayer: 1 onField: 1 ) = true description: 'error when seting field ownership'.
	boardState setPlayerat: 2 withcolor:  1. 
	self assert:  (boardState isOwnPlayer: 1 onField: 2 ) = true description: 'error when seting field ownership'.
	self assert:  (boardState isOwnPlayer: 1 onField: 3 ) = false description: 'error when seting field ownership'.
	
	"decide Victor"
	self assert: (boardState getVictor = -1) description: 'error player is victor'.
	1 to: 4 do:[:aField| boardState lastFields at: aField put: true ].	
	self assert: (boardState getVictor = 'Blue')  description: 'error player isnt victor' .
	self assert: (boardState getVictor ~= 'Red')  description: 'error player is victor' .
	
	
	
	
	
	
	
]

{ #category : 'Not categorized' }
HfuSpManDontGetAngryTests class >> testOrders [
	
	|theGameSession theGameSessionId view1 view2 view1Id view2Id gameState|
	HfuSpPlayer  addPlayerIfAbsent: (self player1_identification).
	HfuSpPlayer  addPlayerIfAbsent: (self player2_identification).
	
	theGameSessionId := HfuSpGameSessionsManager createGameSession:  'Connect Four' . 
	view1:= HfuSpGameSessionsManager addPlayer: (self player1_identification at:'id') ToSession: theGameSessionId.
	view1 createComponents.
	view1Id := view1 playerViewController player id.
	view2 := HfuSpGameSessionsManager addPlayer: (self player2_identification at:'id') ToSession: theGameSessionId.
	view2 createComponents.
	view2Id:= view2 playerViewController player id.
	theGameSession:= HfuSpGameSessionsManager getGameSessionById: theGameSessionId.
	gameState:= theGameSession currentBoardState.
	"can a player be added multiple times to the same session?"
	self assert: (HfuSpGameSessionsManager addPlayer: '0000000000000000000003' ToSession: theGameSessionId) = nil .
	"can orders be given before a game starts?"
	self assert:  (view1 playerViewController transmitOrder: view1Id) = nil description: 'order was prcessed before game start'.
	
	theGameSession startGame.
	
	"can gameorders be processed"
	view1 playerViewController transmitOrder: 1.
	self assert: (gameState getFieldAtColumn: 1 Row:1 )=view1Id  description: 'game order wasnt processed'.
	
	
	"can a player give a order when it isnt his turn"
	self assert: (view1 playerViewController transmitOrder: 1) =nil  description: 'game order was processed when it wasnt the players turn'.
	self assert: (gameState getFieldAtColumn: 1 Row:1 )=view1Id  description: 'game order was processed when it wasnt the players turn'.
	
	"can both pIayers act in order"
	view2 playerViewController transmitOrder: 1.
	self assert: (gameState getFieldAtColumn: 1 Row:2 )=view2Id  description: 'game order wasnt processed'.
	
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
