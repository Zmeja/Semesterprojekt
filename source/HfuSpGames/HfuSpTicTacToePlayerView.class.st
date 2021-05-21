Class {
	#name : 'HfuSpTicTacToePlayerView',
	#superclass : 'HfuSpPlayerView',
	#instVars : [
		'viewHolder',
		'tics',
		'tic1',
		'tic2',
		'tic3',
		'tic4',
		'tic5',
		'tic6',
		'tic7',
		'tic8',
		'tic9',
		'createGameView',
		'addGameButton',
		'closeGamesButton',
		'addPlayerButton',
		'gameView',
		'playerID',
		'playerView'
	],
	#classVars : [
		'IsPlayer1Set',
		'CurrentSession',
		'IsPlayer2Set'
	],
	#category : 'HfuSpGames'
}

{ #category : 'Not categorized' }
HfuSpTicTacToePlayerView >> addGameButton [

	^addGameButton
]

{ #category : 'Not categorized' }
HfuSpTicTacToePlayerView >> addGameButton: aMeButton [

	addGameButton := aMeButton
]

{ #category : 'Not categorized' }
HfuSpTicTacToePlayerView >> addGameButtonClicked [

	self addGameButton hide.
	self closeGamesButton show.
	self addPlayerButton show.
	self IsPlayer1Set: false.
	self IsPlayer2Set: false.
	self CurrentSession: (HfuSpGameSessionsManager createGameSession: 'TicTacToe').
	"self addOrRemoveViewHolderViaAjaxViewHolder holdingView: Me5MetronicExampleAView new"
]

{ #category : 'Not categorized' }
HfuSpTicTacToePlayerView >> addPlayerButton [

	^addPlayerButton
]

{ #category : 'Not categorized' }
HfuSpTicTacToePlayerView >> addPlayerButton: aMeButton [

	addPlayerButton := aMeButton
]

{ #category : 'Not categorized' }
HfuSpTicTacToePlayerView >> addPlayerButtonClicked [

	self addPlayerButton hide.
	self IsPlayer1Set
	ifTrue:[
		self IsPlayer2Set
			ifTrue:[
			^self
			]
			ifFalse:[
			self playerID: 2.
			self IsPlayer2Set: true.
			]
		]
	ifFalse:[
	self playerID: 1.
	self IsPlayer1Set: true.
	].
	HfuSpGameSessionsManager addPlayer: self playerID ToSession: self CurrentSession currentView: self.
	self gameView show.
	
	"startet speil sobald der 2. Spieler beitrit"
	self playerID = 2
		ifTrue: [
		self playerViewController startGame.
			]
]

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
HfuSpTicTacToePlayerView >> closeGamesButton [

	^closeGamesButton
]

{ #category : 'Not categorized' }
HfuSpTicTacToePlayerView >> closeGamesButton: aMeButton [

	closeGamesButton := aMeButton
]

{ #category : 'Not categorized' }
HfuSpTicTacToePlayerView >> closeGamesClicked [

	HfuSpGameSessionsManager activeGameSessions: nil.
]

{ #category : 'Not categorized' }
HfuSpTicTacToePlayerView >> createComponents [

	"HfuSpGameSessionsManager activeGameSessions: nil."

	tics := #('' '' '' '' '' '' '' '' '') asOrderedCollection.
	"tics at: 1 put: 1."
	
	self
		addChild: (addGameButton := Me5Button newAirSecondary
					text: 'Create Game';
					addClickEventSelector: #addGameButtonClicked;
					yourself);
		addChild: (addPlayerButton := Me5Button newAirSecondary
					text: 'Join as Player 1';
					addClickEventSelector: #addPlayerButtonClicked;
					hide;
					yourself);
		
		addChild: (gameView := Me5Portlet new
			addChildToBody: (Me5Div new
				addChild: (Me5H5 newWithText: 'Tic Tac Toe');
				addChild: (tics at: 1 put: (Me5Button newAirSecondary
					text: '';
					name:'1';
					addClickEventSelector: #ticClicked:;
					yourself));
				addChild: (tics at: 2 put: (Me5Button newAirSecondary
					text: '';
					name:'2';
					addClickEventSelector: #ticClicked:;
					yourself));
				addChild: (tics at: 3 put: (Me5Button newAirSecondary
					text: '';
					name:'3';
					addClickEventSelector: #ticClicked:;
					yourself));
				yourself);
				addChildToBody: (Me5Div new
				addChild: (tics at: 4 put: (Me5Button newAirSecondary
					text: '';
					name:'4';
					addClickEventSelector: #ticClicked:;
					yourself));
				addChild: (tics at: 5 put: (Me5Button newAirSecondary
					text: '';
					name:'5';
					addClickEventSelector: #ticClicked:;
					yourself));
				addChild: (tics at: 6 put: (Me5Button newAirSecondary
					text: '';
					name:'6';
					addClickEventSelector: #ticClicked:;
					yourself));
				yourself);
				addChildToBody: (Me5Div new
				addChild: (tics at: 7 put: (Me5Button newAirSecondary
					text: '';
					name:'7';
					addClickEventSelector: #ticClicked:;
					yourself));
				addChild: (tics at: 8 put: (Me5Button newAirSecondary
					text: '';
					name:'8';
					addClickEventSelector: #ticClicked:;
					yourself));
				addChild: (tics at: 9 put: (Me5Button newAirSecondary
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
			
			addChild: (closeGamesButton := Me5Button newAirSecondary
					text: 'Force Close all Games';
					addClickEventSelector: #closeGamesClicked;
					hide;
					yourself);
		yourself.
		
		
		HfuSpGameSessionsManager listAllActiveSessions size >= 1
		ifTrue: [
		self addGameButton hide.
		self closeGamesButton show.
		self addPlayerButton show.
		self addPlayerButton text: 'Join as Player 2'.
		]
		ifFalse: [].
		
		self playerID = nil
		ifTrue: [
		]
		ifFalse: [
		self addGameButton hide.
		self gameView show.
		].
]

{ #category : 'Not categorized' }
HfuSpTicTacToePlayerView >> CurrentSession [

	^CurrentSession
]

{ #category : 'Not categorized' }
HfuSpTicTacToePlayerView >> CurrentSession: sessionToSet [

	CurrentSession := sessionToSet
]

{ #category : 'Not categorized' }
HfuSpTicTacToePlayerView >> displayBoardState: anBoardState [

	"<^self>"
	"displays a board State on Screen"

	self setGame: anBoardState.
	self refreshClicked.
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
HfuSpTicTacToePlayerView >> IsPlayer1Set [

	^IsPlayer1Set
]

{ #category : 'Not categorized' }
HfuSpTicTacToePlayerView >> IsPlayer1Set: booleanToSet [
	IsPlayer1Set := booleanToSet
]

{ #category : 'Not categorized' }
HfuSpTicTacToePlayerView >> IsPlayer2Set [

	^IsPlayer2Set
]

{ #category : 'Not categorized' }
HfuSpTicTacToePlayerView >> IsPlayer2Set: booleanToSet [
	IsPlayer2Set := booleanToSet
]

{ #category : 'Not categorized' }
HfuSpTicTacToePlayerView >> playerID [
	^playerID
]

{ #category : 'Not categorized' }
HfuSpTicTacToePlayerView >> playerID: playerIDToSet [
	playerID := playerIDToSet
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
HfuSpTicTacToePlayerView >> startUp [
	
	| theHttpServer |
	HfuSpPlayer startUp.
	theHttpServer := (Me5SstHttpServer startUpHttpServerOnPort: '9004' serverApplicationClass: HfuSpTicTacToePlayerView).
	theHttpServer addViewClass: HfuSpTicTacToePlayerView;
	yourself
]

{ #category : 'Not categorized' }
HfuSpTicTacToePlayerView >> ticClicked: anEventFromTic [
	|gameOrder|
	
	gameOrder := HfuSpTicTacToeOrder new.
	gameOrder playerID: self playerID.
	gameOrder fieldID: anEventFromTic component name asInteger.
	
	self playerViewController transmitOrder: gameOrder
]
