!classDefinition: #TerniLapilliConsoleTests category: #'TerniLapilli-Ejercicio'!
TestCase subclass: #TerniLapilliConsoleTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!TerniLapilliConsoleTests methodsFor: 'Testing' stamp: 'LR 11/12/2018 02:21:48'!
test01XMovesAndAppearsInConsoleLines

	|game console |
	
	game _ TerniLapilli new.
	console _ TerniLapilliConsole on: game.
	
	game putXAt: 2@2.
	
	self assert: 'X marcó en 2@2' equals: (console lines at: 1).
	self assert: 'Estado: Jugando O' equals: (console lines at: 2).
	self assert: console lines size equals: 2. 
	
	! !

!TerniLapilliConsoleTests methodsFor: 'Testing' stamp: 'LR 11/12/2018 02:28:53'!
test02OMovesAndAppearsInConsoleLines

	|game console |
	
	game _ TerniLapilli new.
	console _ TerniLapilliConsole on: game.
	
	game putXAt: 2@2.
	game putOAt:1@1.
	
	self assert: 'X marcó en 2@2' equals: (console lines at: 1).
	self assert: 'Estado: Jugando O' equals: (console lines at: 2).
	self assert: 'O marcó en 1@1' equals: (console lines at:3).
	self assert: 'Estado: Jugando X' equals: (console lines at:4).
	self assert: console lines size equals: 4. 
	
	! !

!TerniLapilliConsoleTests methodsFor: 'Testing' stamp: 'LR 11/12/2018 02:30:14'!
test03XWinTheGameAppearsInConsoleLines

	|game console |
	
	game _ TerniLapilli new.
	console _ TerniLapilliConsole on: game.
	
	game putXAt: 2@2.
	game putOAt:1@1.
	game putXAt: 1@3.
	game putOAt:1@2.
	game putXAt: 3@1.
	
	
	self assert: 'X marcó en 2@2' equals: (console lines at: 1).
	self assert: 'Estado: Jugando O' equals: (console lines at: 2).
	
	self assert: 'O marcó en 1@1' equals: (console lines at:3).
	self assert: 'Estado: Jugando X' equals: (console lines at:4).
	
	self assert: 'X marcó en 1@3' equals: (console lines at: 5).
	self assert: 'Estado: Jugando O' equals: (console lines at: 6).
	
	self assert: 'O marcó en 1@2' equals: (console lines at:7).
	self assert: 'Estado: Jugando X' equals: (console lines at:8).
	
	self assert: 'X marcó en 3@1' equals: (console lines at: 9).
	self assert: 'Estado: Juego terminado - ¡Ganó X!!' equals: (console lines at: 10).
	
	self assert: console lines size equals: 10. 
	
	! !

!TerniLapilliConsoleTests methodsFor: 'Testing' stamp: 'LR 11/12/2018 06:12:07'!
test05UnfinishGameWithSlidingXinConsoleLines

	|game console |
	
	game _ TerniLapilli new.
	console _ TerniLapilliConsole on: game.
	
	game putXAt: 2@2.
	game putOAt:1@1.
	game putXAt: 1@3.
	game putOAt:3@1.
	game putXAt: 2@1.
	game putOAt:2@3.
	game slideXFrom:  1@3  to: 1@2.

	
	
	self assert: 'X marcó en 2@2' equals: (console lines at: 1).
	self assert: 'Estado: Jugando O' equals: (console lines at: 2).
	
	self assert: 'O marcó en 1@1' equals: (console lines at:3).
	self assert: 'Estado: Jugando X' equals: (console lines at:4).
	
	self assert: 'X marcó en 1@3' equals: (console lines at: 5).
	self assert: 'Estado: Jugando O' equals: (console lines at: 6).
	
	self assert: 'O marcó en 3@1' equals: (console lines at:7).
	self assert: 'Estado: Jugando X' equals: (console lines at:8).
	
	self assert: 'X marcó en 2@1' equals: (console lines at: 9).
	self assert: 'Estado: Jugando O' equals: (console lines at: 10).
	
	self assert: 'O marcó en 2@3' equals: (console lines at:11).
	self assert: 'Estado: Jugando X' equals: (console lines at:12).
	
	self assert: 'X deslizó hasta 1@2 desde 1@3' equals: (console lines at:13).
	self assert: 'Estado: Jugando O' equals: (console lines at:14).

	
	
	self assert: console lines size equals: 14. ! !

!TerniLapilliConsoleTests methodsFor: 'Testing' stamp: 'LR 11/12/2018 06:05:04'!
test06UnfinishGameWithSlidingOinConsoleLines

	|game console |
	
	game _ TerniLapilli new.
	console _ TerniLapilliConsole on: game.
	
	game putXAt: 2@2.
	game putOAt:1@1.
	game putXAt: 1@3.
	game putOAt:3@1.
	game putXAt: 2@1.
	game putOAt:2@3.
	game slideXFrom:  1@3  to: 1@2.
	game slideOFrom: 3@1  to: 3@2.
	game slideXFrom: 2@2  to: 3@3.
	
	
	self assert: 'X marcó en 2@2' equals: (console lines at: 1).
	self assert: 'Estado: Jugando O' equals: (console lines at: 2).
	
	self assert: 'O marcó en 1@1' equals: (console lines at:3).
	self assert: 'Estado: Jugando X' equals: (console lines at:4).
	
	self assert: 'X marcó en 1@3' equals: (console lines at: 5).
	self assert: 'Estado: Jugando O' equals: (console lines at: 6).
	
	self assert: 'O marcó en 3@1' equals: (console lines at:7).
	self assert: 'Estado: Jugando X' equals: (console lines at:8).
	
	self assert: 'X marcó en 2@1' equals: (console lines at: 9).
	self assert: 'Estado: Jugando O' equals: (console lines at: 10).
	
	self assert: 'O marcó en 2@3' equals: (console lines at:11).
	self assert: 'Estado: Jugando X' equals: (console lines at:12).
	
	self assert: 'X deslizó hasta 1@2 desde 1@3' equals: (console lines at:13).
	self assert: 'Estado: Jugando O' equals: (console lines at:14).
	
	self assert: 'O deslizó hasta 3@2 desde 3@1' equals: (console lines at:15).
	self assert: 'Estado: Jugando X' equals: (console lines at:16).
	
	self assert: 'X deslizó hasta 3@3 desde 2@2' equals: (console lines at:17).
	self assert: 'Estado: Jugando O' equals: (console lines at:18).
	
	self assert: console lines size equals: 18. ! !

