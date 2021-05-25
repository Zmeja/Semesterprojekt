Class {
	#name : 'HfuSpTicTacToeOrder',
	#superclass : 'HfuSpGameOrder',
	#instVars : [
		'fieldID'
	],
	#category : 'HfuSpGames'
}

{ #category : 'Accessing' }
HfuSpTicTacToeOrder >> fieldID [

	"sets fieldID to value aInteger"

	^fieldID 
]

{ #category : 'Accessing' }
HfuSpTicTacToeOrder >> fieldID: aInteger [

	"sets fieldID to value aInteger"

	fieldID := aInteger
]
