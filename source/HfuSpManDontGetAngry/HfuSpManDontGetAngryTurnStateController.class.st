Class {
	#name : 'HfuSpManDontGetAngryTurnStateController',
	#superclass : 'HfuSpTurnStateController',
	#category : 'HfuSpManDontGetAngry'
}

{ #category : 'Not categorized' }
HfuSpManDontGetAngryTurnStateController >> addFigure: aColorOfPlayer [

	"Searches the controller with the given offset and adds a figure to his figures that are not on the board"
	self playerViewControllers do: [:eachController|
		(eachController offset ) = aColorOfPlayer
			ifTrue: [
				eachController figures remove: false.
				eachController figures add: true.
			]
	].
	
	
]

{ #category : 'Initialization' }
HfuSpManDontGetAngryTurnStateController >> createPlayerViewController [

	"creates ManDontGetAngryPlayerViewController and returns it"
	
	|controller|
	controller :=HfuSpManDontGetAngryPlayerViewController new.
	controller offset: (self playerViewControllers) size.
	^controller
]

{ #category : 'Not categorized' }
HfuSpManDontGetAngryTurnStateController >> executeOrder: anOrder [
	"executes an Order.
	 -1 correspondes to the figures that are outside of the board
	 1 to 40 are the fields that every player walks on
	 41 to 56 are the last fields of each player (4*4=16, accessible through the offset"
	|playerViewController kickedPlayer |
	playerViewController := (self playerViewControllers at: (HfuSpPlayer players at: anOrder playerID)).
	playerViewController rolledNumber: 0.
	(anOrder fieldID = -1)
		ifTrue: [
			(((anOrder number = 6) 
				and: (anOrder hasFigures)) 
					and: (((self currentBoardState isOwnPlayer: playerViewController offset onField: (self currentBoardState getStartfieldWithOffset: playerViewController offset))) = false))
						ifTrue: [
							self removeFigure: playerViewController offset.
							kickedPlayer := self currentBoardState putNewFigureOnBoard: playerViewController offset.
							kickedPlayer = -1
								ifFalse: [self addFigure: kickedPlayer].
							].
			^true.
		].
	(anOrder fieldID between: 1 and: 40)	
		ifTrue: [
			|nextField over|
			nextField := (anOrder fieldID) + (anOrder number).
			nextField > 40
				ifTrue: [nextField := nextField - 40].
			over :=(self currentBoardState isField: (anOrder fieldID) overLastField: nextField withOffset: (playerViewController offset)).
			over = 0
				ifFalse: [(self currentBoardState lastFields at:(over+(playerViewController offset*4)))
								ifFalse: [self currentBoardState lastFields at:(over +(playerViewController offset*4)) put:true.
											self currentBoardState removePlayerFromField: anOrder fieldID. ^true]
				].
			(self currentBoardState isOwnPlayer: (playerViewController offset) onField: nextField)
				ifFalse: [
					kickedPlayer := self currentBoardState setPlayerat: nextField withcolor: playerViewController offset.
					self currentBoardState removePlayerFromField: anOrder fieldID.
					kickedPlayer = -1
								ifFalse: [self addFigure: kickedPlayer].
							].
			].
		(anOrder fieldID between: 41 and: 56)
			ifTrue: [
				|nextField|
				nextField:= (anOrder fieldID) + (anOrder number).
				self currentBoardState lastFields at: nextField-40 put: true.
				self currentBoardState lastFields at: (anOrder fieldID - 40) put: false.
			]
	
	
	
]

{ #category : 'Initialization' }
HfuSpManDontGetAngryTurnStateController >> initializeBoardState [

	"<^self>"
	"creates the games Board as it is at game Start."
	
	self playerViewControllers: Dictionary new.
	self currentBoardState:  HfuSpManDontGetAngryBoardState new.
	self currentBoardState initializeBoardState.
]

{ #category : 'Initialization' }
HfuSpManDontGetAngryTurnStateController >> initializeState [

	"<^self>"
	"initializes object state"
	self playerViewControllers: Dictionary new.
	self initializeBoardState.
	self gameOngoing: -1.
]

{ #category : 'Not categorized' }
HfuSpManDontGetAngryTurnStateController >> isGameAtPlayerCapacity [

	"<^(true|false)>"
	"returns wether more players may join the game"

	^self playerViewControllers size >=4
]

{ #category : 'Not categorized' }
HfuSpManDontGetAngryTurnStateController >> removeFigure: aColorOfPlayer [

	"Searches the controller with the given offset and removes a figure to his figures that are not on the board"
	self playerViewControllers do: [:eachController|
		(eachController offset) = aColorOfPlayer
			ifTrue: [
				eachController figures remove: true.
				eachController figures add: false.
			]
	].
	
	
]