!TerniLapilliConsoleTests methodsFor: 'Testing' stamp: 'LR 11/12/2018 05:08:48'!
test08FinishedGameBySlidingWinningOinConsoleLines

	|game console |
	
	game _ TerniLapilli new.
	console _ TerniLapilliConsole on: game.
	
	game putXAt: 3@2.
	game putOAt:1@1.
	game putXAt: 3@3.
	game putOAt:2@2.
	game putXAt: 1@3.
	game putOAt:3@1.
	game slideXFrom:  1@3  to: 2@3.
	game slideOFrom:  2@2  to: 2@1.
	
	
	self assert: 'X marcó en 3@2' equals: (console lines at: 1).
	self assert: 'Estado: Jugando O' equals: (console lines at: 2).
	
	self assert: 'O marcó en 1@1' equals: (console lines at:3).
	self assert: 'Estado: Jugando X' equals: (console lines at:4).
	
	self assert: 'X marcó en 3@3' equals: (console lines at: 5).
	self assert: 'Estado: Jugando O' equals: (console lines at: 6).
	
	self assert: 'O marcó en 2@2' equals: (console lines at:7).
	self assert: 'Estado: Jugando X' equals: (console lines at:8).
	
	self assert: 'X marcó en 1@3' equals: (console lines at: 9).
	self assert: 'Estado: Jugando O' equals: (console lines at: 10).
	
	self assert: 'O marcó en 3@1' equals: (console lines at:11).
	self assert: 'Estado: Jugando X' equals: (console lines at:12).
	
	self assert: 'X deslizó hasta 2@3 desde 1@3' equals: (console lines at:13).
	self assert: 'Estado: Jugando O' equals: (console lines at:14).
	
	self assert: 'O deslizó hasta 2@1 desde 2@2' equals: (console lines at:15).
	self assert: 'Estado: Juego terminado - ¡Ganó O!!' equals: (console lines at:16).
	
	self assert: console lines size equals: 16.! !


!classDefinition: #TerniLapilliTests category: #'TerniLapilli-Ejercicio'!
TestCase subclass: #TerniLapilliTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!TerniLapilliTests methodsFor: 'test' stamp: 'LR 11/8/2018 01:11:56'!
test01CreateNewGame

	|juego|
	
	juego _ TerniLapilli new.
	
	self assert: juego isEmpty.
! !

!TerniLapilliTests methodsFor: 'test' stamp: 'nme 11/5/2018 19:30:45'!
test02putX

	|game |
	
	game := TerniLapilli new.
	
	game putXAt:2@2.


	self assert: game fichasX size equals: 1.
	self assert: (game fichasX includes: 2@2).
	self assert: game fichasO isEmpty.! !

!TerniLapilliTests methodsFor: 'test' stamp: 'nme 11/5/2018 19:16:47'!
test03XMovesFirst

|game |
	
	game := TerniLapilli new.
	
	
		self 
			should: [ game putOAt: 2@2 ]
			raise: Error - MessageNotUnderstood 
			withExceptionDo: [ :anError |
				self assert: TerniLapilli notOTurnErrorMessage equals: anError messageText.
				self assert: game fichasO isEmpty.
				self assert: game fichasX isEmpty.].! !

!TerniLapilliTests methodsFor: 'test' stamp: 'nme 11/5/2018 19:31:14'!
test04putO

	|game |
	
	game := TerniLapilli new.
	
	game putXAt:2@1.
	game putOAt:2@2.

	self assert: game fichasO size equals: 1.
	self assert: (game fichasO includes: 2@2).
	
	self assert: game fichasX size equals: 1.
	self assert: (game fichasX includes: 2@1).! !

!TerniLapilliTests methodsFor: 'test' stamp: 'NME 11/4/2018 22:13:03'!
test05NotXTurn

	|game |
	
	game := TerniLapilli new.
	
	game putXAt:1@2.
	
		self 
			should: [ game putXAt: 2@2 ]
			raise: Error - MessageNotUnderstood 
			withExceptionDo: [ :anError |
				self assert: TerniLapilli notXTurnErrorMessage equals: anError messageText.
				self assert: 1 equals: game fichasX size.
				self assert: (game fichasX includes: 1@2).	
				self assert: game fichasO isEmpty].! !

!TerniLapilliTests methodsFor: 'test' stamp: 'NME 11/4/2018 22:09:23'!
test06NotOTurn

	|game |
	
	game := TerniLapilli new.
	
	game putXAt:1@2.
	game putOAt:2@2.
	
		self 
			should: [ game putOAt: 2@1 ]
			raise: Error - MessageNotUnderstood 
			withExceptionDo: [ :anError |
				self assert: TerniLapilli notOTurnErrorMessage equals: anError messageText.
				self assert: 1 equals: game fichasX size.
				self assert: (game fichasX includes: 1@2).	
				self assert: 1 equals: game fichasO size.
				self assert: (game fichasO includes: 2@2)].! !

!TerniLapilliTests methodsFor: 'test' stamp: 'NME 11/4/2018 22:08:21'!
test07NotTakeMyOwnPlaceX

	|game |
	
	game := TerniLapilli new.
	
	game putXAt:1@2.
	game putOAt:2@2.
	
		self 
			should: [ game putXAt: 1@2 ]
			raise: Error - MessageNotUnderstood 
			withExceptionDo: [ :anError |
				self assert: TerniLapilli takenPositionErrorMessage equals: anError messageText.
				self assert: 1 equals: game fichasX size.
				self assert: (game fichasX includes: 1@2).	
				self assert: 1 equals: game fichasO size.
				self assert: (game fichasO includes: 2@2)].! !

!TerniLapilliTests methodsFor: 'test' stamp: 'NME 11/4/2018 22:08:30'!
test08NotTakeMyOwnPlaceO

	|game |
	
	game := TerniLapilli new.
	
	game putXAt:1@2.
	game putOAt:2@2.
	game putXAt:1@1.
	
		self 
			should: [ game putOAt: 2@2 ]
			raise: Error - MessageNotUnderstood 
			withExceptionDo: [ :anError |
				self assert: TerniLapilli takenPositionErrorMessage equals: anError messageText.
				self assert: 2 equals: game fichasX size.
				self assert: (game fichasX includes: 1@2).
				self assert: (game fichasX includes: 1@1).	
				self assert: 1 equals: game fichasO size.
				self assert: (game fichasO includes: 2@2)].! !

!TerniLapilliTests methodsFor: 'test' stamp: 'NME 11/4/2018 22:14:24'!
test09XNotTakeOPalces

	|game |
	
	game := TerniLapilli new.
	
	game putXAt:1@2.
	game putOAt:2@2.
	
		self 
			should: [ game putXAt: 2@2 ]
			raise: Error - MessageNotUnderstood 
			withExceptionDo: [ :anError |
				self assert: TerniLapilli takenPositionErrorMessage equals: anError messageText.
				self assert: (game fichasX includes: 1@2).	
				self assert: 1 equals: game fichasO size.
				self assert: (game fichasO includes: 2@2)].! !

!TerniLapilliTests methodsFor: 'test' stamp: 'NME 11/4/2018 22:14:40'!
test10ONotTakeXPalces

	|game |
	
	game := TerniLapilli new.
	
	game putXAt:1@2.
	
		self 
			should: [ game putOAt: 1@2 ]
			raise: Error - MessageNotUnderstood 
			withExceptionDo: [ :anError |
				self assert: TerniLapilli takenPositionErrorMessage equals: anError messageText.
				self assert: (game fichasX includes: 1@2).	
				self assert: 1 equals: game fichasX size.
				self assert: game fichasO isEmpty ].! !

!TerniLapilliTests methodsFor: 'test' stamp: 'nme 11/5/2018 19:31:36'!
test11WithoutWinner

	|game |
	
	game := TerniLapilli new.
	
	game putXAt:1@2.
	game putOAt: 2@2.
	game putXAt: 2@1.
	game putOAt: 2@3.
	game putXAt: 3@2.
	game putOAt: 3@3.
	
	self deny: game XHasWon.
	self deny: game OHasWon.! !

