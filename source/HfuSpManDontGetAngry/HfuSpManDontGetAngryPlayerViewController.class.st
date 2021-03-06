Class {
	#name : 'HfuSpManDontGetAngryPlayerViewController',
	#superclass : 'HfuSpPlayerViewController',
	#instVars : [
		'rolledNumber',
		'offset',
		'numberOfTimesRolled'
	],
	#category : 'HfuSpManDontGetAngry'
}

{ #category : 'Internal' }
HfuSpManDontGetAngryPlayerViewController >> checkRolledDice: anOrder [

	"Goes through every possible field you can click and tests if there is anOrder that is valid.
	 Meaning that it checks if the player can make a move.
	 If not returns false"
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

{ #category : 'Initialization' }
HfuSpManDontGetAngryPlayerViewController >> createPlayerView [

	"<^anPlayerView>"
	"returns the PlayerView managed by this PlayerViewController"
	|View|
	self rolledNumber: 0.
	self numberOfTimesRolled: 0.
	View:= HfuSpManDontGetAngryPlayerView new.
	View playerViewController: self.
	self playerView:  View.
	^self playerView
]

{ #category : 'Internal' }
HfuSpManDontGetAngryPlayerViewController >> displayCurrentBoardState [

	"tells view to display the Boardstate currently continaed in this PlayerViewController"
	self currentBoardState = nil
		ifTrue: [self currentBoardState: self turnStateController currentBoardState].
	self playerView setGame: (self currentBoardState)
]

{ #category : 'Accessing' }
HfuSpManDontGetAngryPlayerViewController >> numberOfTimesRolled [

	^numberOfTimesRolled
]

{ #category : 'Accessing' }
HfuSpManDontGetAngryPlayerViewController >> numberOfTimesRolled: anObject [

	numberOfTimesRolled := anObject
]

{ #category : 'Accessing' }
HfuSpManDontGetAngryPlayerViewController >> offset [

	^offset
]

{ #category : 'Accessing' }
HfuSpManDontGetAngryPlayerViewController >> offset: anObject [

	offset := anObject
]

{ #category : 'Accessing' }
HfuSpManDontGetAngryPlayerViewController >> rolledNumber [

	^rolledNumber
]

{ #category : 'Accessing' }
HfuSpManDontGetAngryPlayerViewController >> rolledNumber: anObject [

	rolledNumber := anObject
]

{ #category : 'Internal' }
HfuSpManDontGetAngryPlayerViewController >> transmitOrder: aField [

	"<^self>"
	"transmits a order from a view to the TurnStateController"
	|gameOrder|
	gameOrder := (HfuSpManDontGetAngryOrder new
								playerID: self player id;
								fieldID: aField;
								offset: self offset;
								hasFigures: ((self currentBoardState figureFields at: self offset + 1)>0);
								number: self rolledNumber;
								yourself).
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
			
	self turnStateController receiveGameOrder:  gameOrder.
]
