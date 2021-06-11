Class {
	#name : 'HfuSpConnectFourBoardState',
	#superclass : 'HfuSpBoardState',
	#instVars : [
		'board',
		'boardWidth',
		'boardHeight'
	],
	#category : 'HfuSpConnectFour'
}

{ #category : 'API' }
HfuSpConnectFourBoardState >> board [

	"<^iOf aTwoDimensionalArray>"
	"Answer the board of the receiver"

	^board
]

{ #category : 'API' }
HfuSpConnectFourBoardState >> board: anaTwoDimensionalArray [

	"<anaTwoDimensionalArray: iOf aTwoDimensionalArray, ^self>"
	"Set the board of the receiver"

	board := anaTwoDimensionalArray
]

{ #category : 'API' }
HfuSpConnectFourBoardState >> boardHeight [

	"<^iOf Integer>"
	"Answer the boardHeight of the receiver"

	^boardHeight
]

{ #category : 'API' }
HfuSpConnectFourBoardState >> boardHeight: anInteger [

	"<anInteger: iOf Integer, ^self>"
	"Set the boardHeight of the receiver"

	boardHeight := anInteger
]

{ #category : 'API' }
HfuSpConnectFourBoardState >> boardWidth [

	"<^iOf aInteger>"
	"Answer the boardWidth of the receiver"

	^boardWidth
]

{ #category : 'API' }
HfuSpConnectFourBoardState >> boardWidth: anaInteger [

	"<anaInteger: iOf aInteger, ^self>"
	"Set the boardWidth of the receiver"

	boardWidth := anaInteger
]

{ #category : 'Internal' }
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

{ #category : 'Internal' }
HfuSpConnectFourBoardState >> getDescendingDiagonalBoardLine: aInteger [

	"<^aOrderedCollection>"
	"returns a array representing the horizontal line of the board"
	|resultingRow offset|
	resultingRow:= OrderedCollection new.
	aInteger <= self boardHeight 
	ifTrue: [
				1 to: aInteger do:[:currentColumn| resultingRow add: (self getFieldAtColumn: (currentColumn) Row: (aInteger - currentColumn+1))].
				^resultingRow.
				].
	aInteger <= (self boardHeight+ self boardWidth)
	ifTrue: [
				offset:=  aInteger - self boardHeight. 
				(1+ offset) to: (self boardWidth) do:[:currentColumn|  
					resultingRow add: (self getFieldAtColumn: currentColumn 
																				Row: (self boardHeight- currentColumn+offset+1))].
				^resultingRow
	].
	^resultingRow
	
]

{ #category : 'Internal' }
HfuSpConnectFourBoardState >> getFieldAtColumn: aColumnInteger Row: aRowInteger [


	"<^self>"
	"changes  ownership of a field defined by Column and row to a player"
	^((self board )at: aColumnInteger )at: aRowInteger
]

{ #category : 'API' }
HfuSpConnectFourBoardState >> getFirstEmptyFieldInColumn: anInteger [

	"<^anInteger>"
	"returns the first field in a column, which is not occupied by a player"
	|column result|
	((1 to: (self boardWidth)) includes: anInteger)
		ifFalse: [^-1].
	column:= self board at: anInteger.
	result :=column indexOf: -1 ifAbsent: [^-1].
	^result
]

{ #category : 'Internal' }
HfuSpConnectFourBoardState >> getHorizontalBoardLine: aInteger [

	"<^aOrderedCollection>"
	"returns a array representing the horizontal line of the board"
	|resultingRow|
	resultingRow:= OrderedCollection new.
	self board do: [:aColumn| 	resultingRow add: (aColumn at: aInteger)].
	^resultingRow
	
]

{ #category : 'Internal' }
HfuSpConnectFourBoardState >> getRisingDiagonalBoardLine: aInteger [

	"<^aOrderedCollection>"
	"returns a array representing the horizontal line of the board"
	|resultingRow offset|
	resultingRow:= OrderedCollection new.
	aInteger <= self boardHeight 
	ifTrue: [
				1 to: aInteger do:[:currentColumn| resultingRow add: (self getFieldAtColumn: (currentColumn) Row: (self boardHeight-aInteger + currentColumn))].
				^resultingRow.
				].
	aInteger <= (self boardHeight+ self boardWidth)
	ifTrue: [
				offset:=  aInteger - self boardHeight. 
				(1+ offset) to: (self boardWidth) do:[:currentColumn|  
					resultingRow add: (self getFieldAtColumn: currentColumn 
																				Row: (currentColumn-offset))].
				^resultingRow
	].
	"self board do: [:aColumn| 	resultingRow add: (aColumn at: aInteger)]."
	^resultingRow
	
]

{ #category : 'API' }
HfuSpConnectFourBoardState >> getVictor [

	"<^self>"
	"Returns the id of victorious player. if no player Won -1 is returned"
	|victorId|
	victorId:=-1.
	"check all vertical lines for Victors"
	self board do: [:aColumn| 	victorId:= self checkCollectionForVictor:  aColumn . 
												victorId = -1
													ifFalse: [^victorId]].
	"check for horizontal winners"
	1 to: (self boardHeight) do:[:aRow | 	victorId:= self checkCollectionForVictor: (self getHorizontalBoardLine: aRow).
																victorId = -1
																	ifFalse:[^victorId]].
	
	1 to: (self boardHeight+ self boardWidth -1) 
				do:[:aRow | 	victorId:= self checkCollectionForVictor: (self getRisingDiagonalBoardLine: aRow).
																victorId = -1
																	ifFalse:[^victorId]].
	1 to: (self boardHeight+ self boardWidth -1) 
				do:[:aRow | 	victorId:= self checkCollectionForVictor: (self getDescendingDiagonalBoardLine:  aRow).
																victorId = -1
																	ifFalse:[^victorId]].
	
	^-1
	
]

{ #category : 'API' }
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

{ #category : 'API' }
HfuSpConnectFourBoardState >> isGameDraw [

	"<^Boolean>"
	"Returnes wether the game is a draw (it is so if no player can make any moves)"

	|unusedFieldsCount|
	unusedFieldsCount:= 0.
	
	self board do: [:eachColumn| 
							eachColumn do: [:eachField| eachField= -1 ifTrue: 
																					[unusedFieldsCount:= unusedFieldsCount+1]
														]
							].
	^unusedFieldsCount=0
]

{ #category : 'API' }
HfuSpConnectFourBoardState >> isValidOrder: aGameOrder [

	"<^self>"
	"Checks if a order is valid"
	((1 to: (self boardWidth)) includes: aGameOrder columnId)
		ifFalse:[^false].	
	^ (self board at: (aGameOrder columnId)) includes: -1
]

{ #category : 'API' }
HfuSpConnectFourBoardState >> setFieldAtColumn: aColumnInteger Row: aRowInteger AsPlayerOwned: aPlayerId [

	"<^self>"
	"changes  ownership of a field defined by Column and row to a player"
	((self board )at: aColumnInteger )at: aRowInteger put: aPlayerId.
]
