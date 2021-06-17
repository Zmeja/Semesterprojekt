Class {
	#name : 'HfuSpManDontGetAngryTurnStateController',
	#superclass : 'HfuSpTurnStateController',
	#category : 'HfuSpManDontGetAngry'
}

{ #category : 'Not categorized' }
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
	 -1 correspondes to the figures that are out of field
	 1 to 40 are the fields that every player walks on
	 41 to 56 are the last fields of each player"
	|playerViewController kickedPlayer |
	playerViewController := (self playerViewControllers at: (HfuSpPlayer players at: anOrder playerID)).
	playerViewController rolledNumber: 0.
	(anOrder fieldID = -1)
		ifTrue: [
			(((anOrder number = 6) 
				and: (playerViewController figures size > 0)) 
					and: (((self currentBoardState isOwnPlayer: playerViewController offset onField: (self currentBoardState getStartfieldWithOffset: playerViewController offset))) = false))
						ifTrue: [
							playerViewController figures removeFirst.
							kickedPlayer := self currentBoardState putNewFigureOnBoard: playerViewController offset.
							kickedPlayer = 0
								ifFalse: [self kickFigure: kickedPlayer].
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
					kickedPlayer = 0
								ifFalse: [self kickFigure: kickedPlayer].
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

{ #category : 'Not categorized' }
HfuSpManDontGetAngryTurnStateController >> initializeBoardState [

	"<^self>"
	"creates the games Board as it is at game Start."
	
	self playerViewControllers: Dictionary new.
	self currentBoardState:  HfuSpManDontGetAngryBoardState new.
	self currentBoardState initializeBoardState.
]

{ #category : 'Not categorized' }
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
HfuSpManDontGetAngryTurnStateController >> kickFigure: aColorOfPlayer [

	"searches the controller with the given offset and adds a figure to his figures that are not on the board"
	self playerViewControllers do: [:eachController|
									(eachController offset - 1) = aColorOfPlayer
										ifTrue: [eachController figures add: 1]].
	
	
]

{ #category : 'Not categorized' }
HfuSpManDontGetAngryTurnStateController >> startGame [

	"^self"
	"sets the game as active"
	self gameOngoing: 0
]
