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

{ #category : 'Not categorized' }
HfuSpConnectFourPlayerViewController >> transmitOrder: aField [

	"<^self>"
	"creates and sends Order"
	|gameOrder|
	gameOrder := HfuSpConnectFourOrder new.
	gameOrder playerID: self player id.
	gameOrder columnId: aField.

	^self turnStateController receiveGameOrder:  gameOrder
]
