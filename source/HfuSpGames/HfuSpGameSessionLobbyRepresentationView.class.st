Class {
	#name : 'HfuSpGameSessionLobbyRepresentationView',
	#superclass : 'Me5BaseView',
	#instVars : [
		'gameID',
		'gameType',
		'gameView',
		'tempButton',
		'playerViewController',
		'sessionHolder'
	],
	#category : 'HfuSpGames'
}

{ #category : 'Not categorized' }
HfuSpGameSessionLobbyRepresentationView >> addTicTacToeButtonClicked [
	|createdGameSession|
	createdGameSession := HfuSpGameSessionsManager createGameSession: 'TicTacToe'.
	
	tempButton := Me5Button newAirSecondary.
	tempButton text: ('Join TicTacToe ', (createdGameSession asString)).
	tempButton name: createdGameSession asString.
	tempButton addClickEventSelector: #addPlayerButtonClicked:.
	self sessionHolder addChildToBody:tempButton.
]

{ #category : 'Not categorized' }
HfuSpGameSessionLobbyRepresentationView >> addTicTacToeButtonClicked: anPlayerAddEvent [
	|aGameView|
	aGameView := (HfuSpTicTacToePlayerViewController new createPlayerView).
	aGameView playerViewController player: self playerViewController player.
	aGameView playerViewController playerView: aGameView.
	aGameView playerViewController join: anPlayerAddEvent component name asInteger.
	self replaceView: aGameView.
]

{ #category : 'Not categorized' }
HfuSpGameSessionLobbyRepresentationView >> closeThisGameClicked [
	self replaceView
]

{ #category : 'Not categorized' }
HfuSpGameSessionLobbyRepresentationView >> createComponents [

self
	addChild:(Me5Portlet new	
		title: 'gameID: ',  gameID;
		addChildToBody: (Me5Section new
			title: 'gameType: ',   gameType;	
			
			addChild:(Me5Button newAirSecondary
			text: 'Join This Game';
			addClickEventSelector: #closeThisGameClicked;
			yourself);	
			
			addChild:(Me5Button newAirSecondary
			text: 'Close This Game';
			addClickEventSelector: #closeThisGameClicked;
			yourself);

			yourself);
		yourself);
	yourself
]

{ #category : 'Accessing' }
HfuSpGameSessionLobbyRepresentationView >> gameID [

	"<^iOf Integer>"
	"Answer the gameID of the receiver"

	^gameID
]

{ #category : 'Accessing' }
HfuSpGameSessionLobbyRepresentationView >> gameID: anInteger [

	"<anInteger: iOf Integer, ^self>"
	"Set the gameID of the receiver"

	gameID := anInteger
]

{ #category : 'Accessing' }
HfuSpGameSessionLobbyRepresentationView >> gameType [

	"<^iOf String>"
	"Answer the gameType of the receiver"

	^gameType
]

{ #category : 'Accessing' }
HfuSpGameSessionLobbyRepresentationView >> gameType: aString [

	"<aString: iOf String, ^self>"
	"Set the gameType of the receiver"

	gameType := aString
]

{ #category : 'Accessing' }
HfuSpGameSessionLobbyRepresentationView >> gameView [

	"<^iOf View>"
	"Answer the gameView of the receiver"

	^gameView
]

{ #category : 'Accessing' }
HfuSpGameSessionLobbyRepresentationView >> gameView: aView [

	"<aView: iOf View, ^self>"
	"Set the gameView of the receiver"

	gameView := aView
]

{ #category : 'Not categorized' }
HfuSpGameSessionLobbyRepresentationView >> playerViewController [

	"<^iOf aPlayerViewController>"
	"Answer the playerViewController of the receiver"

	^playerViewController
]

{ #category : 'Not categorized' }
HfuSpGameSessionLobbyRepresentationView >> playerViewController: anaPlayerViewController [

	"<anaPlayerViewController: iOf aPlayerViewController, ^self>"
	"Set the playerViewController of the receiver"

	playerViewController := anaPlayerViewController
]

{ #category : 'Not categorized' }
HfuSpGameSessionLobbyRepresentationView >> sessionHolder [

	^sessionHolder
]

{ #category : 'Accessing' }
HfuSpGameSessionLobbyRepresentationView >> sessionHolder: anObject [

	sessionHolder := anObject
]

{ #category : 'Not categorized' }
HfuSpGameSessionLobbyRepresentationView >> startUp [
	
	| theHttpServer |
	theHttpServer := (Me5SstHttpServer startUpHttpServerOnPort: '9099' serverApplicationClass: HfuSpGameSessionLobbyRepresentationView).
	theHttpServer addViewClass: HfuSpGameSessionLobbyRepresentationView;
	yourself
]
