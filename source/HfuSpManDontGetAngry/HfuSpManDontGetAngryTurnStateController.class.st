Class {
	#name : 'HfuSpManDontGetAngryTurnStateController',
	#superclass : 'HfuSpTurnStateController',
	#category : 'HfuSpManDontGetAngry'
}

{ #category : 'Not categorized' }
HfuSpManDontGetAngryTurnStateController >> createPlayerViewController [

	^HfuSpManDontGetAngryPlayerViewController new
]

{ #category : 'Not categorized' }
HfuSpManDontGetAngryTurnStateController >> executeOrder: anOrder [

	|playerViewController kickedPlayer |
	playerViewController := (self playerViewControllers at: (HfuSpPlayer players at: anOrder playerID)).
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
	(anOrder fieldID between: 1 and: 6)	
		ifTrue: [
			|nextField over|
			nextField := (anOrder fieldID) + (anOrder number).
			nextField > 40
				ifTrue: [nextField := nextField - 40].
			over :=(self currentBoardState isField: (anOrder fieldID) overLastField: nextField withOffset: (playerViewController offset)).
			over = 0
				ifFalse: [(self currentBoardState lastFields at:(over+(playerViewController offset*4)))
								ifFalse: [self currentBoardState lastFields at:(over +(playerViewController offset*4)) put:true]
				].
			(self currentBoardState isOwnPlayer: (playerViewController offset) onField: nextField)
				ifFalse: [
					kickedPlayer := self currentBoardState setPlayerat: nextField withcolor: playerViewController offset.
					kickedPlayer = 0
								ifFalse: [self kickFigure: kickedPlayer].
							].
			].
		
	self currentBoardState setPlayerat: anOrder fieldID withcolor: anOrder color.
	
	
	
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
HfuSpManDontGetAngryTurnStateController >> kickFigure: aColorOfPlayer [

	self playerViewControllers do: [:eachController|
									(eachController offset - 1) = aColorOfPlayer
										ifTrue: [eachController figures add: 1]].
	
	
]

{ #category : 'Not categorized' }
HfuSpManDontGetAngryTurnStateController >> startGame [

	"^self"
	"sets the game as active"
	self updateGameStateOfAllPlayers.
	self gameOngoing: 0
]
