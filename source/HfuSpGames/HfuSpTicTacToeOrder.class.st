Class {
	#name : 'HfuSpTicTacToeOrder',
	#superclass : 'HfuSpGameOrder',
	#instVars : [
		'fieldID'
	],
	#category : 'HfuSpGames'
}

{ #category : 'Not categorized' }
HfuSpTicTacToeOrder >> fieldID [

	"sets fieldID to value aInteger"

	^fieldID 
]

{ #category : 'Not categorized' }
HfuSpTicTacToeOrder >> fieldID: aInteger [

	"sets fieldID to value aInteger"

	fieldID := aInteger
]
