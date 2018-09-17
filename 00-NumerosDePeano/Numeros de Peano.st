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

!I class methodsFor: 'as yet unclassified' stamp: 'NME 9/17/2018 12:00:44'!
< unNumeroDePeano
	^ (unNumeroDePeano = I) not.! !

!I class methodsFor: 'as yet unclassified' stamp: 'ARM 9/6/2018 21:29:22'!
next

	^II! !


!I class methodsFor: 'Expresiones de error' stamp: 'NME 9/14/2018 18:52:13'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor

	^'No se puede dividir por un número mayor'! !

!I class methodsFor: 'Expresiones de error' stamp: 'NME 9/14/2018 18:12:45'!
descripcionDeErrorDeNumerosNegativosNoSoportados

^ 'Resultado Negativo - Los numeros de Peano no soportan números negativos'! !


!I class methodsFor: 'Operaciones' stamp: 'NME 9/17/2018 11:45:16'!
* unNumeroDePeano
	^unNumeroDePeano.! !

!I class methodsFor: 'Operaciones' stamp: 'NME 9/17/2018 11:45:30'!
+ unNumeroDePeano

	^unNumeroDePeano next! !

!I class methodsFor: 'Operaciones' stamp: 'NME 9/17/2018 11:45:39'!
- unNumeroDePeano

	self error: self descripcionDeErrorDeNumerosNegativosNoSoportados.! !

!I class methodsFor: 'Operaciones' stamp: 'NME 9/17/2018 11:45:55'!
/ unNumeroDePeano
	
	unNumeroDePeano = I ifTrue: [^I].
	self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor.! !

!I class methodsFor: 'Operaciones' stamp: 'NME 9/17/2018 11:46:03'!
unNumeroDePeanoMenosSelf: unNumeroDePeano

	 ^ unNumeroDePeano previous.! !


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

!II class methodsFor: 'as yet unclassified' stamp: 'NME 9/17/2018 11:44:30'!
< unNumeroDePeano
	(unNumeroDePeano = I) ifTrue: [^false].
	^(self previous < unNumeroDePeano previous).! !

!II class methodsFor: 'as yet unclassified' stamp: 'NME 9/17/2018 12:01:37'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	prev := I.! !

!II class methodsFor: 'as yet unclassified' stamp: 'NME 9/17/2018 11:48:08'!
next
	
	next ifNil:
	[
		next _ self cloneNamed: self name , 'I'.
		next previous: self.
	].
	^next! !

!II class methodsFor: 'as yet unclassified' stamp: 'NME 9/17/2018 11:48:32'!
previous

	^prev! !

!II class methodsFor: 'as yet unclassified' stamp: 'NME 9/17/2018 11:48:42'!
previous: unNumeroDePeano

	prev _ unNumeroDePeano! !


!II class methodsFor: 'Operaciones' stamp: 'NME 9/17/2018 11:46:17'!
* unNumeroDePeano 
	
	^(self previous * unNumeroDePeano) + unNumeroDePeano ! !

!II class methodsFor: 'Operaciones' stamp: 'NME 9/17/2018 11:46:30'!
+ unNumeroDePeano

	^self previous + unNumeroDePeano next! !

!II class methodsFor: 'Operaciones' stamp: 'NME 9/17/2018 11:46:39'!
- unNumeroDePeano

	^ unNumeroDePeano unNumeroDePeanoMenosSelf: self.! !

!II class methodsFor: 'Operaciones' stamp: 'NME 9/17/2018 11:47:46'!
/ unNumeroDePeano

	unNumeroDePeano = I ifTrue: [^self value].
	
	unNumeroDePeano = self value ifTrue: [^I].
	
	self value < unNumeroDePeano ifTrue: [self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor].
	
	^(self value - unNumeroDePeano / unNumeroDePeano) next.
	! !

!II class methodsFor: 'Operaciones' stamp: 'NME 9/17/2018 11:47:09'!
unNumeroDePeanoMenosSelf: unNumeroDePeano

	^ unNumeroDePeano previous - self previous.! !


!II class methodsFor: 'Expresiones de Error' stamp: 'NME 9/14/2018 19:46:17'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor

	^'No se puede dividir por un número mayor'! !


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

!III class methodsFor: 'as yet unclassified' stamp: 'NME 9/17/2018 11:59:52'!
< unNumeroDePeano
	(unNumeroDePeano = I) ifTrue: [^false].
	^(self previous < unNumeroDePeano previous).! !

