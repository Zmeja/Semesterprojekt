Class {
	#name : 'HfuSpBoardState',
	#superclass : 'Object',
	#instVars : [
		'turnOrder'
	],
	#category : 'HfuSpGames'
}

{ #category : 'API' }
HfuSpBoardState >> addPlayerToTurnOrder: aPlayerIdInteger [

	"<^self>"
	"Adds a Player to the turnorder of active players
	 within said list players are identified via playerID"

	self turnOrder addLast: aPlayerIdInteger
]

{ #category : 'API' }
HfuSpBoardState >> getActingPlayer [
	"<^self>"
	"Answer the receiver"

	^self turnOrder first.
]

{ #category : 'API' }
HfuSpBoardState >> getActingPlayerId [
	"<^self>"
	"Answer the receiver"

	^self getActingPlayer id.
]

{ #category : 'API' }
HfuSpBoardState >> getVictor [

	"<^self>"
	"Answer the receiver"

	self subclassResponsibility.
]

{ #category : 'API' }
HfuSpBoardState >> initializeBoardState [

	"<^self>"
	"Creates the boardstate of  a unstarted game"

	self subclassResponsibility
]

{ #category : 'API' }
HfuSpBoardState >> isGameDraw [

	"<^Boolean>"
	"Returnes wether the game is a draw (it is so if no player can make any moves that result in a victory)"

	self subclassResponsibility.
]

{ #category : 'API' }
HfuSpBoardState >> isValidOrder: aGameOrder [

	"<^self>"
	"Checks if a order is valid"

	self subclassResponsibility
]

{ #category : 'API' }
HfuSpBoardState >> makeTurnOrderStep [

	"<^self>"
	"Sets new player as Acting Player, adds prevous Acting Player at the lists End"

	self turnOrder: ((self turnOrder copyFrom: 2 to: self turnOrder lastIndex)  add: self turnOrder first; yourself).
]

{ #category : 'API' }
HfuSpBoardState >> turnOrder [

	"<^iOf OrderedCollection>"
	"Answer the playerOrder of the receiver"

	^turnOrder
]

{ #category : 'API' }
HfuSpBoardState >> turnOrder: aOrderedCollection [

	"<anOrderedCollection: iOf OrderedCollection, ^self>"
	"Set the playerOrder of the receiver"

	turnOrder := aOrderedCollection
]