!TerniLapilliTests methodsFor: 'test' stamp: 'nme 11/5/2018 19:31:54'!
test12XWinWithFirstRow

	|game |
	
	game := TerniLapilli new.
	
	game putXAt:1@1.
	game putOAt: 2@2.
	game putXAt: 1@2.
	game putOAt: 2@3.
	game putXAt: 1@3.
	
	self assert: game XHasWon.
	self deny: game OHasWon.! !

!TerniLapilliTests methodsFor: 'test' stamp: 'nme 11/5/2018 19:32:09'!
test13XWinWithSecondRow

	|game |
	
	game := TerniLapilli new.
	
	game putXAt:2@1.
	game putOAt: 1@2.
	game putXAt: 2@2.
	game putOAt: 1@1.
	game putXAt: 2@3.
	
	self assert: game XHasWon.
	self deny: game OHasWon.! !

!TerniLapilliTests methodsFor: 'test' stamp: 'nme 11/5/2018 19:32:17'!
test14XWinWithThirdRow

	|game |
	
	game := TerniLapilli new.
	
	game putXAt:3@1.
	game putOAt: 1@2.
	game putXAt: 3@2.
	game putOAt: 1@1.
	game putXAt: 3@3.

	self assert: game XHasWon.
	self deny: game OHasWon.! !

!TerniLapilliTests methodsFor: 'test' stamp: 'nme 11/5/2018 19:32:26'!
test15XWinWithFirstColumn

	|game |
	
	game := TerniLapilli new.
	
	game putXAt:1@1.
	game putOAt: 1@2.
	game putXAt: 2@1.
	game putOAt: 1@3.
	game putXAt: 3@1.
	
	
	self assert: game XHasWon.
	self deny: game OHasWon.! !

!TerniLapilliTests methodsFor: 'test' stamp: 'nme 11/5/2018 19:32:34'!
test16XWinWithSecondColumn

	|game |
	
	game := TerniLapilli new.
	
	game putXAt:1@2.
	game putOAt: 1@1.
	game putXAt: 2@2.
	game putOAt: 1@3.
	game putXAt: 3@2.

	
	self assert: game XHasWon.
	self deny: game OHasWon.! !

!TerniLapilliTests methodsFor: 'test' stamp: 'nme 11/5/2018 19:32:43'!
test17XWinWithThirdColumn

	|game |
	
	game := TerniLapilli new.
	
	game putXAt:1@3.
	game putOAt: 1@1.
	game putXAt: 2@3.
	game putOAt: 1@2.
	game putXAt: 3@3.
	
	
	self assert: game XHasWon.
	self deny: game OHasWon.! !

!TerniLapilliTests methodsFor: 'test' stamp: 'nme 11/5/2018 19:32:51'!
test18XWinWithUpDiagonal

	|game |
	
	game := TerniLapilli new.
	
	game putXAt:1@3.
	game putOAt: 1@1.
	game putXAt: 2@2.
	game putOAt: 1@2.
	game putXAt: 3@1.
	
	self assert: game XHasWon.
	self deny: game OHasWon.! !

!TerniLapilliTests methodsFor: 'test' stamp: 'nme 11/5/2018 19:32:59'!
test19XWinWithDownDiagonal

	|game |
	
	game := TerniLapilli new.
	
	game putXAt:1@1.
	game putOAt: 1@2.
	game putXAt: 2@2.
	game putOAt: 1@3.
	game putXAt: 3@3.
	
	self assert: game XHasWon.
	self deny: game OHasWon.! !

!TerniLapilliTests methodsFor: 'test' stamp: 'nme 11/5/2018 19:33:08'!
test20IfOWinWithFirstColumn

	|game |
	
	game := TerniLapilli new.
	
	game putXAt:1@2.
	game putOAt: 1@1.
	game putXAt: 2@3.
	game putOAt: 2@1.
	game putXAt: 3@2.
	game putOAt: 3@1.
	
	self deny: game XHasWon.
	self assert: game OHasWon.
	
	! !

!TerniLapilliTests methodsFor: 'test' stamp: 'nme 11/5/2018 19:33:36'!
test21IfXWinGameFinish

	|game |
	
	game := TerniLapilli new.
	
	game putXAt:1@1.
	game putOAt: 1@2.
	game putXAt: 2@2.
	game putOAt: 1@3.
	game putXAt: 3@3.	
	
		self 
			should: [ game putOAt: 3@1 ]
			raise: Error - MessageNotUnderstood 
			withExceptionDo: [ :anError |
				self assert: TerniLapilli gameFinishedErrorMessage equals: anError messageText].
	! !

!TerniLapilliTests methodsFor: 'test' stamp: 'nme 11/5/2018 19:34:10'!
test22ThreePiecesForPut

	|game |
	
	game := TerniLapilli new.
	
	game putXAt:1@2.
	game putOAt: 1@1.
	game putXAt: 2@3.
	game putOAt: 1@3.
	game putXAt: 3@2.
	game putOAt: 3@1.
	
		
	
		self 
			should: [ game putXAt: 2@2 ]
			raise: Error - MessageNotUnderstood 
			withExceptionDo: [ :anError |
				self assert: TerniLapilli withoutPiecesErrorMessage equals: anError messageText.
				self assert: 3 equals: game fichasO size.
				self assert: 3 equals: game fichasX size].
	! !

!TerniLapilliTests methodsFor: 'test' stamp: 'nme 11/5/2018 19:34:50'!
test23SlideXForFirstTime

	|game |
	
	game := TerniLapilli new.
	
	game putXAt:1@2.
	game putOAt: 1@1.
	game putXAt: 2@3.
	game putOAt: 1@3.
	game putXAt: 3@2.
	game putOAt: 3@1.
	
	game slideXFrom:1@2 to: 2@2.
		
		self deny: (game fichasX includes: 1@2).			
		self assert: (game fichasX includes: 2@2).
		self assert: (game fichasX includes: 2@3).
		self assert: (game fichasX includes: 3@2).
	! !

!TerniLapilliTests methodsFor: 'test' stamp: 'nme 11/5/2018 19:35:53'!
test24SlideOForFirstTime

	|game |
	
	game := TerniLapilli new.
	
	game putXAt:1@2.
	game putOAt: 1@1.
	game putXAt: 2@3.
	game putOAt: 1@3.
	game putXAt: 3@2.
	game putOAt: 3@1.
	
	game slideXFrom:1@2 to: 2@2.
	game slideOFrom:1@1 to: 2@1.
	
		
		
			
		self assert: (game fichasO includes: 2@1).
		self deny: (game fichasO includes: 1@1).
				
		
		self assert: (game fichasX includes: 2@2).
		self deny: (game fichasX includes: 1@2).! !

!TerniLapilliTests methodsFor: 'test' stamp: 'nme 11/5/2018 19:37:20'!
test25SlideOtoExXsPosition

	|game |
	
	game := TerniLapilli new.
	
	game putXAt:1@2.
	game putOAt: 1@1.
	game putXAt: 2@3.
	game putOAt: 1@3.
	game putXAt: 3@2.
	game putOAt: 3@1.
	
	game slideXFrom:1@2 to: 2@2.
	game slideOFrom:1@1 to: 1@2.
	
	
		self assert: (game fichasO includes: 1@2).
		self deny:(game fichasO includes: 1@1).
				
		
		self assert: (game fichasX includes: 2@2).
		self deny:  (game fichasX includes: 1@2).
	! !

