Class {
	#name : 'HfuSpConnectFourBoardState',
	#superclass : 'HfuSpBoardState',
	#instVars : [
		'board',
		'boardWidth',
		'boardHeight'
	],
	#category : 'HfuSpGames'
}

{ #category : 'Accessing' }
HfuSpConnectFourBoardState >> board [

	"<^iOf aTwoDimensionalArray>"
	"Answer the board of the receiver"

	^board
]

{ #category : 'Accessing' }
HfuSpConnectFourBoardState >> board: anaTwoDimensionalArray [

	"<anaTwoDimensionalArray: iOf aTwoDimensionalArray, ^self>"
	"Set the board of the receiver"

	board := anaTwoDimensionalArray
]

{ #category : 'Accessing' }
HfuSpConnectFourBoardState >> boardHeight [

	"<^iOf Integer>"
	"Answer the boardHeight of the receiver"

	^boardHeight
]

{ #category : 'Accessing' }
HfuSpConnectFourBoardState >> boardHeight: anInteger [

	"<anInteger: iOf Integer, ^self>"
	"Set the boardHeight of the receiver"

	boardHeight := anInteger
]

{ #category : 'Accessing' }
HfuSpConnectFourBoardState >> boardWidth [

	"<^iOf aInteger>"
	"Answer the boardWidth of the receiver"

	^boardWidth
]

{ #category : 'Accessing' }
HfuSpConnectFourBoardState >> boardWidth: anaInteger [

	"<anaInteger: iOf aInteger, ^self>"
	"Set the boardWidth of the receiver"

	boardWidth := anaInteger
]

{ #category : 'Accessing' }
HfuSpConnectFourBoardState >> checkCollectionForVictor: aCollection [
	"<^aPlayerID>"
	"checks if a player owns four consecutive fields in a row. returns winning player. if no player Won returns -1 "
	|lastPlayer consecutiveOwnedFields|
	consecutiveOwnedFields:=0.
	lastPlayer:=-2.
	aCollection do:[:currentField| 
											   ((currentField = -1) not ) & (currentField=lastPlayer)
													ifTrue:[consecutiveOwnedFields:= consecutiveOwnedFields +1].
												((currentField = -1) not ) & ((currentField=lastPlayer) not )
													ifTrue:[	lastPlayer:= currentField.
																consecutiveOwnedFields:=1].
												consecutiveOwnedFields=4 
													ifTrue:[^lastPlayer].
											  ].
	^-1
	
	
	
	
]

{ #category : 'Accessing' }
HfuSpConnectFourBoardState >> getDiagonalAscendingBoardLine: aInteger [

	"<^aOrderedCollection>"
	"returns a array representing the horizontal line of the board"
	|resultingCollection aColumnInteger aRowInteger|
	aRowInteger:=aInteger.
	aColumnInteger:=1.
	resultingCollection:= OrderedCollection new.
	aInteger to: 1 do: [:currentNumber| 	resultingCollection add: ((self board at: aColumnInteger )at: aRowInteger).
																aRowInteger:=aRowInteger+1.
																aColumnInteger:=aColumnInteger+1].

	^resultingCollection
	
]

{ #category : 'Accessing' }
HfuSpConnectFourBoardState >> getFirstEmptyFieldInColumn: anInteger [

	"<^anInteger>"
	"returns the first field in a column, which is not occupied by a player"
	|column result|
	((1 to: (self boardWidth)) includes: anInteger)
		ifFalse: [^nil].
	column:= self board at: anInteger.
	result :=column indexOf: -1 ifAbsent: [^-1].
	^result
]

{ #category : 'Accessing' }
HfuSpConnectFourBoardState >> getHorizontalBoardLine: aInteger [

	"<^aOrderedCollection>"
	"returns a array representing the horizontal line of the board"
	|resultingRow|
	resultingRow:= OrderedCollection new.
	self board do: [:aColumn| 	resultingRow add: (aColumn at: aInteger)].
	^resultingRow
	
]

{ #category : 'Accessing' }
HfuSpConnectFourBoardState >> getVictor [

	"<^self>"
	"Returns the id of victorious player. if no player Won -1 is returned"
	|victorId|
	victorId:=-1.
	"check all vertical lines for Victors"
	self board do: [:aColumn| 	victorId:= self checkCollectionForVictor:  aColumn . 
												victorId = -1
													ifFalse: [^victorId]].
	1 to: (self boardHeight) do:[:aRow | 	victorId:= self checkCollectionForVictor: (self getHorizontalBoardLine: aRow).
																victorId = -1
																	ifFalse:[^victorId]].
	
	
	^-1
	
]

{ #category : 'Accessing' }
HfuSpConnectFourBoardState >> initializeBoardState [

	"<^self>"
	"Creates the boardstate of  a unstarted game"
	|Column|
	self turnOrder:  OrderedCollection new.

	self boardWidth:7.
	self boardHeight: 6.
	self board: OrderedCollection new.
	Column := OrderedCollection new.
	
	1 to: (self boardHeight) do:[:field|Column add: -1].
	1 to: (self boardWidth) do:[:Col|self board add: (Column copy)].
	
	^self
]

{ #category : 'Accessing' }
HfuSpConnectFourBoardState >> isGameDraw [

	"<^Boolean>"
	"Returnes wether the game is a draw (it is so if no player can make any moves that result in a victory)"

	|unusedFieldsCount|
	unusedFieldsCount:= 0.
	
	self board do: [:eachColumn| 
							eachColumn do: [:eachField| eachField= -1 ifTrue: 
																					[unusedFieldsCount:= unusedFieldsCount+1]
														]
							].
	^unusedFieldsCount=0
]

{ #category : 'Accessing' }
HfuSpConnectFourBoardState >> isValidOrder: aGameOrder [

	"<^self>"
	"Checks if a order is valid"

	^ (self board at: (aGameOrder columnId)) includes: -1
]

{ #category : 'Accessing' }
HfuSpConnectFourBoardState >> setFieldAsPlayerOwned [

	"<^self>"
	"Answer the receiver"

	self
]

{ #category : 'Accessing' }
HfuSpConnectFourBoardState >> setFieldAtColumn: aColumnInteger Row: aRowInteger AsPlayerOwned: aPlayerId [

	"<^self>"
	"changes  ownership of a field defined by Column and row to a player"
	((self board )at: aColumnInteger )at: aRowInteger put: aPlayerId.
]
