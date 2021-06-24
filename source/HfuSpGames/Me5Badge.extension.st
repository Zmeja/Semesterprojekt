Extension {
	#name : 'Me5Badge'
}

{ #category : '*HfuSpGames',
 #vaCategories : ['Me-API'] }
Me5Badge >> removeAllStylesAndSetDanger [
	
	self
		removeAllStylesAndSetWide
		addCssClassMBadgeDanger;
		yourself
]

{ #category : '*HfuSpGames',
 #vaCategories : ['Me-API'] }
Me5Badge >> removeAllStylesAndSetInfo [
	
	self
		removeAllStylesAndSetWide
		addCssClassMBadgeInfo;
		yourself
]

{ #category : '*HfuSpGames',
 #vaCategories : ['Me-API'] }
Me5Badge >> removeAllStylesAndSetPrimary [
	
	self
		removeAllStylesAndSetWide
		addCssClassMBadgePrimary;
		yourself
]

{ #category : '*HfuSpGames',
 #vaCategories : ['Me-API'] }
Me5Badge >> removeAllStylesAndSetSuccess [
	
	self
		removeAllStylesAndSetWide
		addCssClassMBadgeSuccess;
		yourself
]

{ #category : '*HfuSpGames',
 #vaCategories : ['Me-API'] }
Me5Badge >> removeAllStylesAndSetWarning [
	
	self
		removeAllStylesAndSetWide
		addCssClassMBadgeWarning;
		yourself
]

{ #category : '*HfuSpGames',
 #vaCategories : ['Me-API'] }
Me5Badge >> removeAllStylesAndSetWide [
	
	self
		removeAllCssClasses;
		addCssClass: MeCssMeBadge;
		addCssClassMBadge;
		setWideStyle;
		yourself
]
