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
	"the Board is a two dimensional array.
	 The first dimension represents the columns, 
	 the second dimension represents the row.
	board at: 0 at: 0 represents the bottom left corner of the board.
	board at: (self boardWidth) at: (self boardHeight) represents the top right corner.
	 "

	^board
]

{ #category : 'API' }
HfuSpConnectFourBoardState >> board: aTwoDimensionalArray [

	"<anaTwoDimensionalArray: iOf aTwoDimensionalArray, ^self>"
	"Set the board of the receiver"

	board := aTwoDimensionalArray
]

{ #category : 'API' }
HfuSpConnectFourBoardState >> boardHeight [

	"<^iOf Integer>"
	"Answer the boardHeight of the receiver"

	^boardHeight
]

{ #category : 'API' }
HfuSpConnectFourBoardState >> boardHeight: aInteger [

	"<anInteger: iOf Integer, ^self>"
	"Set the boardHeight of the receiver"

	boardHeight := aInteger
]

{ #category : 'API' }
HfuSpConnectFourBoardState >> boardWidth [

	"<^iOf aInteger>"
	"Answer the boardWidth of the receiver"

	^boardWidth
]

{ #category : 'API' }
HfuSpConnectFourBoardState >> boardWidth: aInteger [

	"<anaInteger: iOf aInteger, ^self>"
	"Set the boardWidth of the receiver"

	boardWidth := aInteger
]

{ #category : 'Internal' }
HfuSpConnectFourBoardState >> checkCollectionForVictor: aCollection [
	"<^aPlayerID>"
	"checks if a player owns four consecutive fields in a row. returns winning player. if no player Won returns -1 "
	|lastPlayer consecutiveOwnedFields|
	
	consecutiveOwnedFields:=0.
	lastPlayer := -2.
	
	aCollection do:[:currentField| 
		currentField ~= -1
			ifTrue: [ 
				currentField = lastPlayer
					ifTrue:[consecutiveOwnedFields := consecutiveOwnedFields + 1]
					ifFalse: [lastPlayer := currentField.
								consecutiveOwnedFields := 1].		
				]
		ifFalse: [consecutiveOwnedFields := 0].
				
			consecutiveOwnedFields = 4 
				ifTrue:[^lastPlayer]
				].
	^-1
	
	
	
	
]

{ #category : 'Internal' }
HfuSpConnectFourBoardState >> getDescendingDiagonalBoardLine: aInteger [

	"<^aOrderedCollection>"
	"returns a array representing the horizontal line of the board"
	|resultingRow offset|
	resultingRow := OrderedCollection new.
	aInteger <= self boardHeight 
		ifTrue: [
				1 to: aInteger do: [:currentColumn| resultingRow add: (self getFieldAtColumn: (currentColumn) Row: (aInteger - currentColumn+1))].
				^resultingRow.
				].
	aInteger <= (self boardHeight+ self boardWidth)
		ifTrue: [
				offset:=  aInteger - self boardHeight. 
				(1+ offset) to: (self boardWidth) do: [:currentColumn|  
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
HfuSpConnectFourBoardState >> getFirstEmptyFieldInColumn: aInteger [

	"<^anInteger>"
	"returns the first field in a column, which is not occupied by a player"
	|column|
	((1 to: (self boardWidth)) includes: aInteger)
		ifFalse: [^-1].
	column := self board at: aInteger.
	^column indexOf: -1 ifAbsent: [^-1].
	
]

{ #category : 'Internal' }
HfuSpConnectFourBoardState >> getHorizontalBoardLine: aInteger [

	"<^aOrderedCollection>"
	"returns a array representing the horizontal line of the board"
	"aInteger =1 represents the line at the bottom of the field"

	^self board collect:[:aColumn| aColumn at: aInteger].
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
					resultingRow add: (
						self getFieldAtColumn: currentColumn Row: (currentColumn-offset))].
				^resultingRow].
				
	^resultingRow
	
]

{ #category : 'API' }
HfuSpConnectFourBoardState >> getVictor [

	"<^aInteger>"
	"Returns the id of victorious player. if no player Won -1 is returned"
	|victorId|
	victorId :=-1.
	"check all vertical lines for Victors"
	self board do: [:aColumn| 	
		victorId := self checkCollectionForVictor:  aColumn. 
		victorId = -1
			ifFalse: [^victorId]].
			
	"check for  winner in horizontal line"
	1 to: (self boardHeight) do:[:aRow | 	
		victorId := self checkCollectionForVictor: (self getHorizontalBoardLine: aRow).
		victorId = -1
			ifFalse:[^victorId]].
	
	1 to: (self boardHeight + self boardWidth -1) 
				do:[:eachRow | 	
					"check for winers in diagonaly rising lines"
					victorId:= self checkCollectionForVictor: (self getRisingDiagonalBoardLine: eachRow).
					victorId = -1
						ifFalse: [^victorId].
					
					"check for winners in diagonally falling lines"
					victorId:= self checkCollectionForVictor: (self getDescendingDiagonalBoardLine:  eachRow).
					victorId = -1
						ifFalse: [^victorId]].

	^-1
	
]

{ #category : 'API' }
HfuSpConnectFourBoardState >> initializeBoardState [

	"<^self>"
	"Creates the boardstate of  a unstarted game"
	|column|
	self 
		turnOrder:  OrderedCollection new;
		boardWidth:7;
		boardHeight: 6;
		board: OrderedCollection new;
		yourself.
		
	column := OrderedCollection new.
	
	1 to: self boardHeight do: [:field| column add: -1].
	1 to: self boardWidth do: [:Col|self board add: (column copy)].
	
]

{ #category : 'API' }
HfuSpConnectFourBoardState >> isGameDraw [

	"<^(true|false)>"
	"Returnes wether the game is a draw (it is so if no player can make any moves)"

	|unusedFieldsCount|
	unusedFieldsCount := 0.
	
	self board do: [:eachColumn| 
		eachColumn do: [:eachField| eachField= -1 
			ifTrue: [unusedFieldsCount := unusedFieldsCount+1]]].
	^unusedFieldsCount=0
]

{ #category : 'Internal' }
HfuSpConnectFourBoardState >> isValidHeightIndex: aIndexInteger [

	"<^(true|false)>"
	"returns wether aIndexInteger is within bounds (width)"

	^ (1 to: self  boardHeight) includes: aIndexInteger
]

{ #category : 'API' }
HfuSpConnectFourBoardState >> isValidOrder: aGameOrder [

	"<^(true|false)>"
	"Checks if a order is valid"
	"a order is valid if there is a column with the coresponding id and that column is not entirely  filled " 
	
	^(self isValidWidthIndex:  (aGameOrder columnId) )
		and: [ (self board at: (aGameOrder columnId) ) includes: -1]
]

{ #category : 'Internal' }
HfuSpConnectFourBoardState >> isValidWidthIndex: aIndexInteger [

	"<^(true|false)>"
	"returns wether aIndexInteger is within bounds (width)"

	^ (1 to: self boardWidth) includes: aIndexInteger
]

{ #category : 'API' }
HfuSpConnectFourBoardState >> setFieldAtColumn: aColumnInteger Row: aRowInteger asPlayerOwned: aPlayerId [

	"<^self>"
	"changes  ownership of a field defined by Column and row to a player"
	((self board) at: aColumnInteger) at: aRowInteger put: aPlayerId.
]
