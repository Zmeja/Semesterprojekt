Class {
	#name : 'HfuSpManDontGetAngryBoardState',
	#superclass : 'HfuSpBoardState',
	#instVars : [
		'board',
		'lastFields'
	],
	#classInstVars : [
		'yellowOffset',
		'blueOffset',
		'redOffset'
	],
	#category : 'HfuSpManDontGetAngry'
}

{ #category : 'Accessing' }
HfuSpManDontGetAngryBoardState >> board [

	^board
]

{ #category : 'Accessing' }
HfuSpManDontGetAngryBoardState >> board: anObject [

	board := anObject
]

{ #category : 'Not categorized' }
HfuSpManDontGetAngryBoardState >> getStartfieldWithOffset: aOffset [

	"return Startfield"
	
	^(aOffset*10+1)
	
]

{ #category : 'Not categorized' }
HfuSpManDontGetAngryBoardState >> getVictor [

	((self lastFields copyFrom: 1 to: 4) = #( true true true true) asOrderedCollection)
		ifTrue:[^'Green'].
	((self lastFields copyFrom: 5 to: 8) = #( true true true true) asOrderedCollection)
		ifTrue:[^'Yellow'].
	((self lastFields copyFrom: 9 to: 12) = #( true true true true) asOrderedCollection)
		ifTrue:[^'Blue'].
	((self lastFields copyFrom: 13 to: 16) = #( true true true true) asOrderedCollection)
		ifTrue:[^'Red'].
	^-1
]

{ #category : 'Not categorized' }
HfuSpManDontGetAngryBoardState >> initializeBoardState [

	"<^self>"
	"Creates the boardstate of  a unstarted game"
	self turnOrder:  OrderedCollection new.
	self board: OrderedCollection new.
	1 to: 40 do: [:aField| self board add: 0].
	self lastFields: OrderedCollection new.
	1 to: 16 do:[:aField|self lastFields add: false].
	
]

{ #category : 'Not categorized' }
HfuSpManDontGetAngryBoardState >> isField: currentField overLastField: aNextField withOffset: aOffset [

	|lastField nextField|
	nextField := aNextField.
	lastField := aOffset*10.
	(nextField<currentField)
		ifTrue: [nextField:= nextField + 40].
	((currentField<lastField) and: (lastField<nextField))
		ifTrue: [^(nextField-currentField)]
		ifFalse: [^0].
	


]

{ #category : 'Not categorized' }
HfuSpManDontGetAngryBoardState >> isGameDraw [

	"<^Boolean>"
	"Returnes wether the game is a draw (it is so if no player can make any moves that result in a victory)"

	^false 
]

{ #category : 'Accessing' }
HfuSpManDontGetAngryBoardState >> isOwnPlayer: aOffset onField: aField [

	^((self board at: aField) = (aOffset + 1))

	


]

{ #category : 'Accessing' }
HfuSpManDontGetAngryBoardState >> isPlayerOnField: aField [

	 ((self board at: aField) ~= 0)
		ifTrue: [^true].
	^false

	
]

{ #category : 'Not categorized' }
HfuSpManDontGetAngryBoardState >> isValidOrder: anOrder [

	"|playerViewController |
	playerViewController := (HfuSpManDontGetAngryTurnStateController playerViewControllers at: (HfuSpPlayer players at: anOrder playerID))."
	
	(anOrder fieldID = -1)
		ifTrue: [
			(((anOrder number = 6) 
				and: (anOrder hasFigures)) 
					and: (((self isOwnPlayer: anOrder offset onField: (self getStartfieldWithOffset: anOrder offset))) = false))
						ifTrue: [
							^true
							]
		].
	(anOrder fieldID between: 1 and: 40)    
		ifTrue: [
			|nextField over|
			nextField := (anOrder fieldID) + (anOrder number).
			nextField > 40
				ifTrue: [nextField := nextField - 40].
			over :=(self isField: (anOrder fieldID) overLastField: nextField withOffset: (anOrder offset)).
			over = 0
				ifFalse: [(self lastFields at:(over+(anOrder offset*4)))
								ifFalse: [^true]
				].
			(self isOwnPlayer: (anOrder offset) onField: nextField)
				ifFalse: [^true].
			].
	^false
	
		
]

{ #category : 'Accessing' }
HfuSpManDontGetAngryBoardState >> lastFields [

	^lastFields
]

{ #category : 'Accessing' }
HfuSpManDontGetAngryBoardState >> lastFields: anObject [

	lastFields := anObject
]

{ #category : 'Not categorized' }
HfuSpManDontGetAngryBoardState >> putNewFigureOnBoard: aOffset [

	^self setPlayerat: aOffset*10+1 withcolor: aOffset.
	
]

{ #category : 'Not categorized' }
HfuSpManDontGetAngryBoardState >> removePlayerFromField: aField [
	
	self board at: aField put: 0.
	
]

{ #category : 'Accessing' }
HfuSpManDontGetAngryBoardState >> setPlayerat: aField withcolor: aColor [

	|kickedPlayer|
	kickedPlayer := self board at:aField.
	self board at: aField put:aColor+1.
	kickedPlayer = 0
		ifTrue: [^0]
		ifFalse: [^kickedPlayer]
]
