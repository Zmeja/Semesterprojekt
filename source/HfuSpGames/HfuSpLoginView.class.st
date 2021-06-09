Class {
	#name : 'HfuSpLoginView',
	#superclass : 'Me5BaseView',
	#instVars : [
		'textCounter',
		'userDataDictionary',
		'errorCollection'
	],
	#category : 'HfuSpGames'
}

{ #category : 'Not categorized' }
HfuSpLoginView class >> createGoogleOAuth2UserAccess [

	"<^iOf ClwGoogleOAuth2UserAccess>"
	"The ClwGoogleOAuth2UserAcces is a User Access Client ID and Secret, which grants access to
	a project in the google developer console."

	^ClwGoogleOAuth2UserAccess newWithClientId: '1055167785156-lkcm46764sb8cp10v5ceeti8v026cogl.apps.googleusercontent.com'
		clientSecret: 'rbv0XoJH_HKRNaxEuThfJUYD'
		redirectUri: self getViewUrl
]

{ #category : 'Not categorized' }
HfuSpLoginView class >> getViewUrl [
	
	^(System isRuntime
		ifTrue: ['http://localhost:9009/HfuSpLoginView%1'] 
		ifFalse: ['http://localhost:9009/%1'])
			bindWith: self viewPath
]

{ #category : 'Not categorized' }
HfuSpLoginView class >> sessionClass [

	^Me5MetronicExampleSSOSession 
]

{ #category : 'Not categorized' }
HfuSpLoginView class >> startUp [

	| theHttpServer |
	HfuSpPlayer startUp.
	theHttpServer := (Me5SstHttpServer startUpHttpServerOnPort: '9009' serverApplicationClass: HfuSpLoginView).
	theHttpServer addViewClass: HfuSpLoginView;
	addViewClass: HfuSpLobbyView;
	addViewClass: HfuSpPlayerView;
	addViewClass: HfuSpTicTacToePlayerView;
	addViewClass: HfuSpManDontGetAngryPlayerView;
	addViewClass: HfuSpGameSessionLobbyRepresentationView;
	addViewClass: HfuSpPlayerView;
	addViewClass: HfuSpChatView;
		yourself
]

{ #category : 'Not categorized' }
HfuSpLoginView >> cleanUrlBar [
	
	self redirectUrl: self class getViewUrl
]

{ #category : 'Not categorized' }
HfuSpLoginView >> createComponents [
	|theTable|
		self userDataDictionary: nil.
		self getCredentials.
		self addChild:(Me5Button newInfo
			text: 'Login with Google';
			addClickEventSelector: #redirect;
			yourself).
]

{ #category : 'Not categorized' }
HfuSpLoginView >> errorCollection [

	^errorCollection
]

{ #category : 'Not categorized' }
HfuSpLoginView >> errorCollection: anObject [

	errorCollection := anObject
]

{ #category : 'Not categorized' }
HfuSpLoginView >> getCredentials [

	| theUserAccess |
	self errorCollection: OrderedCollection new.
	theUserAccess:= self getUserAccessFromSession
		ifNil: [self 
			setUserAccessFromSession: self class createGoogleOAuth2UserAccess;
			getUserAccessFromSession].
	theUserAccess isReady
		ifTrue: [self getUserData]
		ifFalse: [ | theUrlVariables |
			theUrlVariables := self currentHttpTransaction queryString urlVariables.
			theUrlVariables isEmpty
				ifFalse: [theUserAccess handleAuthenticationCallback: theUrlVariables.
					self setUserAccessFromSession: theUserAccess.
					self cleanUrlBar]]
]

{ #category : 'Not categorized' }
HfuSpLoginView >> getUserAccessFromSession [

	^self session oAuth2UserAccess
]

{ #category : 'Not categorized' }
HfuSpLoginView >> getUserData [

	 | theUserDataDictionary |
	theUserDataDictionary := self getUserAccessFromSession getUserData.
	(theUserDataDictionary includesKey: 'error')
		ifTrue: [self errorCollection add: ('Error occured: ', ((theUserDataDictionary at: 'error') at: 'message'))]
		ifFalse: [self userDataDictionary: theUserDataDictionary]
]

{ #category : 'Not categorized' }
HfuSpLoginView >> redirect [
	
		self userDataDictionary notNil
		ifTrue: [ self replaceRootViewAndScrollToTop: (HfuSpLobbyView new 
			userDataDictionary: self userDataDictionary;
			yourself)].
	self userDataDictionary isNil
	ifTrue: [
	self setUserAccessFromSession: self class createGoogleOAuth2UserAccess.
	self redirectUrl: self getUserAccessFromSession authenticationUrl].
]

{ #category : 'Not categorized' }
HfuSpLoginView >> setUserAccessFromSession: aClwGoogleOAuth2UserAccess [

	self session oAuth2UserAccess: aClwGoogleOAuth2UserAccess
]

{ #category : 'Not categorized' }
HfuSpLoginView >> userDataDictionary [

	^userDataDictionary
]

{ #category : 'Not categorized' }
HfuSpLoginView >> userDataDictionary: anObject [

	userDataDictionary := anObject
]
