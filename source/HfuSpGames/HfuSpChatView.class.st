Class {
	#name : 'HfuSpChatView',
	#superclass : 'Me5BaseView',
	#instVars : [
		'textArea',
		'chatArea',
		'username'
	],
	#classVars : [
		'ChatUsers',
		'ChatMessages'
	],
	#category : 'HfuSpGames'
}

{ #category : 'Not categorized' }
HfuSpChatView class >> addChatMessage: tableRow [

	(HfuSpChatView chatMessages = nil)
	ifTrue: [HfuSpChatView chatMessages: OrderedCollection new ].
	
	HfuSpChatView chatMessages add: tableRow.
]

{ #category : 'Not categorized' }
HfuSpChatView class >> addChatMessage: chatMessage from: playerId [
	| currentMessage |
	(HfuSpChatView chatMessages = nil)
	ifTrue: [HfuSpChatView chatMessages: OrderedCollection new ].
	
	currentMessage := OrderedCollection new.
	
	currentMessage add: playerId.
	currentMessage add: chatMessage.
	
	HfuSpChatView chatMessages add: currentMessage.
]

{ #category : 'Not categorized' }
HfuSpChatView class >> addChatUser: chatUserView [
	(HfuSpChatView chatUsers = nil)
	ifTrue: [HfuSpChatView chatUsers: OrderedCollection new ].

	HfuSpChatView chatUsers add: chatUserView.
]

{ #category : 'Not categorized' }
HfuSpChatView class >> chatMessages [
	^ChatMessages
]

{ #category : 'Not categorized' }
HfuSpChatView class >> chatMessages: anObject [
	ChatMessages := anObject.
]

{ #category : 'Not categorized' }
HfuSpChatView class >> chatUsers [
	^ChatUsers
]

{ #category : 'Not categorized' }
HfuSpChatView class >> chatUsers: anObject [
	ChatUsers := anObject.
]

{ #category : 'Not categorized' }
HfuSpChatView >> chatArea [
	^chatArea
]

{ #category : 'Not categorized' }
HfuSpChatView >> chatArea: anObject [
	chatArea := anObject
]

{ #category : 'Not categorized' }
HfuSpChatView >> chatButtonClicked [

	self showInfoNotificationWithMessage:  'Chat was clicked!'
]

{ #category : 'Not categorized' }
HfuSpChatView >> createComponents [

	self
		addChild: (Me5FormPortlet new
			title:'Welcome!';
			addChildToBody: (Me5Section  new
				title: 'Chat';
				yourself);
				addChildToBody:  Me5SectionSeparator new;
					
				addChildToBody: (chatArea := self createTable
				setBorderedStyle;
				makeHoverable;
				smallTable;
				yourself);
				
				addChildToBody:  Me5SectionSeparator new;
				addChildToBody:(Me5Row new
					addChild: (textArea := Me5TextArea new
					addCssClassCol12;
					addCssClassCol6;
					text: 'Chat Area';
					helpText: 'Start here to chat with all your lovely coworkers.';
					yourself);
				yourself);
				
				addChildToBody:(Me5Button newAirSecondary
					text: 'Send Message';
					addClickEventSelector: #sendMessage;
					yourself);
					
					addCssClassMPaddingBottom15;
				yourself).
				
				
				
				self populateChatMessages.
				
				self addChild: (Me5Timeout new addIntervalSeconds: 5 selector:#populateChatMessages; activate ;yourself).
]

{ #category : 'Not categorized' }
HfuSpChatView >> createTable [

	^Me5Table new
		addChildToHead: (Me5TableRow new
			addTableHeaderWithText: 'Username';
			addTableHeaderWithText: 'Message';
			yourself);
		yourself
]

{ #category : 'Not categorized' }
HfuSpChatView >> logButtonClicked [

	self showInfoNotificationWithMessage:  'Log was clicked!'
]

{ #category : 'Not categorized' }
HfuSpChatView >> populateChatMessages [
	|tableRow usernameToAdd messageToAdd numberOfMessages|
	
	(HfuSpChatView chatMessages = nil)
	ifFalse:[
		numberOfMessages := 0.
		self chatArea removeAllChildrenFromBody.
		HfuSpChatView chatMessages do: [ :eachElement | 
		
			usernameToAdd := eachElement children at:1.
			usernameToAdd := usernameToAdd componentText.
			
			messageToAdd := eachElement children at:2.
			messageToAdd := messageToAdd componentText.
		
			tableRow := Me5TableRow new
				addTableDataWithText: (usernameToAdd);
				addTableDataWithText: (messageToAdd);
				"addTableDataWithText: (eachElement at:1 componentText);
				addTableDataWithText: (eachElement at:2 componentText);"
				yourself.
			(numberOfMessages +11 > HfuSpChatView chatMessages size)
			ifTrue: [
				self chatArea addChildToBody: tableRow.
			].
			numberOfMessages := numberOfMessages+1.
			
		]
	]
	

	
]

{ #category : 'Not categorized' }
HfuSpChatView >> sendMessage [
	"Here message gets send"
	| tableRow |
	
	self showInfoNotificationWithMessage:  self textArea value.
	
	tableRow := Me5TableRow new
		
		addTableDataWithText: username;
		addTableDataWithText: textArea value;
		yourself.
		
	HfuSpChatView addChatMessage: tableRow.
	
	self textArea value: ''.
]

{ #category : 'Not categorized' }
HfuSpChatView >> textArea [
	^textArea
]

{ #category : 'Not categorized' }
HfuSpChatView >> textArea: anObject [
	textArea := anObject
]

{ #category : 'Not categorized' }
HfuSpChatView >> username [
	^username
]

{ #category : 'Not categorized' }
HfuSpChatView >> username: anObject [
	username := anObject
]