!TerniLapilliTests methodsFor: 'test' stamp: 'nme 11/5/2018 19:37:40'!
test26NotXTurnSlide

	|game |
	
	game := TerniLapilli new.
	
	game putXAt:1@2.
	game putOAt: 1@1.
	game putXAt: 2@3.
	game putOAt: 1@3.
	game putXAt: 3@2.
	game putOAt: 3@1.
	
	game slideXFrom:1@2 to: 2@2.
	
	self should:[game slideXFrom: 3@2 to:3@3 ]  
		raise: Error - MessageNotUnderstood 
			withExceptionDo: [ :anError |self assert: TerniLapilli notXTurnErrorMessage equals: anError messageText]! !

!TerniLapilliTests methodsFor: 'test' stamp: 'NME 11/7/2018 23:59:04'!
test27NotOTurnSlide

	|game |
	
	game := TerniLapilli new.
	
	game putXAt:1@2.
	game putOAt: 1@1.
	game putXAt: 2@3.
	game putOAt: 1@3.
	game putXAt: 3@2.
	game putOAt: 3@1.
	
	game slideXFrom:1@2 to: 2@2.
	game slideOFrom:1@1 to: 2@1.
	
	self should:[game slideOFrom: 2@1 to:1@1 ]  
		raise: Error - MessageNotUnderstood 
			withExceptionDo: [ :anError |self assert: TerniLapilli notOTurnErrorMessage equals: anError messageText]! !

!TerniLapilliTests methodsFor: 'test' stamp: 'nme 11/5/2018 19:40:32'!
test28XWinByMoves

	|game |
	
	game := TerniLapilli new.
	
	game putXAt:1@2.
	game putOAt: 1@1.
	game putXAt: 2@3.
	game putOAt: 1@3.
	game putXAt: 3@2.
	game putOAt: 3@1.
	
	game slideXFrom:2@3 to: 2@2.
	
	self assert: game XHasWon.
		! !

!TerniLapilliTests methodsFor: 'test' stamp: 'nme 11/5/2018 19:46:25'!
test29OWinByMoves

	|game |
	
	game := TerniLapilli new.
	
	game putXAt:1@3.
	
	game putOAt: 1@2.
	
	game putXAt: 1@1.
	
	game putOAt: 2@3.
	
	game putXAt: 3@1.
	
	game putOAt: 3@2.
	
	game slideXFrom:3@1 to: 2@1.
	game slideOFrom: 2@3 to: 2@2. 
	
	self deny: game XHasWon.
	self assert: game OHasWon.! !

!TerniLapilliTests methodsFor: 'test' stamp: 'nme 11/5/2018 20:02:53'!
test30IfGameisFinishedByMovesCantMove

	|game |
	
	game := TerniLapilli new.
	
	game putXAt:1@3.
	
	game putOAt: 1@2.
	
	game putXAt: 1@1.
	
	game putOAt: 2@3.
	
	game putXAt: 3@1.
	
	game putOAt: 3@2.
	
	game slideXFrom:3@1 to: 2@1.
	game slideOFrom: 2@3 to: 2@2. 
	
	self should: [game slideXFrom: 2@1 to: 3@1] 
		 raise: Error - MessageNotUnderstood 	
		withExceptionDo: [:anError| self assert: TerniLapilli gameFinishedErrorMessage equals: anError messageText ].! !

!TerniLapilliTests methodsFor: 'test' stamp: 'nme 11/5/2018 20:12:28'!
test31XcantMoveToOPositions

	|game |
	
	game := TerniLapilli new.
	
	game putXAt:1@2.
	game putOAt: 1@1.
	game putXAt: 2@3.
	game putOAt: 1@3.
	game putXAt: 3@2.
	game putOAt: 3@1.
	
	self should: [game slideXFrom: 1@2 to: 1@1] 
		 raise: Error - MessageNotUnderstood 	
		withExceptionDo: [:anError| self assert: TerniLapilli takenPositionErrorMessage equals: anError messageText ].! !

!TerniLapilliTests methodsFor: 'test' stamp: 'nme 11/5/2018 20:22:39'!
test32OcantMoveToXPositions

	|game |
	
	game := TerniLapilli new.
	
	game putXAt:1@3.
	
	game putOAt: 1@2.
	
	game putXAt: 1@1.
	
	game putOAt: 2@3.
	
	game putXAt: 3@1.
	
	game putOAt: 3@2.
	
	game slideXFrom:3@1 to: 2@1.
	
	
	self should: [game slideOFrom: 1@2 to: 1@3] 
		 raise: Error - MessageNotUnderstood 	
		withExceptionDo: [:anError| self assert: TerniLapilli takenPositionErrorMessage equals: anError messageText ].! !

!TerniLapilliTests methodsFor: 'test' stamp: 'nme 11/5/2018 20:27:13'!
test33PositionInRange

	|game |
	
	game := TerniLapilli new.
	
	game putXAt:1@3.
	
	game putOAt: 1@2.
	
	game putXAt: 1@1.
	
	game putOAt: 2@3.
	
	game putXAt: 3@1.
	
	game putOAt: 3@2.
	
	game slideXFrom:3@1 to: 2@1.
	
	
	self should: [game slideOFrom: 1@2 to: 0@2] 
		 raise: Error - MessageNotUnderstood 	
		withExceptionDo: [:anError| self assert: TerniLapilli outOfRangeErrorMessage equals: anError messageText ].! !

!TerniLapilliTests methodsFor: 'test' stamp: 'nme 11/5/2018 20:39:24'!
test34PutPositionInRange

	|game |
	
	game := TerniLapilli new.
	
	game putXAt:1@3.
	
	game putOAt: 1@2.
	
	game putXAt: 1@1.
	
	game putOAt: 2@3.

	
	
	self should: [game putXAt: 4@1.] 
		 raise: Error - MessageNotUnderstood 	
		withExceptionDo: [:anError| self assert: TerniLapilli outOfRangeErrorMessage equals: anError messageText ].! !

!TerniLapilliTests methodsFor: 'test' stamp: 'nme 11/5/2018 20:46:05'!
test35CantSlideIfDidntPutAllPieces

	|game |
	
	game := TerniLapilli new.
	
	game putXAt:1@3.
	
	game putOAt: 1@2.
	
	game putXAt: 1@1.
	
	game putOAt: 2@3.

	
	
	self should: [game slideXFrom: 1@1 to:2@1] 
		 raise: Error - MessageNotUnderstood 	
		withExceptionDo: [:anError| self assert: TerniLapilli piecesToPutErrorMessage equals: anError messageText ].! !

!TerniLapilliTests methodsFor: 'test' stamp: 'NME 11/8/2018 00:24:53'!
test36SlidetoANonIllegalPosition

	|game |
	
	game := TerniLapilli new.
	
	game putXAt:1@3.
	
	game putOAt: 1@2.
	
	game putXAt: 1@1.
	
	game putOAt: 2@3.
	
	game putXAt: 3@1.
	
	game putOAt: 3@2.

	
	
	self should: [game slideXFrom:3@1 to: 3@3.] 
		 raise: Error - MessageNotUnderstood 	
		withExceptionDo: [:anError| self assert: TerniLapilli illegalPositionErrorMessage equals: anError messageText ].! !


