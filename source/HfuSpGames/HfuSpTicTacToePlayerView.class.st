Class {
	#name : 'HfuSpTicTacToePlayerView',
	#superclass : 'HfuSpPlayerView',
	#instVars : [
		'tic1',
		'tic2',
		'tic3',
		'tic4',
		'tic5',
		'tic6',
		'tic7',
		'tic8',
		'tic9'
	],
	#category : 'HfuSpGames'
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

	| stub |

	self
		addChild: (Me5Portlet new
			addChildToBody: (Me5Div new
				addChild: (Me5H5 newWithText: 'Tic Tac Toe');
				addChild: (tic1 := Me5Button newAirSecondary
					text: '';
					yourself);
				addChild: (tic2 := Me5Button newAirSecondary
					text: '';
					yourself);
				addChild: (tic3 := Me5Button newAirSecondary
					text: '';
					yourself);
				yourself);
				addChildToBody: (Me5Div new
				addChild: (tic4 := Me5Button newAirSecondary
					text: '';
					yourself);
				addChild: (tic5 := Me5Button newAirSecondary
					text: '';
					yourself);
				addChild: (tic6 := Me5Button newAirSecondary
					text: '';
					yourself);
				yourself);
				addChildToBody: (Me5Div new
				addChild: (tic7 := Me5Button newAirSecondary
					text: '';
					yourself);
				addChild: (tic8 := Me5Button newAirSecondary
					text: '';
					yourself);
				addChild: (tic9 := Me5Button newAirSecondary
					text: '';
					yourself);
				yourself);
			yourself);
		yourself.
		self  setGame:  (self playerViewController  currentBoardState).
		stub:=HfuSpGameCreationStub new.
		stub createGame: self.
		stub createTicTacToeOrderForPlayer: 1 To: 1 .
		stub createTicTacToeOrderForPlayer: 2 To: 2 .
		stub createTicTacToeOrderForPlayer: 1 To: 3 .
		stub createTicTacToeOrderForPlayer: 2 To: 4 .
		stub createTicTacToeOrderForPlayer: 1 To: 5 .
		stub createTicTacToeOrderForPlayer: 2 To: 6 .
		stub createTicTacToeOrderForPlayer: 1 To: 7 .
		stub createTicTacToeOrderForPlayer: 2 To: 8 .
		stub createTicTacToeOrderForPlayer: 1 To: 9 .
]

{ #category : 'Not categorized' }
HfuSpTicTacToePlayerView >> displayBoardState: anBoardState [

	"<^self>"
	"displays a board State on Screen"

	self setGame: anBoardState
]

{ #category : 'Not categorized' }
HfuSpTicTacToePlayerView >> resetGame [
	self tic1 text: ' '.
	self tic2 text: ' '.
	self tic3 text: ' '.
	self tic4 text: ' '.
	self tic5 text: ' '.
	self tic6 text: ' '.
	self tic7 text: ' '.
	self tic8 text: ' '.
	self tic9 text: ' '.
	^true
]

{ #category : 'Not categorized' }
HfuSpTicTacToePlayerView >> setGame: boardState [
	| textToSet |
	textToSet:= boardState boardTiles at: 1.
	self tic1 text: textToSet.
	textToSet:= boardState boardTiles at: 2.
	self tic2 text: textToSet.
	textToSet:= boardState boardTiles at: 3.
	self tic3 text: textToSet.
	textToSet:= boardState boardTiles at: 4.
	self tic4 text: textToSet.
	textToSet:= boardState boardTiles at: 5.
	self tic5 text: textToSet.
	textToSet:= boardState boardTiles at: 6.
	self tic6 text: textToSet.
	textToSet:= boardState boardTiles at: 7.
	self tic7 text: textToSet.
	textToSet:= boardState boardTiles at: 8.
	self tic8 text: textToSet.
	textToSet:= boardState boardTiles at: 9.
	self tic9 text: textToSet.
	^true
]

{ #category : 'Not categorized' }
HfuSpTicTacToePlayerView >> setTicToPlayer: ticSelected asPlayerOwned: playerSelected [
	ticSelected = 1
		ifTrue: [tic1 text: playerSelected].
	ticSelected = 2
		ifTrue: [tic2 text: playerSelected].
	ticSelected = 3
		ifTrue: [tic4 text: playerSelected].
	ticSelected = 4
		ifTrue: [tic5 text: playerSelected].
	ticSelected = 5
		ifTrue: [tic6 text: playerSelected].
	ticSelected = 6
		ifTrue: [tic7 text: playerSelected].
	ticSelected = 7
		ifTrue: [tic8 text: playerSelected].
	ticSelected = 8
		ifTrue: [tic9 text: playerSelected].
	ticSelected = 9
		ifTrue: [tic3 text: playerSelected].
	^true
]

{ #category : 'Not categorized' }
HfuSpTicTacToePlayerView >> startUp [
	| theHttpServer |
	theHttpServer := (Me5SstHttpServer startUpHttpServerOnPort: '9004' serverApplicationClass: HfuSpTicTacToePlayerView).
	theHttpServer addViewClass: HfuSpTicTacToePlayerView;
	yourself
]

{ #category : 'Not categorized' }
HfuSpTicTacToePlayerView >> tic1 [
	^tic1
]

{ #category : 'Not categorized' }
HfuSpTicTacToePlayerView >> tic1: playerIDToSet [
	tic1 := playerIDToSet
]

{ #category : 'Not categorized' }
HfuSpTicTacToePlayerView >> tic2 [
	^tic2
]

{ #category : 'Not categorized' }
HfuSpTicTacToePlayerView >> tic2: playerIDToSet [
	tic2 := playerIDToSet
]

{ #category : 'Not categorized' }
HfuSpTicTacToePlayerView >> tic3 [
	^tic3
]

{ #category : 'Not categorized' }
HfuSpTicTacToePlayerView >> tic3: playerIDToSet [
	tic3 := playerIDToSet
]

{ #category : 'Not categorized' }
HfuSpTicTacToePlayerView >> tic4 [
	^tic4
]

{ #category : 'Not categorized' }
HfuSpTicTacToePlayerView >> tic4: playerIDToSet [
	tic4 := playerIDToSet
]

{ #category : 'Not categorized' }
HfuSpTicTacToePlayerView >> tic5 [
	^tic5
]

{ #category : 'Not categorized' }
HfuSpTicTacToePlayerView >> tic5: playerIDToSet [
	tic5 := playerIDToSet
]

{ #category : 'Not categorized' }
HfuSpTicTacToePlayerView >> tic6 [
	^tic6
]

{ #category : 'Not categorized' }
HfuSpTicTacToePlayerView >> tic6: playerIDToSet [
	tic6 := playerIDToSet
]

{ #category : 'Not categorized' }
HfuSpTicTacToePlayerView >> tic7 [
	^tic7
]

{ #category : 'Not categorized' }
HfuSpTicTacToePlayerView >> tic7: playerIDToSet [
	tic7 := playerIDToSet
]

{ #category : 'Not categorized' }
HfuSpTicTacToePlayerView >> tic8 [
	^tic8
]

{ #category : 'Not categorized' }
HfuSpTicTacToePlayerView >> tic8: playerIDToSet [
	tic8 := playerIDToSet
]

{ #category : 'Not categorized' }
HfuSpTicTacToePlayerView >> tic9 [
	^tic9
]

{ #category : 'Not categorized' }
HfuSpTicTacToePlayerView >> tic9: playerIDToSet [
	tic9 := playerIDToSet
]
