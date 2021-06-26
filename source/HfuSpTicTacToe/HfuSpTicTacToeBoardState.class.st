Class {
	#name : 'HfuSpTicTacToeBoardState',
	#superclass : 'HfuSpBoardState',
	#instVars : [
		'boardTiles',
		'firstPlayer',
		'secondPlayer'
	],
	#category : 'HfuSpTicTacToe'
}

{ #category : 'Not categorized' }
HfuSpTicTacToeBoardState class >> createOrderForField: aFieldInteger ofPlayer: aPlayerInteger [

	"<^self>"
	"Answer the receiver"

	^HfuSpTicTacToeOrder new playerID: aPlayerInteger; fieldID: aFieldInteger;yourself.
]

{ #category : 'Internal' }
HfuSpTicTacToeBoardState >> boardTiles [

	"^Collection"
	"returns the current state of all board tiles "
	
	^boardTiles
]

{ #category : 'Internal' }
HfuSpTicTacToeBoardState >> boardTiles: aCollection [

	"Sets a Collection as new boardTile
	 Indexes Correspond to tiles as follows:
	 1 2 3 
	 4 5 6 
	 7 8 9"

	boardTiles:=aCollection
]

{ #category : 'Accessing' }
HfuSpTicTacToeBoardState >> firstPlayer [

	"<^iOf aInteger>"
	"Answer the firstPlayer of the receiver"

	^firstPlayer
]

{ #category : 'Accessing' }
HfuSpTicTacToeBoardState >> firstPlayer: anaInteger [

	"<anaInteger: iOf aInteger, ^self>"
	"Set the firstPlayer of the receiver"

	firstPlayer := anaInteger
]

{ #category : 'Internal' }
HfuSpTicTacToeBoardState >> getBoardCol: aInteger [

	"<^aCollection>"
	"returns a Row of board Tiles"
	^OrderedCollection new 
		add:( self boardTiles at: aInteger);
		add: (self boardTiles at: aInteger+3);
		add: (self boardTiles at: aInteger+6);
		yourself.
		
]

{ #category : 'Internal' }
HfuSpTicTacToeBoardState >> getBoardRow: aInteger [

	"<^aCollection>"
	"returns a Row of board Tiles"

	^self boardTiles copyFrom: aInteger*3-2 to: aInteger*3 
]

{ #category : 'Internal' }
HfuSpTicTacToeBoardState >> getDiagonal: aInteger [

	"<^aCollection>"
	"returns the values of a diagonal of the board tiles.
	 (1 for 1 5 9 )
	 (2 for 3 5 7)  in 
	 1 2 3 
	 4 5 6
	 7 8 9"
	|result|
	result:= OrderedCollection new.
	^aInteger = 1 
		ifTrue: [
			OrderedCollection new
				add: (self boardTiles at: 1);
				add: (self boardTiles at: 5);
				add: (self boardTiles at: 9);
				yourself]
		ifFalse: [
			OrderedCollection new
				add: (self boardTiles at: 3);
				add: (self boardTiles at: 5);
				add: (self boardTiles at: 7);
				yourself	].
]

{ #category : 'API' }
HfuSpTicTacToeBoardState >> getTile: aInteger [

	"<^aInteger>"
	"returns value of respective field"

	^self boardTiles at: aInteger
]

{ #category : 'API' }
HfuSpTicTacToeBoardState >> getVictor [

	"<^aInteger>"
	"returns player if there is a winner else returns -1"
	|currentRow currentCol potentialVictor|
	
	#(1 2 3) do:[:eachRowIndex|
						"check row for winner"
						currentRow:= self getBoardRow: eachRowIndex.
						potentialVictor:= self getWinnerFromLine: currentRow.
						potentialVictor = -1 
							ifFalse: [^potentialVictor].
						"check column for winner"
						currentCol:= self getBoardCol: eachRowIndex.
						potentialVictor:= self getWinnerFromLine: currentCol.
						potentialVictor = -1 
							ifFalse: [^potentialVictor].
					].
	
		"check for diagonaly rising line for winner"
		potentialVictor:= self getWinnerFromLine: (self getDiagonal:  1).
		potentialVictor = -1 
			ifFalse: [^potentialVictor].
		"check  diagonally falling line for winner"
		potentialVictor:= self getWinnerFromLine: (self getDiagonal:  2).
		potentialVictor = -1 
			ifFalse: [^potentialVictor].
		^-1
	
			

	
]

{ #category : 'Internal' }
HfuSpTicTacToeBoardState >> getWinnerFromLine: aLine [

	"<^self>"
	"checks a Line with 3 eIements for a winner"
	"there is a winner if the same pIayerId is repeted thrice in the Iine "	
	| previousElement|
	previousElement:= nil.
	aLine do:[:currentElement|
						currentElement = -1 
							ifTrue: [^-1].
						previousElement= nil
							ifFalse: [ 
										previousElement= currentElement
											ifFalse: [^-1]
										].
						previousElement:=currentElement.					
					].
	^previousElement
]

{ #category : 'API' }
HfuSpTicTacToeBoardState >> initializeBoardState [

	"Initiates empty board "
	self turnOrder:  OrderedCollection new.
	self boardTiles: #(-1 -1 -1 -1 -1 -1 -1 -1 -1) asOrderedCollection
]

{ #category : 'Internal' }
HfuSpTicTacToeBoardState >> isFieldIndexedInOrderInValidRange: aOrder [

	"<^(true|false)>"
	"determines wether a valid field is indexed"

	^self isIndexedFieldInValidRange: aOrder fieldID.
]

{ #category : 'API' }
HfuSpTicTacToeBoardState >> isGameDraw [

	"<^Boolean>"
	"checks if game can be won by any player
	asumes that there is no current winner"
	
	^ (self boardTiles count: [:aTileOwner| aTileOwner=-1]) =0

	
]

{ #category : 'Internal' }
HfuSpTicTacToeBoardState >> isIndexedFieldInValidRange: aIndexInteger [

	"<^(true|false)>"
	"determines wether a valid field is indexed"

	^aIndexInteger between: 1 and: 9
]

{ #category : 'API' }
HfuSpTicTacToeBoardState >> isValidOrder: aGameOrder [

	"<^self>"
	"Checks if a order is valid"

	^aGameOrder class = HfuSpTicTacToeOrder
		and: [(self isFieldIndexedInOrderInValidRange: aGameOrder)
			and: [(self boardTiles at: aGameOrder fieldID) =-1 ]]
]

{ #category : 'Accessing' }
HfuSpTicTacToeBoardState >> secondPlayer [

	"<^iOf Integer>"
	"Answer the secondPlayer of the receiver"

	^secondPlayer
]

{ #category : 'Accessing' }
HfuSpTicTacToeBoardState >> secondPlayer: anInteger [

	"<anInteger: iOf Integer, ^self>"
	"Set the secondPlayer of the receiver"

	secondPlayer := anInteger
]

{ #category : 'API' }
HfuSpTicTacToeBoardState >> setField: aFieldInteger asPlayerOwned: aPlayerInteger [

	self boardTiles at: aFieldInteger put: aPlayerInteger
	
	
]