!III class methodsFor: 'as yet unclassified' stamp: 'NME 9/17/2018 12:01:37'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	prev := II.! !

!III class methodsFor: 'as yet unclassified' stamp: 'NME 9/17/2018 11:59:52'!
next
	
	next ifNil:
	[
		next _ self cloneNamed: self name , 'I'.
		next previous: self.
	].
	^next! !

!III class methodsFor: 'as yet unclassified' stamp: 'NME 9/17/2018 11:59:52'!
previous

	^prev! !

!III class methodsFor: 'as yet unclassified' stamp: 'NME 9/17/2018 11:59:52'!
previous: unNumeroDePeano

	prev _ unNumeroDePeano! !


!III class methodsFor: 'Operaciones' stamp: 'NME 9/17/2018 11:59:52'!
* unNumeroDePeano 
	
	^(self previous * unNumeroDePeano) + unNumeroDePeano ! !

!III class methodsFor: 'Operaciones' stamp: 'NME 9/17/2018 11:59:52'!
+ unNumeroDePeano

	^self previous + unNumeroDePeano next! !

!III class methodsFor: 'Operaciones' stamp: 'NME 9/17/2018 11:59:52'!
- unNumeroDePeano

	^ unNumeroDePeano unNumeroDePeanoMenosSelf: self.! !

!III class methodsFor: 'Operaciones' stamp: 'NME 9/17/2018 11:59:52'!
/ unNumeroDePeano

	unNumeroDePeano = I ifTrue: [^self value].
	
	unNumeroDePeano = self value ifTrue: [^I].
	
	self value < unNumeroDePeano ifTrue: [self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor].
	
	^(self value - unNumeroDePeano / unNumeroDePeano) next.
	! !

!III class methodsFor: 'Operaciones' stamp: 'NME 9/17/2018 11:59:52'!
unNumeroDePeanoMenosSelf: unNumeroDePeano

	^ unNumeroDePeano previous - self previous.! !


!III class methodsFor: 'Expresiones de Error' stamp: 'NME 9/17/2018 11:59:52'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor

	^'No se puede dividir por un número mayor'! !


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

!IIII class methodsFor: 'as yet unclassified' stamp: 'NME 9/17/2018 11:59:53'!
< unNumeroDePeano
	(unNumeroDePeano = I) ifTrue: [^false].
	^(self previous < unNumeroDePeano previous).! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'NME 9/17/2018 12:01:37'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	prev := III.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'NME 9/17/2018 11:59:53'!
next
	
	next ifNil:
	[
		next _ self cloneNamed: self name , 'I'.
		next previous: self.
	].
	^next! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'NME 9/17/2018 11:59:53'!
previous

	^prev! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'NME 9/17/2018 11:59:53'!
previous: unNumeroDePeano

	prev _ unNumeroDePeano! !


!IIII class methodsFor: 'Operaciones' stamp: 'NME 9/17/2018 11:59:53'!
* unNumeroDePeano 
	
	^(self previous * unNumeroDePeano) + unNumeroDePeano ! !

!IIII class methodsFor: 'Operaciones' stamp: 'NME 9/17/2018 11:59:53'!
+ unNumeroDePeano

	^self previous + unNumeroDePeano next! !

!IIII class methodsFor: 'Operaciones' stamp: 'NME 9/17/2018 11:59:53'!
- unNumeroDePeano

	^ unNumeroDePeano unNumeroDePeanoMenosSelf: self.! !

!IIII class methodsFor: 'Operaciones' stamp: 'NME 9/17/2018 11:59:53'!
/ unNumeroDePeano

	unNumeroDePeano = I ifTrue: [^self value].
	
	unNumeroDePeano = self value ifTrue: [^I].
	
	self value < unNumeroDePeano ifTrue: [self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor].
	
	^(self value - unNumeroDePeano / unNumeroDePeano) next.
	! !

!IIII class methodsFor: 'Operaciones' stamp: 'NME 9/17/2018 11:59:53'!
unNumeroDePeanoMenosSelf: unNumeroDePeano

	^ unNumeroDePeano previous - self previous.! !


!IIII class methodsFor: 'Expresiones de Error' stamp: 'NME 9/17/2018 11:59:53'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor

	^'No se puede dividir por un número mayor'! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!