!classDefinition: #TerniLapilliViewTests category: #'TerniLapilli-Ejercicio'!
TestCase subclass: #TerniLapilliViewTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!TerniLapilliViewTests methodsFor: 'Testing' stamp: 'LR 11/12/2018 06:09:37'!
test09XEmptyView

	|game console |
	
	game _ TerniLapilli new.
	console _ TerniLapilliView on: game.
	
	self assert: ' | | ' equals: (console lines at: 1).
	self assert: '-----' equals: (console lines at: 2).
	self assert: ' | | ' equals: (console lines at: 3).
	self assert: '-----' equals: (console lines at: 4).
	self assert: ' | | ' equals: (console lines at: 5).
	self assert: '' equals: (console lines at: 6).
	self assert: console lines size equals: 6. 
	
	! !

!TerniLapilliViewTests methodsFor: 'Testing' stamp: 'LR 11/12/2018 05:12:34'!
test10XMovesAndAppearsInView

	|game console |
	
	game _ TerniLapilli new.
	console _ TerniLapilliView on: game.
	
	game putXAt: 2@2.
	
	self assert: ' | | ' equals: (console lines at: 1).
	self assert: '-----' equals: (console lines at: 2).
	self assert: ' |X| ' equals: (console lines at: 3).
	self assert: '-----' equals: (console lines at: 4).
	self assert: ' | | ' equals: (console lines at: 5).
	self assert: 'Playing O' equals: (console lines at:6).
	self assert: console lines size equals: 6. 
	
	! !

!TerniLapilliViewTests methodsFor: 'Testing' stamp: 'LR 11/12/2018 06:05:38'!
test11XTwoMovesAndAppearsInView

	| game console |
	
	game _ TerniLapilli new.
	console _ TerniLapilliView on: game.
	
	game putXAt: 2@2.
	game putOAt:3@1.
	
	self assert: ' | | ' equals: (console lines at: 1).
	self assert: '-----' equals: (console lines at: 2).
	self assert: ' |X| ' equals: (console lines at: 3).
	self assert: '-----' equals: (console lines at: 4).
	self assert: 'O| | ' equals: (console lines at: 5).
	self assert: 'Playing X' equals: (console lines at:6).
	self assert: console lines size equals: 6. 
	
	! !

!TerniLapilliViewTests methodsFor: 'Testing' stamp: 'LR 11/12/2018 06:10:45'!
test12XHasWon

	| game console |
	
	game _ TerniLapilli new.
	console _ TerniLapilliView on: game.
	
	game putXAt: 2@2.
	game putOAt: 3@1.
	game putXAt: 1@1.
	game putOAt: 2@1.
	game putXAt: 3@3.
	
	self assert: 'X| | ' equals: (console lines at: 1).
	self assert: '-----' equals: (console lines at: 2).
	self assert: 'O|X| ' equals: (console lines at: 3).
	self assert: '-----' equals: (console lines at: 4).
	self assert: 'O| |X' equals: (console lines at: 5).
	self assert: 'X Won!!' equals: (console lines at:6).
	self assert: console lines size equals: 6. 
	
	! !

!TerniLapilliViewTests methodsFor: 'Testing' stamp: 'LR 11/12/2018 07:16:14'!
test13XSlidesAndOPlays

	| game console |
	
	game _ TerniLapilli new.
	console _ TerniLapilliView on: game.
	
	game putXAt: 2@2.
	game putOAt:1@1.
	game putXAt: 1@3.
	game putOAt:3@1.
	game putXAt: 2@1.
	game putOAt:2@3.
	game slideXFrom:  1@3  to: 1@2.
	
	self assert: 'O|X| ' equals: (console lines at: 1).
	self assert: '-----' equals: (console lines at: 2).
	self assert: 'X|X|O' equals: (console lines at: 3).
	self assert: '-----' equals: (console lines at: 4).
	self assert: 'O| | ' equals: (console lines at: 5).
	self assert: 'Playing O' equals: (console lines at:6).
	self assert: console lines size equals: 6. 
	
	! !

!TerniLapilliViewTests methodsFor: 'Testing' stamp: 'LR 11/12/2018 07:18:57'!
test14XSlidesAndXPlays

	| game console |
	
	game _ TerniLapilli new.
	console _ TerniLapilliView on: game.
	
	game putXAt: 3@2.
	game putOAt:1@1.
	game putXAt: 3@3.
	game putOAt:2@2.
	game putXAt: 1@3.
	game putOAt:3@1.
	game slideXFrom:  1@3  to: 2@3.
	game slideOFrom:  2@2  to: 2@1.
	
	self assert: 'O| | ' equals: (console lines at: 1).
	self assert: '-----' equals: (console lines at: 2).
	self assert: 'O| |X' equals: (console lines at: 3).
	self assert: '-----' equals: (console lines at: 4).
	self assert: 'O|X|X' equals: (console lines at: 5).
	self assert: 'O Won!!' equals: (console lines at:6).
	self assert: console lines size equals: 6. 
	
	! !


!classDefinition: #FinishedGameState category: #'TerniLapilli-Ejercicio'!
Object subclass: #FinishedGameState
	instanceVariableNames: 'game'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!FinishedGameState methodsFor: 'game moves' stamp: 'NME 11/7/2018 22:16:57'!
putOAt:aPosition

	^self error: game class gameFinishedErrorMessage.! !

!FinishedGameState methodsFor: 'game moves' stamp: 'NME 11/7/2018 22:17:09'!
putXAt:aPosition

	^self error: game class gameFinishedErrorMessage.! !

!FinishedGameState methodsFor: 'game moves' stamp: 'NME 11/8/2018 00:00:23'!
slideOFrom: anOldPosition to: aNewPosition

self error: game class gameFinishedErrorMessage! !

!FinishedGameState methodsFor: 'game moves' stamp: 'NME 11/8/2018 00:00:26'!
slideXFrom: anOldPosition to: aNewPosition

self error: game class gameFinishedErrorMessage! !


!FinishedGameState methodsFor: 'initialization' stamp: 'LR 11/12/2018 02:40:29'!
initializeWith:aGame

	game _ aGame.! !


!classDefinition: #WinnerO category: #'TerniLapilli-Ejercicio'!
FinishedGameState subclass: #WinnerO
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!WinnerO methodsFor: 'game state' stamp: 'NME 11/7/2018 21:32:38'!
OHasWon
	
	^true.! !

!WinnerO methodsFor: 'game state' stamp: 'NME 11/7/2018 21:32:45'!
XHasWon
	
	^false.! !


!classDefinition: #WinnerX category: #'TerniLapilli-Ejercicio'!
FinishedGameState subclass: #WinnerX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!WinnerX methodsFor: 'game state' stamp: 'NME 11/7/2018 21:32:55'!
OHasWon
	
	^false! !

!WinnerX methodsFor: 'game state' stamp: 'NME 11/7/2018 21:33:05'!
XHasWon
	
	^true! !


