Class {
	#name : 'HfuSpTicTacToeBoardState',
	#superclass : 'HfuSpBoardState',
	#instVars : [
		'boardTiles'
	],
	#category : 'HfuSpGames'
}

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
	
	#(1 2 3) do:[:eachLine|
			((self getBoardCol: eachLine) count:[:aField| aField= ((self getBoardCol: eachLine) first) ] )=3
				ifTrue: [^ (self getBoardCol: eachLine) first].
			((self getBoardRow: eachLine) count:[:aField| aField= ((self getBoardRow: eachLine) first) ] )=3
				ifTrue: [^ (self getBoardRow: eachLine) first].
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
	turnOrder:= OrderedCollection new.
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

{ #category : 'API' }
HfuSpTicTacToeBoardState >> setField: aFieldInteger asPlayerOwned: aPlayerInteger [

	"Changes Ownership of a board tile to a Player"
	|tempBoardTiles|
	tempBoardTiles:= self boardTiles.
	
	tempBoardTiles at: aFieldInteger put: aPlayerInteger
	
]
