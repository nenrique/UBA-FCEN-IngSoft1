!classDefinition: #TerniLapilliTests category: #'TerniLapilli-Ejercicio'!
TestCase subclass: #TerniLapilliTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'NME 11/4/2018 22:10:05'!
test01CreateNewGame

	|juego|
	
	juego _ TerniLapilli new.
	
	self assert: juego fichasX isEmpty.
	self assert:juego fichasO isEmpty.! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'NME 11/4/2018 20:50:16'!
test02putX

	|game |
	
	game := TerniLapilli new.
	
	game putXAt:2@2.


	self assert: (game fichasX) size equals: 1.
	self assert: (game fichasX includes: 2@2).
	self assert: game fichasO isEmpty.! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'NME 11/4/2018 21:51:36'!
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

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'NME 11/4/2018 22:07:57'!
test04putO

	|game |
	
	game := TerniLapilli new.
	
	game putXAt:2@1.
	game putOAt:2@2.

	self assert: (game fichasO) size equals: 1.
	self assert: (game fichasO includes: 2@2).
	self assert: (game fichasX) size equals: 1.
	self assert: (game fichasX includes: 2@1).! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'NME 11/4/2018 22:13:03'!
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

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'NME 11/4/2018 22:09:23'!
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

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'NME 11/4/2018 22:08:21'!
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

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'NME 11/4/2018 22:08:30'!
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

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'NME 11/4/2018 22:14:24'!
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

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'NME 11/4/2018 22:14:40'!
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


!classDefinition: #TerniLapilli category: #'TerniLapilli-Ejercicio'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'fichasX fichasO next winner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!TerniLapilli methodsFor: 'access' stamp: 'NME 11/4/2018 20:34:01'!
fichasO
	^fichasO ! !

!TerniLapilli methodsFor: 'access' stamp: 'NME 11/4/2018 20:33:53'!
fichasX
	^fichasX ! !


!TerniLapilli methodsFor: 'initialization' stamp: 'NME 11/4/2018 21:44:46'!
initialize

	fichasX _ OrderedCollection new.
	fichasO _ OrderedCollection new.
	next _ #x! !


!TerniLapilli methodsFor: 'game moves' stamp: 'NME 11/4/2018 22:12:28'!
putOAt: aPosition

	next = #o ifFalse: [ self error: self class notOTurnErrorMessage ].
	(fichasO includes: aPosition) ifTrue: [self error: self class takenPositionErrorMessage].
	(fichasX includes: aPosition) ifTrue: [self error: self class takenPositionErrorMessage].
	fichasO add:aPosition.
	next _ #x.! !

!TerniLapilli methodsFor: 'game moves' stamp: 'NME 11/4/2018 22:07:08'!
putXAt: aPosition
	
	next = #x ifFalse: [ self error: self class notXTurnErrorMessage ].
	(fichasX includes: aPosition) ifTrue: [ self error: self class takenPositionErrorMessage ].
	(fichasO includes:aPosition) ifTrue: [self error: self class takenPositionErrorMessage].
	fichasX add: aPosition.
	next _ #o.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #'TerniLapilli-Ejercicio'!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'error messages' stamp: 'NME 11/4/2018 21:50:59'!
notOTurnErrorMessage
	
	^'Not O''s turn'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'NME 11/4/2018 21:04:52'!
notXTurnErrorMessage
	
	^'Not X''s turn'! !

!TerniLapilli class methodsFor: 'error messages' stamp: 'NME 11/4/2018 21:59:35'!
takenPositionErrorMessage
	
	^'Position Taken'! !
