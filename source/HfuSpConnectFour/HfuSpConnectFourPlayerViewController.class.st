Class {
	#name : 'HfuSpConnectFourPlayerViewController',
	#superclass : 'HfuSpPlayerViewController',
	#category : 'HfuSpConnectFour'
}

{ #category : 'Internal' }
HfuSpConnectFourPlayerViewController >> createPlayerView [

	"<^anPlayerView>"
	"returns the PlayerView managed by this PlayerViewController"
	|View|
	View := HfuSpConnectFourPlayerView new.
	View playerViewController: self.
	self playerView: View.
	^self playerView
]

{ #category : 'API' }
HfuSpConnectFourPlayerViewController >> transmitOrder: aField [

	"<^self>"
	"transmits a order from a view to the TurnStateController"

	|gameOrder|
	gameOrder := HfuSpConnectFourOrder new.
	gameOrder playerID: self player id.
	gameOrder columnId: aField.

	^self turnStateController receiveGameOrder: gameOrder
]
