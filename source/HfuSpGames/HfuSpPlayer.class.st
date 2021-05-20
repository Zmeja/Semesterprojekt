Class {
	#name : 'HfuSpPlayer',
	#superclass : 'Object',
	#instVars : [
		'playerName',
		'id',
		'color'
	],
	#classInstVars : [
		'players',
		'nextID'
	],
	#category : 'HfuSpGames'
}

{ #category : 'Not categorized' }
HfuSpPlayer class >> makePlayer: aName [

	|tempPlayer|
	tempPlayer := HfuSpPlayer new.
	tempPlayer id: nextID.
	nextID := nextID+1.
	^tempPlayer
]

{ #category : 'Not categorized' }
HfuSpPlayer class >> makePlayer: aName withId: aInteger [

	|tempPlayer|
	tempPlayer := HfuSpPlayer new.
	tempPlayer id: aInteger.
	^tempPlayer
]

{ #category : 'Not categorized' }
HfuSpPlayer class >> nextID [
	
	nextID:= nextID+1.
	^nextID
]

{ #category : 'Not categorized' }
HfuSpPlayer class >> players [

	^players
]

{ #category : 'Not categorized' }
HfuSpPlayer class >> players: aListOfPlayers [
	players := aListOfPlayers
]

{ #category : 'Not categorized' }
HfuSpPlayer class >> startUp [
	nextID := 0.
	players := Collection new.
]

{ #category : 'Accessing' }
HfuSpPlayer >> color [
	^color
]

{ #category : 'Accessing' }
HfuSpPlayer >> color: aColor [

	color := aColor
]

{ #category : 'Accessing' }
HfuSpPlayer >> id [

	^id
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
HfuSpPlayer >> id: anObject [

	id := anObject
]

{ #category : 'Accessing' }
HfuSpPlayer >> playerName [

	^playerName
	
]

{ #category : 'Accessing' }
HfuSpPlayer >> playerName: aName [

	playerName := aName
	
]
