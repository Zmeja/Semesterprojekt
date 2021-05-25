Class {
	#name : 'HfuSpManDontGetAngryTurnStateController',
	#superclass : 'HfuSpTurnStateController',
	#category : 'HfuSpGames'
}

{ #category : 'Not categorized' }
HfuSpManDontGetAngryTurnStateController >> initializeBoardState [

	"creates the games Board"
	
	self playerViewControllers: Dictionary new.
	self currentBoardState:  HfuSpManDontGetAngryBoardState new.
	self currentBoardState initializeBoardState.
]
