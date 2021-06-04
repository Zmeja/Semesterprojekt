Class {
	#name : 'HfuSpGameSessionLobbyRepresentationView',
	#superclass : 'Me5BaseView',
	#instVars : [
		'gameType',
		'textField',
		'form',
		'selectBox',
		'gameView',
		'button',
		'playerViewController',
		'sessionHolder'
	],
	#category : 'HfuSpGames'
}

{ #category : 'Accessing' }
HfuSpGameSessionLobbyRepresentationView >> button [

	^button
]

{ #category : 'Accessing' }
HfuSpGameSessionLobbyRepresentationView >> button: anObject [

	button := anObject
]

{ #category : 'Not categorized' }
HfuSpGameSessionLobbyRepresentationView >> closeThisGameClicked [
	self replaceView
]

{ #category : 'Not categorized' }
HfuSpGameSessionLobbyRepresentationView >> createComponents [

	self addChild: self form.
]

{ #category : 'Not categorized' }
HfuSpGameSessionLobbyRepresentationView >> createGameClicked [
	|createdGameSession|
	createdGameSession := self parentView addGameButtonClicked: self form.
	self parentView addPlayerButtonClicked: createdGameSession.
]

{ #category : 'Not categorized' }
HfuSpGameSessionLobbyRepresentationView >> createGameForm [

	self form: Me5FormPortlet new.
	self selectBox: (Me5SelectBox new addObjects: #('TicTacToe' 'Man Dont Get Angry' 'Connect Four'); yourself).
	self textField: (Me5TextField new text: 'Name';helpText:'Enter a name for your Session'; yourself).
	self button: Me5Button newPrimary.
	self button text:'Create Game'.
	self button addClickEventSelector: #createGameClicked.
	self form addChildToBody: self selectBox.
	self form addChildToBody: self textField.
	self form addChildToBody: self button.
]

{ #category : 'Not categorized' }
HfuSpGameSessionLobbyRepresentationView >> createSessionForm: aGameID [

	|gameSession|
	gameSession := HfuSpGameSessionsManager getGameSessionById: aGameID.
	self gameType: gameSession type.
	self form: Me5FormPortlet new.
	self form text: ('ID: ', (aGameID asString), String cr, 'Name: ', gameSession name, String cr, 'Players: ', ((gameSession playerViewControllers size) asString)).
	self button: Me5Button newPrimary.
	self button text:'Join Game'.
	self button name: aGameID asString.
	self button addClickEventSelector: #joinGameClicked:.
	self gameType: gameSession type.
	self form addChildToBody: self button.
]

{ #category : 'Accessing' }
HfuSpGameSessionLobbyRepresentationView >> form [

	^form
]

{ #category : 'Accessing' }
HfuSpGameSessionLobbyRepresentationView >> form: anObject [

	form := anObject
]

{ #category : 'Accessing' }
HfuSpGameSessionLobbyRepresentationView >> gameType [

	^gameType
]

{ #category : 'Accessing' }
HfuSpGameSessionLobbyRepresentationView >> gameType: anObject [

	gameType := anObject
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
HfuSpGameSessionLobbyRepresentationView >> joinGameClicked: anEvent [

	self parentView addPlayerButtonClicked: (anEvent component name) asInteger.
]

{ #category : 'Accessing' }
HfuSpGameSessionLobbyRepresentationView >> playerViewController [

	"<^iOf aPlayerViewController>"
	"Answer the playerViewController of the receiver"

	^playerViewController
]

{ #category : 'Accessing' }
HfuSpGameSessionLobbyRepresentationView >> playerViewController: anaPlayerViewController [

	"<anaPlayerViewController: iOf aPlayerViewController, ^self>"
	"Set the playerViewController of the receiver"

	playerViewController := anaPlayerViewController
]

{ #category : 'Accessing' }
HfuSpGameSessionLobbyRepresentationView >> selectBox [

	^selectBox
]

{ #category : 'Accessing' }
HfuSpGameSessionLobbyRepresentationView >> selectBox: anObject [

	selectBox := anObject
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

{ #category : 'Accessing' }
HfuSpGameSessionLobbyRepresentationView >> textField [

	^textField
]

{ #category : 'Accessing' }
HfuSpGameSessionLobbyRepresentationView >> textField: anObject [

	textField := anObject
]
