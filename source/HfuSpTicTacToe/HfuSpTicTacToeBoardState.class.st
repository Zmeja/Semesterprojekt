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
	aInteger = 1 
		ifTrue: [result add: (self boardTiles at: 1).
					result add: (self boardTiles at: 5).
					result add: (self boardTiles at: 9).]
		ifFalse: [result add: (self boardTiles at: 3).
					result add: (self boardTiles at: 5).
					result add: (self boardTiles at: 7)].
	^result
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
	|currentRow currentCol|
	
	#(1 2 3) do:[:eachRowIndex|
						currentRow:= self getBoardRow: eachRowIndex.
						((currentRow count:[:aField| aField= currentRow first ]) = 3) &  ((currentRow first = -1) not)
							ifTrue: [^currentRow first].
							
						currentCol:= self getBoardCol: eachRowIndex.
						((currentCol count: [:aField| aField= currentCol first ])= 3) &  ((currentCol first = -1) not)
							ifTrue: [^currentCol first].
					].
	
			((self getDiagonal:  1) count:[:aField| aField= ((self getDiagonal: 1) first) ] )=3
				ifTrue: [^ (self getDiagonal: 1) first].
		((self getDiagonal:  2) count:[:aField| aField= ((self getDiagonal: 2) first) ] )=3
				ifTrue: [^ (self getDiagonal: 2) first].
		^-1
	
			

	
]

{ #category : 'API' }
HfuSpTicTacToeBoardState >> initializeBoardState [

	"Initiates empty board "
	self turnOrder:  OrderedCollection new.
	self boardTiles: #(-1 -1 -1 -1 -1 -1 -1 -1 -1) asOrderedCollection
]

{ #category : 'API' }
HfuSpTicTacToeBoardState >> isGameDraw [

	"<^Boolean>"
	"checks if game can be wone by any player
	asumes that there is no current winner"
	
	^ (self boardTiles count: [:aTileOwner| aTileOwner=-1]) =0

	
]

{ #category : 'API' }
HfuSpTicTacToeBoardState >> isValidOrder: anGameOrder [

	"<^self>"
	"Checks if a order is valid"
	anGameOrder class = HfuSpTicTacToeOrder 
		ifFalse: [ ^false.].
	((anGameOrder fieldID) between: 0 and: 9)
		ifFalse: [^false].
	
	^(self boardTiles at: (anGameOrder fieldID) )=-1

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

	"Changes Ownership of a board tile to a Player"
	|tempBoardTiles playerNumber|
	
	self firstPlayer= nil
		ifTrue: [self firstPlayer:aPlayerInteger]
		ifFalse: [ self secondPlayer = nil & (self firstPlayer = aPlayerInteger)not 
							ifTrue: [self secondPlayer:aPlayerInteger]].
	
	self firstPlayer = aPlayerInteger ifTrue: [playerNumber:=1].
	self secondPlayer = aPlayerInteger ifTrue: [playerNumber:=2].
	playerNumber = nil ifTrue: [^nil].
	tempBoardTiles:= self boardTiles.
	
	tempBoardTiles at: aFieldInteger put: playerNumber
	
	
]
