!classDefinition: #I category: #'Numeros de Peano'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros de Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: #'Numeros de Peano'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'as yet unclassified' stamp: 'ARM 9/6/2018 21:44:20'!
+ unNumeroDePeano

	^unNumeroDePeano next! !

!I class methodsFor: 'as yet unclassified' stamp: 'ARM 9/6/2018 22:03:11'!
- unNumeroDePeano

	self error: 'No se puede restar un numero menor a un numero mayor o igual'! !

!I class methodsFor: 'as yet unclassified' stamp: 'ARM 9/6/2018 21:29:22'!
next

	^II! !


!I class methodsFor: 'Multiplicacion' stamp: 'NME 9/13/2018 12:38:01'!
* unNumeroDePeano

	^unNumeroDePeano.! !


!classDefinition: #II category: #'Numeros de Peano'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros de Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: #'Numeros de Peano'!
II class
	instanceVariableNames: 'next prev'!

!II class methodsFor: 'as yet unclassified' stamp: 'NME 9/13/2018 12:51:19'!
+ unNumeroDePeano

	^self previous + unNumeroDePeano next! !

!II class methodsFor: 'as yet unclassified' stamp: 'NME 9/13/2018 12:51:35'!
- unNumeroDePeano

	unNumeroDePeano = I ifTrue: [^self previous].

	^self previous - unNumeroDePeano previous! !

!II class methodsFor: 'as yet unclassified' stamp: 'NME 9/14/2018 17:00:19'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	prev := I.! !

!II class methodsFor: 'as yet unclassified' stamp: 'NME 9/13/2018 12:53:01'!
next
	
	next ifNil:
	[
		next _ self cloneNamed: self name , 'I'.
		next previous: self.
	].
	^next! !

!II class methodsFor: 'as yet unclassified' stamp: 'NME 9/13/2018 12:50:49'!
previous

	^prev! !

!II class methodsFor: 'as yet unclassified' stamp: 'NME 9/13/2018 12:52:30'!
previous: unNumeroDePeano

	prev _ unNumeroDePeano! !


!II class methodsFor: 'Multipliacion' stamp: 'NME 9/13/2018 12:51:08'!
* unNumeroDePeano 
	
	^(self previous * unNumeroDePeano) + unNumeroDePeano ! !

II initializeAfterFileIn!