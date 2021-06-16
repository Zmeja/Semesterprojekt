Class {
	#name : 'HfuSpManDontGetAngryPlayerViewController',
	#superclass : 'HfuSpPlayerViewController',
	#instVars : [
		'rolledNumber',
		'figures',
		'offset',
		'numberOfTimesRolled'
	],
	#category : 'HfuSpManDontGetAngry'
}

{ #category : 'Not categorized' }
HfuSpManDontGetAngryPlayerViewController >> checkRolledDice: anOrder [

	anOrder fieldID: -1.
	(self currentBoardState isValidOrder: anOrder)
		ifTrue:[^true].
	1 to: 56 do: [:eachField|
		anOrder fieldID: eachField.
		(self currentBoardState isValidOrder: anOrder)
			ifTrue: [^true].
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
	self numberOfTimesRolled: 0.
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
	"gameSession := (HfuSpGameSessionsManager testaddPlayer: self ToSession: aIdOfGame).
	self turnStateController: gameSession."
	self offset: gameSession playerViewControllers size - 1.
]

{ #category : 'Not categorized' }
HfuSpManDontGetAngryPlayerViewController >> numberOfTimesRolled [

	^numberOfTimesRolled
]

{ #category : 'Not categorized' }
HfuSpManDontGetAngryPlayerViewController >> numberOfTimesRolled: anObject [

	numberOfTimesRolled := anObject
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
	"transmits a order from a view to the TurnStateController"
	|gameOrder|
	gameOrder := HfuSpManDontGetAngryOrder new.
	gameOrder playerID: self player id.
	gameOrder fieldID: aField.
	gameOrder offset: self offset.
	gameOrder number: self rolledNumber.
	gameOrder hasFigures: (self figures size > 0).
	self turnStateController gameOngoing = -1
		ifTrue: [self playerView showInfoNotificationWithMessage: 'Game has not started yet'.^nil].
	self isActingPlayer 
		ifFalse:[self playerView showInfoNotificationWithMessage: 'It is not your turn'. ^nil].
	(((gameOrder fieldID = 0) not) and: (self rolledNumber = 0))
		ifTrue:[self playerView showInfoNotificationWithMessage: 'Please Roll'. ^nil].
	((gameOrder fieldID = 0) and: (self rolledNumber = 0))
		ifTrue: [
			self rolledNumber: (EsRandom new nextInt: 6).
			gameOrder number: self rolledNumber.
			self numberOfTimesRolled: (self numberOfTimesRolled +1).
			(self checkRolledDice: gameOrder)
				ifTrue:[
					self playerView showInfoNotificationWithMessage: 'You rolled a ' , self rolledNumber asString.
					self numberOfTimesRolled: 0.
					^nil]
				ifFalse: [
					self playerView showInfoNotificationWithMessage: 'You rolled a ' , self rolledNumber asString, '. But cannot make a Step'. 
					self numberOfTimesRolled = 3
						ifTrue: [
							self turnStateController currentBoardState makeTurnOrderStep.
							self numberOfTimesRolled: 0].
					self turnStateController updateGameStateOfAllPlayers.
					self rolledNumber: 0.^nil].
			].
	self turnStateController receiveGameOrder:  gameOrder
]