!classDefinition: #PlayingState category: #'TerniLapilli-Ejercicio'!
Object subclass: #PlayingState
	instanceVariableNames: 'game'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!PlayingState methodsFor: 'initialization' stamp: 'NME 11/7/2018 21:36:00'!
initializeWith: aGame

	game _ aGame.! !


!PlayingState methodsFor: 'game state' stamp: 'NME 11/7/2018 23:34:02'!
OHasWon
	
	^false! !

!PlayingState methodsFor: 'game state' stamp: 'NME 11/7/2018 23:33:58'!
XHasWon
	
	^false! !


!PlayingState methodsFor: 'game moves' stamp: 'NME 11/8/2018 00:02:33'!
slideOFrom: anOldPosition to: aNewPosition

	self error:game class piecesToPutErrorMessage! !

!PlayingState methodsFor: 'game moves' stamp: 'NME 11/8/2018 00:02:41'!
slideXFrom: anOldPosition to: aNewPosition

self error:game class piecesToPutErrorMessage! !


!classDefinition: #PlacingO category: #'TerniLapilli-Ejercicio'!
PlayingState subclass: #PlacingO
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!PlacingO methodsFor: 'game moves' stamp: 'LR 11/12/2018 03:16:01'!
putOAt:aPosition
	(game positionTaken:aPosition) ifTrue: [self error: game class takenPositionErrorMessage].
	game addAnOPosition:aPosition.
	game changeStateFromPlacingO: aPosition.
! !

!PlacingO methodsFor: 'game moves' stamp: 'LR 11/12/2018 02:33:08'!
putXAt:aPlace
	 self error: game class notXTurnErrorMessage! !


!classDefinition: #PlacingX category: #'TerniLapilli-Ejercicio'!
PlayingState subclass: #PlacingX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!PlacingX methodsFor: 'game moves' stamp: 'NME 11/7/2018 23:36:57'!
putOAt:aPlace

 self error: game class notOTurnErrorMessage! !

!PlacingX methodsFor: 'game moves' stamp: 'LR 11/12/2018 03:15:54'!
putXAt:aPosition
	(game positionTaken:aPosition) ifTrue: [self error: game class takenPositionErrorMessage].
	game addAnXPosition:aPosition.
	game changeStateFromPlacingX: aPosition.! !



!classDefinition: #SlidingO category: #'TerniLapilli-Ejercicio'!
PlayingState subclass: #SlidingO
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!SlidingO methodsFor: 'game moves' stamp: 'NME 11/7/2018 23:09:45'!
putOAt:aPosition

	self error: game class withoutPiecesErrorMessage .! !

!SlidingO methodsFor: 'game moves' stamp: 'LR 11/12/2018 04:31:20'!
slideOFrom: anOldPosition to: aNewPosition
	
	(game positionTaken: aNewPosition) ifTrue: [self error:game class takenPositionErrorMessage ].
	game addAnOPosition: aNewPosition.
	game removeAnOPosition:anOldPosition.
	game changeStateFromSlidingO: anOldPosition to: aNewPosition.! !

!SlidingO methodsFor: 'game moves' stamp: 'NME 11/7/2018 23:37:41'!
slideXFrom: anOldPosition to: aNewPosition 
	 self error: game class notXTurnErrorMessage! !


!classDefinition: #SlidingX category: #'TerniLapilli-Ejercicio'!
PlayingState subclass: #SlidingX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!SlidingX methodsFor: 'game moves' stamp: 'NME 11/7/2018 23:09:50'!
putXAt:aPosition

	self error: game class withoutPiecesErrorMessage .! !

!SlidingX methodsFor: 'game moves' stamp: 'NME 11/7/2018 23:37:51'!
slideOFrom: anOldPosition to: aNewPosition 
	 self error: game class notOTurnErrorMessage! !

!SlidingX methodsFor: 'game moves' stamp: 'LR 11/12/2018 04:31:04'!
slideXFrom: anOldPosition to: aNewPosition 

(game positionTaken: aNewPosition) ifTrue: [self error:game class takenPositionErrorMessage ].
	game addAnXPosition: aNewPosition.
	game removeAnXPosition:anOldPosition.
	game changeStateFromSlidingX: anOldPosition to: aNewPosition.! !


!classDefinition: #TerniLapilli category: #'TerniLapilli-Ejercicio'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'fichasX fichasO gameState observers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!TerniLapilli methodsFor: 'access' stamp: 'NME 11/7/2018 21:29:24'!
fichasO
	^fichasO copy! !

!TerniLapilli methodsFor: 'access' stamp: 'NME 11/7/2018 21:29:28'!
fichasX
	^fichasX copy! !

!TerniLapilli methodsFor: 'access' stamp: 'LR 11/8/2018 01:11:11'!
isEmpty
	^ fichasX isEmpty and: fichasO isEmpty.! !

!TerniLapilli methodsFor: 'access' stamp: 'NME 11/8/2018 00:04:31'!
positionTaken:aPosition

	^(fichasO includes: aPosition) or: [fichasX includes: aPosition]! !


!TerniLapilli methodsFor: 'initialization' stamp: 'LR 11/12/2018 02:24:02'!
initialize

	fichasX _ Set new.
	fichasO _ Set new.
	gameState _ PlacingX new initializeWith:self.
	observers _ OrderedCollection new.! !


!TerniLapilli methodsFor: 'game moves' stamp: 'LR 11/12/2018 02:38:40'!
putOAt: aPosition
	(self inRange:aPosition) ifFalse:[self error:self class outOfRangeErrorMessage].
	gameState putOAt: aPosition.! !

!TerniLapilli methodsFor: 'game moves' stamp: 'LR 11/12/2018 02:39:26'!
putXAt: aPosition
	(self inRange:aPosition) ifFalse:[self error:self class outOfRangeErrorMessage].
	gameState putXAt:aPosition.! !

!TerniLapilli methodsFor: 'game moves' stamp: 'NME 11/8/2018 00:37:24'!
slideOFrom: anOldPosition to: aNewPosition 
	
	
	(self isLegal: anOldPosition to:aNewPosition) ifFalse:[self error: self class illegalPositionErrorMessage].
	(self inRange:aNewPosition) ifFalse:[self error:self class outOfRangeErrorMessage].
		gameState slideOFrom: anOldPosition to: aNewPosition. ! !

!TerniLapilli methodsFor: 'game moves' stamp: 'NME 11/8/2018 00:29:20'!
slideXFrom: anOldPosition to: aNewPosition 
	
	(self isLegal: anOldPosition to:aNewPosition) ifFalse:[self error: self class illegalPositionErrorMessage].
	(self inRange:aNewPosition) ifFalse:[self error:self class outOfRangeErrorMessage].
	gameState slideXFrom: anOldPosition to: aNewPosition. 
	! !


!TerniLapilli methodsFor: 'game states' stamp: 'NME 11/7/2018 21:37:34'!
OHasWon
	
	^gameState OHasWon.! !

!TerniLapilli methodsFor: 'game states' stamp: 'NME 11/7/2018 23:33:35'!
XHasWon
	
	^gameState XHasWon.! !

!TerniLapilli methodsFor: 'game states' stamp: 'NME 11/5/2018 00:12:01'!
hasCompletedColumn: aSetOfPositions 

	^(1 to:3) anySatisfy: [:y| (aSetOfPositions count: [:position| position y = y] ) = 3].
	! !

