Class {
	#name : 'HfuSpPlayer',
	#superclass : 'Object',
	#instVars : [
		'playerName',
		'id',
		'color'
	],
	#classInstVars : [
		'players'
	],
	#category : 'HfuSpGames'
}

{ #category : 'Not categorized' }
HfuSpPlayer class >> addPlayerIfAbsent: ID [

	self players at: ID ifAbsentPut: [HfuSpPlayer new id:ID; yourself].
	
	^self players at: ID.
	
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
	players := Dictionary new.
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
