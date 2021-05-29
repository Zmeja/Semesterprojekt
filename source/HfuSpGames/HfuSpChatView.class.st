Class {
	#name : 'HfuSpChatView',
	#superclass : 'Me5BaseView',
	#instVars : [
		'textarea'
	],
	#category : 'HfuSpGames'
}

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
				addChildToBody:(Me5Row new
					addChild: (Me5Button newPrimary
						text: 'Chat';
						addClickEventSelector: #chatButtonClicked;
						yourself);
					addChild: (Me5Button newPrimary
						backgroundColor: 'red';
						text: 'Log';
						addClickEventSelector: #logButtonClicked;
						yourself);
					yourself);
				yourself);
				addChildToBody:  Me5SectionSeparator new;
				
				addChildToBody: (Me5Badge new
					text: 'Hier ein container fuer Chatnachrichten?';
					yourself);
				
				addChildToBody:  Me5SectionSeparator new;
				addChildToBody:(Me5Row new
					addChild: (textarea := Me5TextArea new
					addCssClassCol12;
					addCssClassCol6;
					text: 'Chat Area';
					helpText: 'Start here to chat with all your lovely coworkers.';
					yourself);
				yourself);
			yourself).
]

{ #category : 'Not categorized' }
HfuSpChatView >> logButtonClicked [

	self showInfoNotificationWithMessage:  'Log was clicked!'
]

{ #category : 'Not categorized' }
HfuSpChatView >> textarea [
	^textarea
]

{ #category : 'Not categorized' }
HfuSpChatView >> textarea: anObject [
	textarea := anObject
]