!TerniLapilli methodsFor: 'game states' stamp: 'NME 11/5/2018 00:11:43'!
hasCompletedRow: aSetOfPositions 

	^(1 to:3) anySatisfy: [:x| (aSetOfPositions count: [:position| position x = x] ) = 3].
	! !

!TerniLapilli methodsFor: 'game states' stamp: 'NME 11/5/2018 00:16:52'!
hasDownDiagonal: aSetOfPositions 

	^(1 to:3) allSatisfy: [:n| aSetOfPositions includes: n@(4-n)].
	! !

!TerniLapilli methodsFor: 'game states' stamp: 'NME 11/5/2018 00:14:52'!
hasUpDiagonal: aSetOfPositions 

	^(1 to:3) allSatisfy: [:n| aSetOfPositions includes: n@n].
	! !

!TerniLapilli methodsFor: 'game states' stamp: 'NME 11/5/2018 00:11:11'!
hasWin:aSetOfPositions

	
	^(self hasCompletedColumn: aSetOfPositions) 
		or: [(self hasCompletedRow: aSetOfPositions) 
		or: [(self hasUpDiagonal: aSetOfPositions)
		or: [self hasDownDiagonal: aSetOfPositions]]].! !

!TerniLapilli methodsFor: 'game states' stamp: 'nme 11/5/2018 20:35:33'!
inRange: aPosition

	^((1 to:3) anySatisfy: [:xRange| aPosition x= xRange]) and: ((1 to:3) anySatisfy: [:yRange| aPosition y= yRange])! !

!TerniLapilli methodsFor: 'game states' stamp: 'NME 11/8/2018 00:34:43'!
isLegal: anOldPosition to: aNewPosition

	^(aNewPosition x = (anOldPosition x +1) 
	or: [aNewPosition x = (anOldPosition x -1)]  
	or:[aNewPosition x = (anOldPosition x)]) 
	and:[(aNewPosition y = (anOldPosition y+1) or: [aNewPosition y = (anOldPosition y -1)] 
		or: [aNewPosition y = (anOldPosition y )])]! !

!TerniLapilli methodsFor: 'game states' stamp: 'NME 11/8/2018 00:24:36'!
isNotLegal: anOldPosition to: aNewPosition

	^(aNewPosition x = (anOldPosition x +1) 
	or: [aNewPosition x = (anOldPosition x -1)] ) 
	and:[(aNewPosition y = (anOldPosition y+1) or: [aNewPosition y = (anOldPosition y -1)] )]! !


!TerniLapilli methodsFor: 'position changes' stamp: 'NME 11/7/2018 23:28:34'!
addAnOPosition:aPosition

	fichasO add:aPosition .! !

!TerniLapilli methodsFor: 'position changes' stamp: 'NME 11/7/2018 23:28:28'!
addAnXPosition:aPosition

	fichasX add:aPosition .! !

!TerniLapilli methodsFor: 'position changes' stamp: 'NME 11/7/2018 23:18:35'!
removeAnOPosition:aPosition

fichasO remove:aPosition.! !

!TerniLapilli methodsFor: 'position changes' stamp: 'NME 11/7/2018 23:18:42'!
removeAnXPosition:aPosition

fichasX remove:aPosition.! !


!TerniLapilli methodsFor: 'change states' stamp: 'LR 11/12/2018 03:05:45'!
changeStateFromPlacingO

	(self hasWin: fichasO)
	ifTrue: [gameState := WinnerO new initializeWith:self]
	ifFalse: 
	[fichasX size = 3 
		ifTrue: [gameState:= SlidingX new initializeWith:self] 
		ifFalse:[gameState := PlacingX new initializeWith:self]
		].! !

!TerniLapilli methodsFor: 'change states' stamp: 'LR 11/12/2018 03:17:56'!
changeStateFromPlacingO: aPosition

	observers do: [:observer | observer putOAt: aPosition ].
	
	(self hasWin: fichasO)
	ifTrue: [gameState := WinnerO new initializeWith:self.
			 observers do: [:observer | observer OWin. ].]
	ifFalse: 
	[	observers do: [:observer | observer XIsPlaying. ].
		fichasX size = 3 
		ifTrue: [gameState:= SlidingX new initializeWith:self] 
		ifFalse:[gameState := PlacingX new initializeWith:self]
		].! !

!TerniLapilli methodsFor: 'change states' stamp: 'NME 11/8/2018 00:03:48'!
changeStateFromPlacingX

	(self hasWin: fichasX)
	ifTrue: [gameState := WinnerX new initializeWith:self]
	ifFalse: 
	[fichasO size = 3 
		ifTrue: [gameState:= SlidingO new initializeWith:self] 
		ifFalse:[gameState := PlacingO new initializeWith:self]
		].! !

!TerniLapilli methodsFor: 'change states' stamp: 'LR 11/12/2018 03:18:43'!
changeStateFromPlacingX: aPosition
	
	observers do: [:observer | observer putXAt: aPosition ].

	(self hasWin: fichasX)
	ifTrue: [gameState := WinnerX new initializeWith:self.
			 observers do: [:observer | observer XWin. ].]
	ifFalse: 
	[	observers do: [:observer | observer OIsPlaying ].
		fichasO size = 3 
		ifTrue: [gameState:= SlidingO new initializeWith:self] 
		ifFalse:[gameState := PlacingO new initializeWith:self]
		].! !

!TerniLapilli methodsFor: 'change states' stamp: 'NME 11/8/2018 00:03:55'!
changeStateFromSlidingO

(self hasWin: fichasO)
	ifTrue: [gameState := WinnerO new initializeWith:self]
	ifFalse: [gameState:= SlidingX new initializeWith:self]! !

!TerniLapilli methodsFor: 'change states' stamp: 'LR 11/12/2018 05:09:16'!
changeStateFromSlidingO: fromPosition to: newPosition

	observers do: [:observer | observer slideOFrom: fromPosition  to: newPosition ].
(self hasWin: fichasO)
	ifTrue: 
		[gameState _ WinnerO new initializeWith:self.
		 observers do: [:observer | observer OWin. ]
		]
	
	ifFalse: 
		[gameState _ SlidingX new initializeWith:self.
		 observers do: [:observer | observer XIsPlaying ]
		]
	
! !

!TerniLapilli methodsFor: 'change states' stamp: 'NME 11/8/2018 00:04:01'!
changeStateFromSlidingX

(self hasWin: fichasX)
	ifTrue: [gameState := WinnerX new initializeWith:self]
	ifFalse: [gameState:= SlidingO new initializeWith:self]! !

!TerniLapilli methodsFor: 'change states' stamp: 'LR 11/12/2018 04:33:18'!
changeStateFromSlidingX: fromPosition to: newPosition

	observers do: [:observer | observer slideXFrom: fromPosition  to: newPosition ].
(self hasWin: fichasX)
	ifTrue: [gameState := WinnerX new initializeWith:self.
			 observers do: [:observer | observer XWin. ]
			]
	ifFalse: [gameState:= SlidingO new initializeWith:self.
			 observers do: [:observer | observer OIsPlaying ]
			]
	
! !


