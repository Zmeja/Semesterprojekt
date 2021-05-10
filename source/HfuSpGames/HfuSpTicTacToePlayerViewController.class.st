Class {
	#name : 'HfuSpTicTacToePlayerViewController',
	#superclass : 'HfuSpPlayerViewController',
	#instVars : [
		'globalView'
	],
	#category : 'HfuSpGames'
}

{ #category : 'Not categorized' }
HfuSpTicTacToePlayerViewController >> addGlobalView: globalViewToAdd [
	globalView := globalViewToAdd
]

{ #category : 'Not categorized' }
HfuSpTicTacToePlayerViewController >> announceVictor: aPlayerID [
	globalView announceVictor: aPlayerID.
]

{ #category : 'Not categorized' }
HfuSpTicTacToePlayerViewController >> globalView: globalViewToSet [
	globalView := globalViewToSet
]

{ #category : 'Not categorized' }
HfuSpTicTacToePlayerViewController >> resetViewBoardState [
	globalView setGame: (self currentBoardState copy)
]
