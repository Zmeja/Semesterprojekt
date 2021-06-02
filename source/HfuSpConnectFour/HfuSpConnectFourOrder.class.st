Class {
	#name : 'HfuSpConnectFourOrder',
	#superclass : 'HfuSpGameOrder',
	#instVars : [
		'columnId'
	],
	#category : 'HfuSpConnectFour'
}

{ #category : 'Accessing' }
HfuSpConnectFourOrder >> columnId [

	"<^iOf Integer>"
	"Answer the columnId of the receiver"

	^columnId
]

{ #category : 'Accessing' }
HfuSpConnectFourOrder >> columnId: anInteger [

	"<anInteger: iOf Integer, ^self>"
	"Set the columnId of the receiver"

	columnId := anInteger
]