!TerniLapilli methodsFor: 'observers' stamp: 'LR 11/12/2018 02:24:40'!
addObserver: anObserver
	observers add: anObserver.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #'TerniLapilli-Ejercicio'!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'error messages' stamp: 'nme 11/5/2018 17:29:51'!
gameFinishedErrorMessage
	^'Game Finished'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'nme 11/5/2018 20:59:25'!
illegalPositionErrorMessage
	^'Illegal Position'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'NME 11/4/2018 21:50:59'!
notOTurnErrorMessage
	
	^'Not O''s turn'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'NME 11/4/2018 21:04:52'!
notXTurnErrorMessage
	
	^'Not X''s turn'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'nme 11/5/2018 20:33:27'!
outOfRangeErrorMessage
	
	^'Out of range position'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'nme 11/5/2018 20:47:23'!
piecesToPutErrorMessage
	
	^'You haven''t used all your pieces yet'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'NME 11/4/2018 21:59:35'!
takenPositionErrorMessage
	
	^'Position Taken'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'nme 11/5/2018 18:10:06'!
withoutPiecesErrorMessage
	
	^'You have used your three pieces'! !


!classDefinition: #TerniLapilliConsole category: #'TerniLapilli-Ejercicio'!
Object subclass: #TerniLapilliConsole
	instanceVariableNames: 'log'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!TerniLapilliConsole methodsFor: 'initialization' stamp: 'LR 11/12/2018 05:27:07'!
OIsPlaying
	log add: 'Estado: Jugando O'.! !

!TerniLapilliConsole methodsFor: 'initialization' stamp: 'LR 11/12/2018 03:12:21'!
OWin
	log add: 'Estado: Juego terminado - ¡Ganó O!!'.! !

!TerniLapilliConsole methodsFor: 'initialization' stamp: 'LR 11/12/2018 03:11:16'!
XIsPlaying
	log add: 'Estado: Jugando X'.! !

!TerniLapilliConsole methodsFor: 'initialization' stamp: 'LR 11/12/2018 03:10:54'!
XWin
	log add: 'Estado: Juego terminado - ¡Ganó X!!'.! !

!TerniLapilliConsole methodsFor: 'initialization' stamp: 'LR 11/12/2018 05:12:47'!
initializeOn: aTerni
	log _ OrderedCollection new.
	aTerni addObserver: self.
	! !

!TerniLapilliConsole methodsFor: 'initialization' stamp: 'LR 11/12/2018 02:26:44'!
lines
	^ log.! !

!TerniLapilliConsole methodsFor: 'initialization' stamp: 'LR 11/12/2018 03:40:23'!
putOAt: aPosition
	log add: 'O marcó en ', aPosition asString.! !

!TerniLapilliConsole methodsFor: 'initialization' stamp: 'LR 11/12/2018 03:10:20'!
putXAt: aPosition
	log add: 'X marcó en ', aPosition asString.! !

!TerniLapilliConsole methodsFor: 'initialization' stamp: 'LR 11/12/2018 06:12:35'!
slideOFrom: anOldPosition to: aNewPosition 
	log add: 'O deslizó hasta ', aNewPosition asString, ' desde ', anOldPosition asString.! !

!TerniLapilliConsole methodsFor: 'initialization' stamp: 'LR 11/12/2018 03:51:22'!
slideXFrom: anOldPosition to: aNewPosition 
	log add: 'X deslizó hasta ', aNewPosition asString, ' desde ', anOldPosition asString.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliConsole class' category: #'TerniLapilli-Ejercicio'!
TerniLapilliConsole class
	instanceVariableNames: ''!

!TerniLapilliConsole class methodsFor: 'initialization' stamp: 'LR 11/12/2018 02:22:45'!
on: aTerniLapi
	^ TerniLapilliConsole  new initializeOn: aTerniLapi! !


!classDefinition: #TerniLapilliView category: #'TerniLapilli-Ejercicio'!
Object subclass: #TerniLapilliView
	instanceVariableNames: 'log board'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!TerniLapilliView methodsFor: 'initialization' stamp: 'LR 11/12/2018 06:10:18'!
initializeOn: aTerni
	board _ OrderedCollection new.
	board add: ('   ' copy).
	board add: ('   ' copy).	
	board add: ('   ' copy).
	log _ String new.
	aTerni addObserver: self.
	! !


!TerniLapilliView methodsFor: 'operations' stamp: 'LR 11/12/2018 06:09:06'!
OIsPlaying
	log _ 'Playing O'.! !

!TerniLapilliView methodsFor: 'operations' stamp: 'LR 11/12/2018 07:18:46'!
OWin
	log _ 'O Won!!'.! !

!TerniLapilliView methodsFor: 'operations' stamp: 'LR 11/12/2018 06:09:00'!
XIsPlaying
	log _ 'Playing X'.! !

!TerniLapilliView methodsFor: 'operations' stamp: 'LR 11/12/2018 06:11:04'!
XWin
	log _ 'X Won!!'.! !

!TerniLapilliView methodsFor: 'operations' stamp: 'LR 11/12/2018 05:39:38'!
format: aString
	| result |
	
	result _  (aString at: 1) asString, '|', (aString at: 2) asString, '|', (aString at: 3) asString .	
	
	^ result.! !

!TerniLapilliView methodsFor: 'operations' stamp: 'LR 11/12/2018 06:09:17'!
lines
	| lines |
	lines _ OrderedCollection new. 
	
	lines add: (self format: (board at: 1)).
	lines add: '-----'.	
	lines add: (self format: (board at: 2)).
	lines add: '-----'.	
	lines add: (self format: (board at: 3)).
		
	" No se como podría hacer esto de la mejor manera, queria unir las 2 collections y no encontré el mensaje.. "
	lines add: log.
		
	^ lines
	! !

!TerniLapilliView methodsFor: 'operations' stamp: 'LR 11/12/2018 06:06:00'!
putOAt: aPosition
	| str |
	str _ board at: (aPosition x).
	str at: (aPosition y) put: $O.! !

!TerniLapilliView methodsFor: 'operations' stamp: 'LR 11/12/2018 06:12:57'!
putXAt: aPosition
	| str |
	str _ board at: (aPosition x).
	str at: (aPosition y) put: $X.! !

!TerniLapilliView methodsFor: 'operations' stamp: 'LR 11/12/2018 07:18:31'!
slideOFrom: anOldPosition to: aNewPosition 
	| str |
	str _ board at: (anOldPosition x).
	str at: (anOldPosition y) put: $ .

	str _ board at: (aNewPosition x).
	str at: (aNewPosition y) put: $O.
! !

!TerniLapilliView methodsFor: 'operations' stamp: 'LR 11/12/2018 06:13:39'!
slideXFrom: anOldPosition to: aNewPosition 
	| str |
	str _ board at: (anOldPosition x).
	str at: (anOldPosition y) put: $ .

	str _ board at: (aNewPosition x).
	str at: (aNewPosition y) put: $X.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliView class' category: #'TerniLapilli-Ejercicio'!
TerniLapilliView class
	instanceVariableNames: ''!

!TerniLapilliView class methodsFor: 'initialization' stamp: 'LR 11/12/2018 05:13:33'!
on: aTerni
	^ TerniLapilliView new initializeOn: aTerni! !
