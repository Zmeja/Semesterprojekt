Class {
	#name : 'HfuSpManDontGetAngryPlayerViewController',
	#superclass : 'HfuSpPlayerViewController',
	#instVars : [
		'rolledNumber',
		'figures',
		'offset'
	],
	#category : 'HfuSpManDontGetAngry'
}

{ #category : 'Not categorized' }
HfuSpManDontGetAngryPlayerViewController >> checkRolledDice [

	(self rolledNumber between: 1 and: 6)
		ifFalse: [^false].
	(((self rolledNumber = 6) 
		and: (self figures size > 0)) 
			and: ((self currentBoardState isOwnPlayer: (self offset) onField: (self currentBoardState getStartfieldWithOffset: self offset))) = false)
			ifTrue: [^true].
	1 to: 40 do: [:eachField|
		|nextField over|
		(eachField + self rolledNumber)>40
				ifTrue: [nextField :=(eachField+ self rolledNumber) - 40]
				ifFalse: [nextField := (eachField + self rolledNumber)].
		(self currentBoardState isOwnPlayer: (self offset) onField: eachField)
			ifTrue: [
			over :=(self currentBoardState isField: eachField overLastField: nextField withOffset: (self offset)).
			over = 0
				ifFalse: [(self currentBoardState lastFields at:(over+(self offset*4)))
								ifFalse: [^true]
				].
			(self currentBoardState isOwnPlayer: (self offset) onField: nextField)
				ifFalse: [^true]
			].
		].
	^false

]

{ #category : 'Not categorized' }
HfuSpManDontGetAngryPlayerViewController >> createPlayerView [

	"<^anPlayerView>"
	"returns the PlayerView managed by this PlayerViewController"
	|View|
	self figures: #(true true true true) asOrderedCollection.
	self rolledNumber: 0.
	View:= HfuSpManDontGetAngryPlayerView new.
	View playerViewController: self.
	self playerView:  View.
	^self playerView
]

{ #category : 'Not categorized' }
HfuSpManDontGetAngryPlayerViewController >> displayCurrentBoardState [

	"tells view to display the Boardstate currently continaed in this PlayerViewController"
	self currentBoardState = nil
		ifTrue: [self currentBoardState: self turnStateController currentBoardState].
	"self playerView removeChild: self playerView boardPortlet.
	self playerView removeChild: self playerView boardRows."
	self playerView setGame: (self currentBoardState)
]

{ #category : 'Not categorized' }
HfuSpManDontGetAngryPlayerViewController >> figures [

	^figures
]

{ #category : 'Not categorized' }
HfuSpManDontGetAngryPlayerViewController >> figures: anObject [

	figures := anObject
]

{ #category : 'Not categorized' }
HfuSpManDontGetAngryPlayerViewController >> join: aIdOfGame [
	
	|gameSession|
	gameSession := (HfuSpGameSessionsManager testaddPlayer: self ToSession: aIdOfGame).
	self turnStateController: gameSession.
	self offset: gameSession playerViewControllers size - 1.
]

{ #category : 'Not categorized' }
HfuSpManDontGetAngryPlayerViewController >> offset [

	^offset
]

{ #category : 'Not categorized' }
HfuSpManDontGetAngryPlayerViewController >> offset: anObject [

	offset := anObject
]

{ #category : 'Not categorized' }
HfuSpManDontGetAngryPlayerViewController >> rolledNumber [

	^rolledNumber
]

{ #category : 'Not categorized' }
HfuSpManDontGetAngryPlayerViewController >> rolledNumber: anObject [

	rolledNumber := anObject
]

{ #category : 'Not categorized' }
HfuSpManDontGetAngryPlayerViewController >> transmitOrder: aField [

	"<^self>"
	"Answer the receiver"
	|gameOrder|
	gameOrder := HfuSpManDontGetAngryOrder new.
	gameOrder playerID: self player id.
	gameOrder fieldID: aField.
	gameOrder offset: self offset.
	gameOrder number: self rolledNumber.
	gameOrder hasFigures: (self figures size > 0).
	self turnStateController gameOngoing = -1
		ifTrue: [self playerView showInfoNotificationWithMessage: 'Game has not started yet'.^nil].
	self isActingPlayer = true 
		ifFalse:[self playerView showInfoNotificationWithMessage: 'It is not your turn'. ^nil].
	(((gameOrder fieldID = 0) not) and: (self rolledNumber = 0))
		ifTrue:[self playerView showInfoNotificationWithMessage: 'Please Roll'. ^nil].
	((gameOrder fieldID = 0) and: (self rolledNumber = 0))
		ifTrue: [
			self rolledNumber: (EsRandom new nextInt: 6).
			self checkRolledDice
				ifTrue:[self playerView showInfoNotificationWithMessage: 'You rolled a ' , self rolledNumber asString.^nil]
				ifFalse: [self playerView showInfoNotificationWithMessage: 'You rolled a ' , self rolledNumber asString, '. But cannot make a Step'. 
							self turnStateController currentBoardState makeTurnOrderStep.
							self turnStateController updateGameStateOfAllPlayers.
							self rolledNumber: 0.^nil].
			].
	self turnStateController receiveGameOrder:  gameOrder
]
