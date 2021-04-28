Class {
	#name : 'HfuSpTicTacToeBoardState',
	#superclass : 'HfuSpBoardState',
	#instVars : [
		'boardTiles'
	],
	#category : 'HfuSpGames'
}

{ #category : 'Not categorized' }
HfuSpTicTacToeBoardState >> boardTiles [

	"^Collection"
	
	^boardTiles
]

{ #category : 'Not categorized' }
HfuSpTicTacToeBoardState >> boardTiles: aCollection [

	"Sets a Collection as new boardTile
	 Indexes Correspond to tiles as follows:
	 1 2 3 
	 4 5 6 
	 7 8 9"

	boardTiles:=aCollection
]

{ #category : 'Not categorized' }
HfuSpTicTacToeBoardState >> getBoardCol: aInteger [

	"<^aCollection>"
	"returns a Row of board Tiles"
	^OrderedCollection new 
		add:( self boardTiles at: aInteger);
		add: (self boardTiles at: aInteger+3);
		add: (self boardTiles at: aInteger+6);
		yourself.
		
]

{ #category : 'Not categorized' }
HfuSpTicTacToeBoardState >> getBoardRow: aInteger [

	"<^aCollection>"
	"returns a Row of board Tiles"

	^self boardTiles copyFrom: aInteger*3-2 to: aInteger*3 
]

{ #category : 'Not categorized' }
HfuSpTicTacToeBoardState >> getDiagonal: aInteger [

	"<^aCollection>"
	"returns a diagonal 
	 (1 for 1 5 9 )
	 (2 for 3 5 7)"
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

{ #category : 'Not categorized' }
HfuSpTicTacToeBoardState >> getTile: aInteger [

	"<^aInteger>"
	"returns value of respective field"

	^self boardTiles at: aInteger
]

{ #category : 'Not categorized' }
HfuSpTicTacToeBoardState >> getVictor [

	"<^aInteger>"
	"returns player if there is a winner else returns -1"
	
	"(self boardTiles at:1) = (self boardTiles at:2) &  (self boardTiles at:2) =(self boardTiles at: 3 )
		ifTrue: [^true].
	^false"
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
		
			
	^-99		
	
]

{ #category : 'Not categorized' }
HfuSpTicTacToeBoardState >> initializeBoardState [

	"Initiates empty board "
	self turnOrder: OrderedCollection new.
	self boardTiles: #(-1 -1 -1 -1 -1 -1 -1 -1 -1) asOrderedCollection
]

{ #category : 'Not categorized' }
HfuSpTicTacToeBoardState >> isGameDraw [

	"<^Boolean>"
	"checks if game can be wone by any player
	asumes that there is no current winner"
	
	^ (self boardTiles count: [:aTileOwner| aTileOwner=-1]) =0

	
]

{ #category : 'Not categorized' }
HfuSpTicTacToeBoardState >> isValidOrder: anGameOrder [

	"<^self>"
	"Checks if a order is valid"
	anGameOrder class = HfuSpTicTacToeOrder 
		ifFalse: [ ^false.].
	((anGameOrder fieldID) between: 0 and: 9)
		ifFalse: [^false].
	
	^(self boardTiles at: (anGameOrder fieldID) )=-1

]

{ #category : 'Not categorized' }
HfuSpTicTacToeBoardState >> setField: aFieldInteger asPlayerOwned: aPlayerInteger [

	"Changes Ownership of a field to a Player"
	|tempBoardTiles|
	tempBoardTiles:= self boardTiles.
	
	tempBoardTiles at: aFieldInteger put: aPlayerInteger
	
]
