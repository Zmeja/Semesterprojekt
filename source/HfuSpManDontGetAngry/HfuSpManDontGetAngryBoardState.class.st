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
		ifTrue:[^'Blue'].
	((self lastFields copyFrom: 5 to: 8) = #( true true true true) asOrderedCollection)
		ifTrue:[^'Red'].
	((self lastFields copyFrom: 9 to: 12) = #( true true true true) asOrderedCollection)
		ifTrue:[^'Green'].
	((self lastFields copyFrom: 13 to: 16) = #( true true true true) asOrderedCollection)
		ifTrue:[^'Yellow'].
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
		ifTrue: [
			nextField:= nextField + 40. 
			lastField:= lastField+ 40].
	(lastField between: currentField and: nextField)
		ifTrue:[^nextField-lastField].
	^0
	
	


]

{ #category : 'Not categorized' }
HfuSpManDontGetAngryBoardState >> isGameDraw [

	"<^Boolean>"
	"Returnes wether the game is a draw (it is so if no player can make any moves that result in a victory)"

	^false 
]

{ #category : 'Accessing' }
HfuSpManDontGetAngryBoardState >> isOwnPlayer: aOffset onField: aField [

	|aLastField|
	aField > 40
		ifTrue: [
			aLastField := aField - 40.
			(aField between:41 and: 44)
				ifTrue:[^((self lastFields at:aLastField) and: (aOffset = 0))].
			(aField between:45 and: 48)
				ifTrue:[^((self lastFields at:aLastField) and: (aOffset = 1))].
			(aField between:49 and: 52)
				ifTrue:[^((self lastFields at:aLastField) and: (aOffset = 2))].
			(aField between:53 and: 56)
				ifTrue:[^((self lastFields at:aLastField) and: (aOffset = 3))].
		].
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
	
	(anOrder fieldID = false)
		ifTrue: [^false].
	(anOrder hasFigures)
		ifTrue: [
			(anOrder number = 6)
				ifTrue: [
					((anOrder fieldID = -1) and: ((self isOwnPlayer: anOrder offset onField: (self getStartfieldWithOffset: anOrder offset)) = false))
						ifTrue: [^true].
					((anOrder fieldID between:1 and:40) and: ((self isOwnPlayer: anOrder offset onField: (self getStartfieldWithOffset: anOrder offset)) = false))
						ifTrue:[^false].
				]
		].
	(anOrder fieldID between: 1 and: 40)    
		ifTrue: [
			|nextField overStartField|
			(self isOwnPlayer: (anOrder offset) onField: (anOrder fieldID))
				ifFalse: [^false].
			nextField := (anOrder fieldID) + (anOrder number).
			nextField > 40
				ifTrue: [nextField := nextField - 40].
			overStartField :=(self isField: (anOrder fieldID) overLastField: nextField withOffset: (anOrder offset)).
			overStartField>4
				ifTrue: [^false].
			overStartField = 0
				ifFalse: [(self lastFields at:(overStartField+(anOrder offset*4)))
								ifFalse: [^true]
				].
			(self isOwnPlayer: (anOrder offset) onField: nextField)
				ifFalse: [^true].
			].
	(anOrder fieldID between: 41 and: 56)
		ifTrue: [
			|nextField|
			(self isOwnPlayer: (anOrder offset) onField: (anOrder fieldID))
				ifFalse: [^false].
			nextField := (anOrder number + anOrder fieldID).
			(nextField between: 41 and: (((anOrder offset+1)*4+40)))
				ifTrue: [
					(self isOwnPlayer: anOrder offset onField: nextField)
						ifFalse: [^true].
				].
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
