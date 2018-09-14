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

!I class methodsFor: 'as yet unclassified' stamp: 'ARM 9/6/2018 21:29:22'!
next

	^II! !


!I class methodsFor: 'Expresiones de error' stamp: 'NME 9/14/2018 18:12:45'!
descripcionDeErrorDeNumerosNegativosNoSoportados

^ 'Resultado Negativo - Los numeros de Peano no soportan números negativos'! !


!I class methodsFor: 'Operaciones' stamp: 'NME 9/13/2018 12:38:01'!
* unNumeroDePeano

	^unNumeroDePeano.! !

!I class methodsFor: 'Operaciones' stamp: 'ARM 9/6/2018 21:44:20'!
+ unNumeroDePeano

	^unNumeroDePeano next! !

!I class methodsFor: 'Operaciones' stamp: 'NME 9/14/2018 18:11:05'!
- unNumeroDePeano

	self error: self descripcionDeErrorDeNumerosNegativosNoSoportados.! !


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

!II class methodsFor: 'as yet unclassified' stamp: 'NME 9/14/2018 18:31:01'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
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



!II class methodsFor: 'Operaciones' stamp: 'NME 9/13/2018 12:51:08'!
* unNumeroDePeano 
	
	^(self previous * unNumeroDePeano) + unNumeroDePeano ! !

!II class methodsFor: 'Operaciones' stamp: 'NME 9/13/2018 12:51:19'!
+ unNumeroDePeano

	^self previous + unNumeroDePeano next! !

!II class methodsFor: 'Operaciones' stamp: 'NME 9/14/2018 18:24:40'!
- unNumeroDePeano

	unNumeroDePeano = I ifTrue: [^self previous].
	
	^self previous - unNumeroDePeano previous.! !


!classDefinition: #III category: #'Numeros de Peano'!
DenotativeObject subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros de Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: #'Numeros de Peano'!
III class
	instanceVariableNames: 'next prev'!

!III class methodsFor: 'as yet unclassified' stamp: 'NME 9/14/2018 18:31:01'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	prev := II.! !

!III class methodsFor: 'as yet unclassified' stamp: 'NME 9/14/2018 18:30:17'!
next
	
	next ifNil:
	[
		next _ self cloneNamed: self name , 'I'.
		next previous: self.
	].
	^next! !

!III class methodsFor: 'as yet unclassified' stamp: 'NME 9/14/2018 18:30:17'!
previous

	^prev! !

!III class methodsFor: 'as yet unclassified' stamp: 'NME 9/14/2018 18:30:17'!
previous: unNumeroDePeano

	prev _ unNumeroDePeano! !


!III class methodsFor: 'Operaciones' stamp: 'NME 9/14/2018 18:30:17'!
* unNumeroDePeano 
	
	^(self previous * unNumeroDePeano) + unNumeroDePeano ! !

!III class methodsFor: 'Operaciones' stamp: 'NME 9/14/2018 18:30:17'!
+ unNumeroDePeano

	^self previous + unNumeroDePeano next! !

!III class methodsFor: 'Operaciones' stamp: 'NME 9/14/2018 18:30:17'!
- unNumeroDePeano

	unNumeroDePeano = I ifTrue: [^self previous].
	
	^self previous - unNumeroDePeano previous.! !


!classDefinition: #IIII category: #'Numeros de Peano'!
DenotativeObject subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros de Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: #'Numeros de Peano'!
IIII class
	instanceVariableNames: 'next prev'!

!IIII class methodsFor: 'as yet unclassified' stamp: 'NME 9/14/2018 18:31:01'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	prev := III.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'NME 9/14/2018 18:30:37'!
next
	
	next ifNil:
	[
		next _ self cloneNamed: self name , 'I'.
		next previous: self.
	].
	^next! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'NME 9/14/2018 18:30:37'!
previous

	^prev! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'NME 9/14/2018 18:30:37'!
previous: unNumeroDePeano

	prev _ unNumeroDePeano! !


!IIII class methodsFor: 'Operaciones' stamp: 'NME 9/14/2018 18:30:37'!
* unNumeroDePeano 
	
	^(self previous * unNumeroDePeano) + unNumeroDePeano ! !

!IIII class methodsFor: 'Operaciones' stamp: 'NME 9/14/2018 18:30:37'!
+ unNumeroDePeano

	^self previous + unNumeroDePeano next! !

!IIII class methodsFor: 'Operaciones' stamp: 'NME 9/14/2018 18:30:37'!
- unNumeroDePeano

	unNumeroDePeano = I ifTrue: [^self previous].
	
	^self previous - unNumeroDePeano previous.! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!