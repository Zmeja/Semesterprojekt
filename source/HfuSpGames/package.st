Package {
	#name : 'HfuSpGames',
	#vaPrerequisites : ['Me5MetronicApp'],
	#vaSubApplications : [
	{
		#condition : 'true',
		#subapps : [
			'HfuSpConnectFour',
			'HfuSpManDontGetAngry',
			'HfuSpTicTacToe'
		]
	}
]
}
