Class {
	#name : 'HfuSpGames',
	#superclass : 'Application',
	#category : 'HfuSpGames'
}

{ #category : 'Tonel-Metadata' }
HfuSpGames class >> startUp [

	"Starts the server automatically"
	HfuSpLoginView startUp.
]
