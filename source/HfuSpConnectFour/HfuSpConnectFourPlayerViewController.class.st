Class {
	#name : 'HfuSpConnectFourPlayerViewController',
	#superclass : 'HfuSpPlayerViewController',
	#category : 'HfuSpConnectFour'
}

{ #category : 'Not categorized' }
HfuSpConnectFourPlayerViewController >> createPlayerView [

	"<^anPlayerView>"
	"returns the PlayerView managed by this PlayerViewController"
	|View|
	View:= HfuSpConnectFourPlayerView new.
	View playerViewController: self.
	self playerView:  View.
	^self playerView
]
