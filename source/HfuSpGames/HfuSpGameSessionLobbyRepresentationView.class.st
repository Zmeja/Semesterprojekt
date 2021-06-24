Class {
	#name : 'HfuSpGameSessionLobbyRepresentationView',
	#superclass : 'Me5BaseView',
	#instVars : [
		'textField',
		'createGameForm',
		'sessionForm',
		'selectBox',
		'button',
		'removeButton',
		'sessionHolder'
	],
	#category : 'HfuSpGames'
}

{ #category : 'Internal' }
HfuSpGameSessionLobbyRepresentationView >> buildGameForm [

	self createGameForm: Me5FormPortlet new.
	self createGameForm addChildToBody: (Me5SelectBox new 
																		addObjects: #('TicTacToe' 'Man Dont Get Angry' 'Connect Four'); 
																		yourself).
	self createGameForm addChildToBody: (Me5TextField new 
																		text: 'Name';
																		helpText:'Enter a name for your Session';
																		yourself).
	self createGameForm addChildToBody:  (Me5Button newPrimary
																		text:'Create Game';
																		addClickEventSelector: #createGameClicked;
																		yourself).
	self createGameForm hide.
]

{ #category : 'Internal' }
HfuSpGameSessionLobbyRepresentationView >> buildSessionForm: aGameID [

	|gameSession |
	aGameID = -1
		ifFalse:[
					gameSession := HfuSpGameSessionsManager getGameSessionById: aGameID.
					self sessionForm text: ('ID: ', (aGameID asString), String cr, 'Name: ', gameSession name, String cr, 'Players: ', ((gameSession playerViewControllers size) asString)).
					self button name: aGameID asString.
					self removeButton name:  aGameID asString.]
		ifTrue: [	
						self sessionForm: Me5FormPortlet new.
						self button: (Me5Button newPrimary
												text:'Join Game';
												addClickEventSelector: #joinGameClicked:;
												yourself).
						self removeButton: (Me5Button newPrimary
															text:'Remove Game';
															addClickEventSelector: #removeGameClicked:;
															yourself).
						self sessionForm addChildToBody: self button.
						self sessionForm addChildToBody: self removeButton.
						self sessionForm hide.].
	
]

{ #category : 'Accessing' }
HfuSpGameSessionLobbyRepresentationView >> button [

	^button
]

{ #category : 'Accessing' }
HfuSpGameSessionLobbyRepresentationView >> button: anObject [

	button := anObject
]

{ #category : 'Initialization' }
HfuSpGameSessionLobbyRepresentationView >> createComponents [

	self addChild: self createGameForm.
	self addChild: self sessionForm.
]

{ #category : 'Internal' }
HfuSpGameSessionLobbyRepresentationView >> createGameClicked [
	|createdGameSession|
	createdGameSession := self parentView addGameButtonClicked: self createGameForm.
	self parentView addPlayerButtonClicked: createdGameSession.
]

{ #category : 'Accessing' }
HfuSpGameSessionLobbyRepresentationView >> createGameForm [

	^createGameForm
]

{ #category : 'Accessing' }
HfuSpGameSessionLobbyRepresentationView >> createGameForm: anObject [

	createGameForm := anObject
]

{ #category : 'Internal' }
HfuSpGameSessionLobbyRepresentationView >> joinGameClicked: anEvent [

	self parentView addPlayerButtonClicked: (anEvent component name) asInteger.
]

{ #category : 'Accessing' }
HfuSpGameSessionLobbyRepresentationView >> removeButton [

	^removeButton
]

{ #category : 'Accessing' }
HfuSpGameSessionLobbyRepresentationView >> removeButton: anObject [

	removeButton := anObject
]

{ #category : 'Internal' }
HfuSpGameSessionLobbyRepresentationView >> removeGameClicked: anEvent [

	self parentView removePlayerButtonClicked: (anEvent component name) asInteger.
	self sessionForm hide.
]

{ #category : 'Accessing' }
HfuSpGameSessionLobbyRepresentationView >> selectBox [

	^selectBox
]

{ #category : 'Accessing' }
HfuSpGameSessionLobbyRepresentationView >> selectBox: anObject [

	selectBox := anObject
]

{ #category : 'Accessing' }
HfuSpGameSessionLobbyRepresentationView >> sessionForm [

	^sessionForm
]

{ #category : 'Accessing' }
HfuSpGameSessionLobbyRepresentationView >> sessionForm: anObject [

	sessionForm := anObject
]

{ #category : 'Accessing' }
HfuSpGameSessionLobbyRepresentationView >> sessionHolder [

	^sessionHolder
]

{ #category : 'Accessing' }
HfuSpGameSessionLobbyRepresentationView >> sessionHolder: anObject [

	sessionHolder := anObject
]

{ #category : 'Accessing' }
HfuSpGameSessionLobbyRepresentationView >> textField [

	^textField
]

{ #category : 'Accessing' }
HfuSpGameSessionLobbyRepresentationView >> textField: anObject [

	textField := anObject
]
