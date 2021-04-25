Class {
	#name : 'ZmeExampleCounterView',
	#superclass : 'Me5BaseView',
	#instVars : [
		'counter'
	],
	#category : 'ZmeExampleCounterViewApp'
}

{ #category : 'Not categorized' }
ZmeExampleCounterView >> counter [

	^counter
]

{ #category : 'Not categorized' }
ZmeExampleCounterView >> counter: counterToSet [

		counter := counterToSet
]

{ #category : 'Not categorized' }
ZmeExampleCounterView >> createComponents [

	self
		addChild: (Me5Portlet new
			addChildToBody: (Me5Div new
				addChild: (Me5H5 newWithText: 'Counter');
				addChild: (counter := Me5Div new
				text: '0';
				yourself);
				addChild: (Me5Button newAirPrimary
					text: '+';
					addClickEventSelector: #increase;
					yourself);
				addChild: (Me5Button newAirPrimary
					text: '-';
					addClickEventSelector: #decrease;
					yourself);
				addChild: (Me5Button newAirPrimary
					text: 'Reset';
					addClickEventSelector: #reset;
					yourself);
				yourself);
			yourself);
		yourself
]

{ #category : 'Not categorized' }
ZmeExampleCounterView >> decrease [
	^self counter text: self counter text asNumber - 1
]

{ #category : 'Not categorized' }
ZmeExampleCounterView >> increase [
	^self counter text: self counter text asNumber + 1
]

{ #category : 'Not categorized' }
ZmeExampleCounterView >> reset [
	^self counter text: 0
]

{ #category : 'Not categorized',
  #vaVisibility : 'private' }
ZmeExampleCounterView >> startUp [
Private - comment"
	| theHttpServer |
	theHttpServer := (Me5SstHttpServer startUpHttpServerOnPort: '9003' serverApplicationClass: ZmeExampleCounterViewApp).
	theHttpServer addViewClass: ZmeExampleCounterView;
	yourself
]
