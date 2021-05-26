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
	self player: (HfuSpPlayer makePlayer: 'Player').
	View:= HfuSpTicTacToePlayerView new.
	View playerViewController: self.
	self playerView:  View.
	^self playerView
]
