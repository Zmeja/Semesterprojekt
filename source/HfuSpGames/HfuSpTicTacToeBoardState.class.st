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
HfuSpTicTacToeBoardState >> initiateBoardState [

	"Initiates empty board "
	
	self boardTiles: #(-1 -1 -1 -1 -1 -1 -1 -1 -1) asOrderedCollection
]

{ #category : 'Not categorized' }
HfuSpTicTacToeBoardState >> setField: aFieldInteger asPlayerOwned: aPlayerInteger [

	"Initiates empty board "
	|tempBoardTiles|
	tempBoardTiles:= self boardTiles.
	
	tempBoardTiles at: aFieldInteger put: aPlayerInteger
	
]
