Class {
	#name : 'HfuSpManDontGetAngryBoardState',
	#superclass : 'HfuSpBoardState',
	#instVars : [
		'board',
		'lastFields',
		'yellowOffset',
		'blueOffset',
		'redOffset'
	],
	#category : 'HfuSpGames'
}

{ #category : 'Accessing' }
HfuSpManDontGetAngryBoardState >> blueOffset [

	^blueOffset
]

{ #category : 'Accessing' }
HfuSpManDontGetAngryBoardState >> blueOffset: anObject [

	blueOffset := anObject
]

{ #category : 'Accessing' }
HfuSpManDontGetAngryBoardState >> board [

	^board
]

{ #category : 'Accessing' }
HfuSpManDontGetAngryBoardState >> board: anObject [

	board := anObject
]

{ #category : 'Not categorized' }
HfuSpManDontGetAngryBoardState >> initializeBoardState [

	"<^self>"
	"Creates the boardstate of  a unstarted game"
	self board: OrderedCollection new.
	1 to: 40 do: [:aField| self board add: 0].
	
	self lastFields: OrderedCollection new.
	1 to: 16 do:[:aField|self lastFields add: 0].
	
	self yellowOffset: 10.
	self blueOffset: 20.
	self redOffset: 30.
	
]

{ #category : 'Accessing' }
HfuSpManDontGetAngryBoardState >> lastFields [

	^lastFields
]

{ #category : 'Accessing' }
HfuSpManDontGetAngryBoardState >> lastFields: anObject [

	lastFields := anObject
]

{ #category : 'Accessing' }
HfuSpManDontGetAngryBoardState >> redOffset [

	^redOffset
]

{ #category : 'Accessing' }
HfuSpManDontGetAngryBoardState >> redOffset: anObject [

	redOffset := anObject
]

{ #category : 'Accessing' }
HfuSpManDontGetAngryBoardState >> yellowOffset [

	^yellowOffset
]

{ #category : 'Accessing' }
HfuSpManDontGetAngryBoardState >> yellowOffset: anObject [

	yellowOffset := anObject
]
