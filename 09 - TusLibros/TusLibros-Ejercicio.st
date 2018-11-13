!classDefinition: #CartTests category: #'TusLibros-Ejercicio'!
TestCase subclass: #CartTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!CartTests methodsFor: 'as yet unclassified' stamp: 'nme 11/12/2018 20:21:09'!
test01NewCartIsEmpty

	|carrito|
	
	carrito _ Cart new.
	
	self assert: carrito isEmpty.
	
	
	! !

!CartTests methodsFor: 'as yet unclassified' stamp: 'nme 11/12/2018 21:15:14'!
test03CantAddABookWichIsntInCatalogue

	|cart aBook catalogue |
	
	catalogue _ OrderedCollection new.
	catalogue add: 'Title2'.
	
	cart _ Cart initializeWithCatalogue:catalogue.
		
	aBook := 'Title'.
	
	
	self 
			should: [ cart add:aBook ]
			raise: Error - MessageNotUnderstood 
			withExceptionDo: [ :anError |
				self assert: Cart notInCatalogueErrorMessage equals: anError messageText.
				self assert: cart isEmpty].
	
	! !

!CartTests methodsFor: 'as yet unclassified' stamp: 'nme 11/12/2018 21:13:59'!
test04CanAddABookWichIsInCatalogue

	|cart aBook catalogue |
	
	catalogue _ OrderedCollection new.
	catalogue add: 'Title'.
	
	cart _ Cart initializeWithCatalogue:catalogue.
		
	aBook := 'Title'.
	cart add:aBook .
	
	self deny: cart isEmpty.
	self assert: cart size equals: 1.
	self assert: (cart includes: aBook).
	
	! !


!classDefinition: #Cart category: #'TusLibros-Ejercicio'!
Object subclass: #Cart
	instanceVariableNames: 'content catalogue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!Cart methodsFor: 'accessing' stamp: 'nme 11/12/2018 20:34:46'!
includes:aBook
	
	^content includes: aBook.! !

!Cart methodsFor: 'accessing' stamp: 'nme 11/12/2018 20:32:07'!
isEmpty
	
	^content isEmpty.! !

!Cart methodsFor: 'accessing' stamp: 'nme 11/12/2018 20:33:57'!
size

	^ content size.! !


!Cart methodsFor: 'adding' stamp: 'nme 11/12/2018 20:59:18'!
add: aBook
	
	(catalogue includes: aBook) ifFalse: [self error:self class notInCatalogueErrorMessage].
	content add: aBook.! !


!Cart methodsFor: 'initialization' stamp: 'nme 11/12/2018 20:33:38'!
initialize
	
	content _ OrderedCollection new.! !

!Cart methodsFor: 'initialization' stamp: 'nme 11/12/2018 20:47:36'!
initializeWith: aCatalogue
	catalogue _ aCatalogue.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #'TusLibros-Ejercicio'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'initialization' stamp: 'nme 11/12/2018 20:46:51'!
initializeWithCatalogue: aCatalogue
	
	^self new initializeWith:aCatalogue.! !


!Cart class methodsFor: 'error messages' stamp: 'nme 11/12/2018 20:52:50'!
notInCatalogueErrorMessage
	^ 'The book is not available'.! !
