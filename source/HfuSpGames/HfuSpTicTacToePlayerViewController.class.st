Class {
	#name : 'HfuSpTicTacToePlayerViewController',
	#superclass : 'HfuSpPlayerViewController',
	#instVars : [
		'globalView'
	],
	#category : 'HfuSpGames'
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
