Class {
	#name : 'HfuSpTicTacToePlayerViewController',
	#superclass : 'HfuSpPlayerViewController',
	#instVars : [
		'globalView'
	],
	#category : 'HfuSpTicTacToe'
}

{ #category : 'Not categorized' }
HfuSpTicTacToePlayerViewController >> createPlayerView [

	"<^anPlayerView>"
	"returns the PlayerView managed by this PlayerViewController"
	|View|
	View:= HfuSpTicTacToePlayerView new.
	View playerViewController: self.
	self playerView:  View.
	^self playerView
]

{ #category : 'Not categorized' }
HfuSpTicTacToePlayerViewController >> transmitOrder: aField [

	"<^self>"
	"Answer the receiver"
	|gameOrder|
	gameOrder := HfuSpTicTacToeOrder new.
	gameOrder playerID: self player id.
	gameOrder fieldID: aField.
	self isActingPlayer = true 
		ifFalse:[^nil].
	self turnStateController receiveGameOrder:  gameOrder
]
