Class {
	#name : 'HfuSpTicTacToeOrder',
	#superclass : 'HfuSpGameOrder',
	#instVars : [
		'fieldID'
	],
	#category : 'HfuSpTicTacToe'
}

{ #category : 'Not categorized' }
HfuSpTicTacToeOrder class >> createOrderForField: aFieldInteger ofPlayer: aPlayerInteger [

	"<^self>"
	"Answer the receiver"

	^HfuSpTicTacToeOrder new 
		playerID: aPlayerInteger; 
		fieldID: aFieldInteger; 
		yourself.
]

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
