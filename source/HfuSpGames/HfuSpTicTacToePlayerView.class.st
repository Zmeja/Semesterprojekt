Class {
	#name : 'HfuSpTicTacToePlayerView',
	#superclass : 'HfuSpPlayerView',
	#instVars : [
		'viewHolder',
		'tics',
		'createGameView',
		'addGameButton',
		'closeGamesButton',
		'gameView',
		'playerView'
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
	|tempButton createdGameSession|
	self closeGamesButton show.
	createdGameSession := HfuSpGameSessionsManager createGameSession: 'TicTacToe'.
	tempButton := Me5Button newAirSecondary.
	tempButton text: ('Join TicTacToe ', (createdGameSession asString)).
	tempButton name: createdGameSession asString.
	tempButton addClickEventSelector: #addPlayerButtonClicked:.
	self sessionHolder addChildToBody:tempButton.
	"self addOrRemoveViewHolderViaAjaxViewHolder holdingView: Me5MetronicExampleAView new"
]

{ #category : 'Not categorized' }
HfuSpTicTacToePlayerView >> addPlayerButtonClicked: anPlayerAddEvent [

	self playerViewController join: anPlayerAddEvent component name asInteger.
	self addGameButton hide.
	self sessionHolder hide.
	self gameView show.
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
	self playerViewController: HfuSpTicTacToePlayerViewController new.
	self playerViewController setPlayerView: self.
	self sessionHolder: Me5Portlet new.
	self addChild: self sessionHolder.
	tics := #('' '' '' '' '' '' '' '' '') asOrderedCollection.
	"tics at: 1 put: 1."
	HfuSpGameSessionsManager listAllActiveSessions size >= 1
		ifTrue: [
		self playerViewController getAllActiveSessions do:[:eachSession| | tempButton |
				    tempButton := Me5Button newAirSecondary.
					tempButton text: ('Join TicTacToe ', (eachSession asString)).
					tempButton name: eachSession.
					tempButton addClickEventSelector: #addPlayerButtonClicked:.
					self sessionHolder addChildToBody: tempButton.
		]]
		ifFalse: [].
	self
		addChild: (addGameButton := Me5Button newAirSecondary
					text: 'Create Game';
					addClickEventSelector: #addGameButtonClicked;
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
	
	self playerViewController transmitOrder: anEventFromTic component name asInteger.
]
