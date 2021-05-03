Class {
	#name : 'HfuSpGameOrder',
	#superclass : 'Object',
	#instVars : [
		'playerID'
	],
	#category : 'HfuSpGames'
}

{ #category : 'Accessing' }
HfuSpGameOrder >> playerID [

	"<^self>"
	"Answer the receiver"

	^playerID
]

{ #category : 'Accessing' }
HfuSpGameOrder >> playerID: aInteger [

	"<>"
	"Sets playerID for this Order"

	playerID:= aInteger
]
