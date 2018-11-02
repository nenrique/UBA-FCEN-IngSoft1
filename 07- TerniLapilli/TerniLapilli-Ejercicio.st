!classDefinition: #TerniLapilliTests category: #'TerniLapilli-Ejercicio'!
TestCase subclass: #TerniLapilliTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'nme 11/1/2018 20:00:14'!
test01CreateNewGameWithEmptyBoard

	|juego tablero|
	
	tablero _ OrderedCollection new.

	juego := TerniLapilli with: tablero.
	
	self assert: juego board isEmpty.! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'nme 11/1/2018 20:56:40'!
test02StartGameWithPlayers

	|juego tablero|
	
	tablero _ OrderedCollection new.

	juego := TerniLapilli with: tablero.
	juego startGame.
	
	self assert: (juego x) name equals: 'X'.
	self assert: (juego o) name equals: 'O'.
	self assert: juego fichasX equals: 3.
	self assert:juego fichasO  equals: 3.
	! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'nme 11/1/2018 20:20:06'!
test03XFirstMove

	|juego tablero|
	
	tablero _ OrderedCollection new.

	juego := TerniLapilli with: tablero.
	juego startGame.
	
	
	self assert: juego nextMove equals: 'X'.! !

!TerniLapilliTests methodsFor: 'as yet unclassified' stamp: 'nme 11/1/2018 20:50:23'!
test04PlayerPutAPieceOnBoard

	|juego tablero|
	
	tablero _ OrderedCollection new.

	juego := TerniLapilli with: tablero.
	juego startGame.
	
	
	
	self assert: juego nextMove equals: 'X'.! !


!classDefinition: #Player category: #'TerniLapilli-Ejercicio'!
Object subclass: #Player
	instanceVariableNames: 'name fichas'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!Player methodsFor: 'as yet unclassified' stamp: 'nme 11/1/2018 20:42:20'!
initializeWith:aFigure with:anAmountOfPieces

	name _ aFigure .
	fichas _ anAmountOfPieces.! !

!Player methodsFor: 'as yet unclassified' stamp: 'nme 11/1/2018 20:42:34'!
name

	^ name! !

!Player methodsFor: 'as yet unclassified' stamp: 'nme 11/1/2018 20:44:49'!
pieces

	^fichas! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Player class' category: #'TerniLapilli-Ejercicio'!
Player class
	instanceVariableNames: ''!

!Player class methodsFor: 'as yet unclassified' stamp: 'nme 11/1/2018 20:45:49'!
name:aFigure pieces:anAmountOfPieces

	^ self new initializeWith:aFigure with:anAmountOfPieces.! !


!classDefinition: #TerniLapilli category: #'TerniLapilli-Ejercicio'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'board x o next'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!TerniLapilli methodsFor: 'access' stamp: 'nme 11/1/2018 19:59:11'!
board
	^board! !

!TerniLapilli methodsFor: 'access' stamp: 'nme 11/1/2018 20:44:30'!
fichasO
	^o pieces! !

!TerniLapilli methodsFor: 'access' stamp: 'nme 11/1/2018 20:44:16'!
fichasX
	^x pieces! !

!TerniLapilli methodsFor: 'access' stamp: 'nme 11/1/2018 20:55:57'!
nextMove

	^next! !

!TerniLapilli methodsFor: 'access' stamp: 'nme 11/1/2018 20:55:25'!
o
	^o! !

!TerniLapilli methodsFor: 'access' stamp: 'nme 11/1/2018 20:55:19'!
x
	^x! !


!TerniLapilli methodsFor: 'initialization' stamp: 'nme 11/1/2018 20:15:04'!
initializeWith: aBoard

	board _ aBoard.! !

!TerniLapilli methodsFor: 'initialization' stamp: 'nme 11/1/2018 20:47:34'!
startGame

	x _ Player name: 'X' pieces: 3.
	o _ Player name: 'O' pieces: 3.
	next _ x.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #'TerniLapilli-Ejercicio'!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'initialization' stamp: 'nme 11/1/2018 20:00:01'!
with: aBoard

	^ self new initializeWith:aBoard! !
