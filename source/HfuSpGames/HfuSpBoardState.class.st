Class {
	#name : 'HfuSpBoardState',
	#superclass : 'Object',
	#instVars : [
		'turnOrder'
	],
	#category : 'HfuSpGames'
}

{ #category : 'Accessing' }
HfuSpBoardState >> addPlayerToTurnOrder: anPlayerID [

	"<^self>"
	"Answer the receiver"

	self turnOrder addLast: anPlayerID
]

{ #category : 'Accessing' }
HfuSpBoardState >> initializeBoardState [

	"<^self>"
	"Answer the receiver"

	self subclassResponsibility
]

{ #category : 'Accessing' }
HfuSpBoardState >> isValidOrder: aGameOrder [

	"<^self>"
	"Checks if a order is valid"

	self subclassResponsibility
]

{ #category : 'Accessing' }
HfuSpBoardState >> makePlayerOrderStep [

	"<^self>"
	"Sets new player as Acting Player, adds prevous Acting Player at the lists End"

	self turnOrder: (self turnOrder copyFrom: (self turnOrder second) to: (self turnOrder last)).
]

{ #category : 'Accessing' }
HfuSpBoardState >> makeTurnOrderStep [

	"<^self>"
	"Sets new player as Acting Player, adds prevous Acting Player at the lists End"
	|tempOrder tempFirst|
	tempFirst:= self turnOrder first.
	tempOrder := self turnOrder copyFrom: 2 to: (self turnOrder lastIndex ). 
	tempOrder  add: tempFirst.
	self turnOrder: tempOrder.
]

{ #category : 'Accessing' }
HfuSpBoardState >> turnOrder [

	"<^iOf OrderedCollection>"
	"Answer the playerOrder of the receiver"

	^turnOrder
]

{ #category : 'Accessing' }
HfuSpBoardState >> turnOrder: anOrderedCollection [

	"<anOrderedCollection: iOf OrderedCollection, ^self>"
	"Set the playerOrder of the receiver"

	turnOrder := anOrderedCollection
]
