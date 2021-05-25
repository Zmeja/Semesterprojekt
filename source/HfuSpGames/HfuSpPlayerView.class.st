Class {
	#name : 'HfuSpPlayerView',
	#superclass : 'Me5BaseView',
	#instVars : [
		'playerViewController',
		'addGameButton',
		'closeGamesButton',
		'sessionHolder'
	],
	#category : 'HfuSpGames'
}

{ #category : 'Not categorized' }
HfuSpPlayerView >> addGameButtonClicked [
	|tempButton createdGameSession|
	createdGameSession := HfuSpGameSessionsManager createGameSession: 'TicTacToe'.
	tempButton := Me5Button newAirSecondary.
	tempButton text: ('Join TicTacToe ', (createdGameSession asString)).
	tempButton name: createdGameSession asString.
	tempButton addClickEventSelector: #addPlayerButtonClicked:.
	self sessionHolder addChildToBody:tempButton.
]

{ #category : 'Not categorized' }
HfuSpPlayerView >> addPlayerButtonClicked: anPlayerAddEvent [
	|aGameView|
	aGameView := (HfuSpTicTacToePlayerViewController new createPlayerView).
	aGameView playerViewController player: self playerViewController player.
	aGameView playerViewController playerView: aGameView.
	aGameView playerViewController join: anPlayerAddEvent component name asInteger.
	self replaceView: aGameView.
	
]

{ #category : 'Not categorized' }
HfuSpPlayerView >> closeGamesClicked [

	HfuSpGameSessionsManager activeGameSessions: nil.
]

{ #category : 'Not categorized' }
HfuSpPlayerView >> createComponents [

	self playerViewController: HfuSpPlayerViewController new.
	self playerViewController setPlayerView: self.
	self sessionHolder: Me5Portlet new.
	self addChild: self sessionHolder.
	self updateSite.
	self addChild: (addGameButton := Me5Button newAirSecondary
					text: 'Create Game';
					addClickEventSelector: #addGameButtonClicked;
					yourself).
	self addChild: (closeGamesButton := Me5Button newAirSecondary
					text: 'Force Close all Games';
					addClickEventSelector: #closeGamesClicked;
					yourself).
	self addChild: (Me5Timeout new addIntervalSeconds: 3 selector:#updateSite; activate ;yourself).
					
]

{ #category : 'Not categorized' }
HfuSpPlayerView >> displayBoardState: anBoardState [

	"<^self>"
	"displays a board State on Screen"

	self subclassResponsibility
]

{ #category : 'Accessing' }
HfuSpPlayerView >> initializeView [

	^self
]

{ #category : 'Accessing' }
HfuSpPlayerView >> playerViewController [

	"<^iOf aPlayerViewController>"
	"Answer the playerViewController of the receiver"

	^playerViewController
]

{ #category : 'Accessing' }
HfuSpPlayerView >> playerViewController: anaPlayerViewController [

	"<anaPlayerViewController: iOf aPlayerViewController, ^self>"
	"Set the playerViewController of the receiver"

	playerViewController := anaPlayerViewController
]

{ #category : 'Accessing' }
HfuSpPlayerView >> sessionHolder [

	^sessionHolder
]

{ #category : 'Accessing' }
HfuSpPlayerView >> sessionHolder: anObject [

	sessionHolder := anObject
]

{ #category : 'Not categorized' }
HfuSpPlayerView >> startUp [
	
	| theHttpServer |
	HfuSpPlayer startUp.
	theHttpServer := (Me5SstHttpServer startUpHttpServerOnPort: '9004' serverApplicationClass: HfuSpPlayerView).
	theHttpServer addViewClass: HfuSpPlayerView.
	theHttpServer addViewClass: HfuSpTicTacToePlayerView.
	theHttpServer addViewClass: HfuSpManDontGetAngryPlayerView;
	yourself
]

{ #category : 'Accessing' }
HfuSpPlayerView >> updateSite [
		
		self aboutToReplaceView.
		self sessionHolder removeAllChildrenFromBody.
		HfuSpGameSessionsManager listAllActiveSessions size >= 1
		ifTrue: [
		self playerViewController getAllActiveSessions do:[:eachSession| 
					| tempButton |
				    tempButton := Me5Button newAirSecondary.
					tempButton text: ('Join TicTacToe ', (eachSession asString)).
					tempButton name: eachSession.
					tempButton addClickEventSelector: #addPlayerButtonClicked:.
					self sessionHolder addChildToBody: tempButton.
		]]
		ifFalse: [].
]
