Class {
	#name : 'HfuSpTicTacToePlayerView',
	#superclass : 'HfuSpPlayerView',
	#instVars : [
		'viewHolder',
		'tics',
		'createGameView',
		'gameView',
		'playerView',
		'startGameButton'
	],
	#category : 'HfuSpTicTacToe'
}

{ #category : 'Not categorized' }
HfuSpTicTacToePlayerView >> announceVictor: aPlayerID [
	aPlayerID ~= -1
	ifTrue: [
	| winnerString |
	winnerString := 'Player ', aPlayerID asString, ' won!'.
	self showInfoNotificationWithMessage: winnerString.
	]

]

{ #category : 'Not categorized' }
HfuSpTicTacToePlayerView >> createComponents [

	"HfuSpGameSessionsManager activeGameSessions: nil."
	self tics: #('' '' '' '' '' '' '' '' '') asOrderedCollection.
		self addChild: (gameView := Me5Portlet new
			addChildToBody: (Me5Div new
				addChild: (Me5H5 newWithText: 'Tic Tac Toe');
				addChild: (self tics at: 1 put: (Me5Button newAirSecondary
					text: '';
					name:'1';
					addClickEventSelector: #ticClicked:;
					yourself));
				addChild: (self tics at: 2 put: (Me5Button newAirSecondary
					text: '';
					name:'2';
					addClickEventSelector: #ticClicked:;
					yourself));
				addChild: (self tics at: 3 put: (Me5Button newAirSecondary
					text: '';
					name:'3';
					addClickEventSelector: #ticClicked:;
					yourself));
				yourself);
				addChildToBody: (Me5Div new
				addChild: (self tics at: 4 put: (Me5Button newAirSecondary
					text: '';
					name:'4';
					addClickEventSelector: #ticClicked:;
					yourself));
				addChild: (self tics at: 5 put: (Me5Button newAirSecondary
					text: '';
					name:'5';
					addClickEventSelector: #ticClicked:;
					yourself));
				addChild: (self tics at: 6 put: (Me5Button newAirSecondary
					text: '';
					name:'6';
					addClickEventSelector: #ticClicked:;
					yourself));
				yourself);
				addChildToBody: (Me5Div new
				addChild: (self tics at: 7 put: (Me5Button newAirSecondary
					text: '';
					name:'7';
					addClickEventSelector: #ticClicked:;
					yourself));
				addChild: (self tics at: 8 put: (Me5Button newAirSecondary
					text: '';
					name:'8';
					addClickEventSelector: #ticClicked:;
					yourself));
				addChild: (self tics at: 9 put: (Me5Button newAirSecondary
					text: '';
					name:'9';
					addClickEventSelector: #ticClicked:;
					yourself));
				yourself);
				addChildToBody: (Me5Div new
				addChild: (Me5Button newAirSecondary
					text: 'Refresh';
					addClickEventSelector: #refreshClicked;
					yourself);
				yourself);
				hide;
			yourself);
		yourself.
		self addChild: (startGameButton:= (Me5Button newAirSecondary
					text: 'Start Game';
					addClickEventSelector: #startGameClicked;
					yourself)).
		self gameView show.
		self playerViewController displayCurrentBoardState.
		self addChild: (Me5Timeout new addIntervalSeconds: 1 selector:#updateSite:; activate ;yourself).
]

{ #category : 'Not categorized' }
HfuSpTicTacToePlayerView >> displayBoardState: anBoardState [

	"<^self>"
	"displays a board State on Screen"

	self setGame: anBoardState.
]

{ #category : 'Not categorized' }
HfuSpTicTacToePlayerView >> gameView [

	^gameView
]

{ #category : 'Not categorized' }
HfuSpTicTacToePlayerView >> gameView: gameViewToSet [
	gameView := gameViewToSet
]

{ #category : 'Not categorized' }
HfuSpTicTacToePlayerView >> refreshClicked [

	"^self gameView"
	self setGame: self playerViewController currentBoardState.
]

{ #category : 'Not categorized' }
HfuSpTicTacToePlayerView >> resetGame [
	| counter |
	
	counter := 1.
	tics do: [
		:eachIndex |
		counter := counter + 1.
		eachIndex text: ' '.
	].
	^true
]

{ #category : 'Not categorized' }
HfuSpTicTacToePlayerView >> setGame: boardState [
	| textToSet counter |
	
	counter := 1.
	tics do: [
		:eachIndex |
		textToSet:= boardState boardTiles at: counter.
		counter := counter + 1.
		eachIndex text: textToSet.
	].
	
	^true
]

{ #category : 'Not categorized' }
HfuSpTicTacToePlayerView >> startGameButton [

	^startGameButton
]

{ #category : 'Not categorized' }
HfuSpTicTacToePlayerView >> startGameButton: anObject [

	startGameButton := anObject
]

{ #category : 'Not categorized' }
HfuSpTicTacToePlayerView >> startGameClicked [
	
	self playerViewController startGame.
]

{ #category : 'Not categorized' }
HfuSpTicTacToePlayerView >> ticClicked: anEventFromTic [
	
	self playerViewController transmitOrder: anEventFromTic component name asInteger.
]

{ #category : 'Not categorized' }
HfuSpTicTacToePlayerView >> tics [

	^tics
]

{ #category : 'Not categorized' }
HfuSpTicTacToePlayerView >> tics: anObject [

	tics := anObject
]

{ #category : 'Not categorized' }
HfuSpTicTacToePlayerView >> updateSite: updateSiteEvent [

	self playerViewController displayCurrentBoardState.
]
