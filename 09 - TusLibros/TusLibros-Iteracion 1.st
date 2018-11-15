!classDefinition: #CartTests category: #'TusLibros-Ejercicio'!
TestCase subclass: #CartTests
	instanceVariableNames: 'cart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!CartTests methodsFor: 'tests' stamp: 'nme 11/14/2018 20:39:36'!
test01NewCartIsEmpty
	
	self assert: cart isEmpty.
	
	
	! !

!CartTests methodsFor: 'tests' stamp: 'nme 11/14/2018 20:39:46'!
test02CanNotAddNonPositiveNumberOfItems

	|aBook catalogue |
	
	catalogue _ OrderedCollection new.
	catalogue add: 'Title2'.
	
	cart _ Cart initializeWithCatalogue:catalogue.
		
	aBook := 'Title'.
	
	self 
			should: [ cart add: -1 of: aBook ]
			raise: Error - MessageNotUnderstood 
			withExceptionDo: [ :anError |
				self assert: Cart invalidQuantityErrorMessage equals: anError messageText.
				self assert: cart isEmpty].
	
	! !

!CartTests methodsFor: 'tests' stamp: 'nme 11/14/2018 20:48:03'!
test03AfterAddingABookTheCartIsNotEmpty

	| aBook catalogue |
	
	catalogue _ OrderedCollection new.
	catalogue add: 'Title'.
	
	cart _ Cart initializeWithCatalogue:catalogue.
		
	aBook := 'Title'.
	cart add:aBook.
	
	self deny: cart isEmpty.
	self assert: cart size equals: 1.
	self assert: (cart includes: aBook).
	
	! !

!CartTests methodsFor: 'tests' stamp: 'nme 11/14/2018 20:48:15'!
test04AfterAddingABookTheQuantityIncrease

	| aBook catalogue |
	
	catalogue _ OrderedCollection new.
	catalogue add: 'Title'.
	
	cart _ Cart initializeWithCatalogue:catalogue.
		
	aBook := 'Title'.
	cart add:aBook.
	
	self deny: cart isEmpty.
	self assert: (cart quantityOf: aBook) equals: 1.
	self assert: (cart includes: aBook).
	
	! !

!CartTests methodsFor: 'tests' stamp: 'nme 11/14/2018 20:40:01'!
test05AfterAddingABookWhichIsAlreadyOnTheCartTheQuantityIncrease

	| aBook catalogue |
	
	catalogue _ OrderedCollection new.
	catalogue add: 'Title'.
	
	cart _ Cart initializeWithCatalogue:catalogue.
		
	aBook := 'Title'.
	cart add:1 of: aBook.
	cart add:2 of:aBook.
	
	self deny: cart isEmpty.
	self assert: (cart quantityOf: aBook) equals: 3.
	self assert: (cart includes: aBook).
	
	! !

!CartTests methodsFor: 'tests' stamp: 'nme 11/14/2018 20:40:06'!
test06CantAddABookWichIsntInCatalogue

	| aBook catalogue |
	
	catalogue _ OrderedCollection new.
	catalogue add: 'Title2'.
	
	cart _ Cart initializeWithCatalogue:catalogue.
		
	aBook := 'Title'.
	
	
	self 
			should: [ cart add:1 of:aBook ]
			raise: Error - MessageNotUnderstood 
			withExceptionDo: [ :anError |
				self assert: Cart notInCatalogueErrorMessage equals: anError messageText.
				self assert: cart isEmpty].
	
	! !

!CartTests methodsFor: 'tests' stamp: 'nme 11/14/2018 20:54:15'!
test07HaveNotMoreThanTheBooksAdded

	| catalogue |
	
	catalogue _ OrderedCollection new.
	catalogue add: 'Title'.
	catalogue add: 'Title2'.
	catalogue add:'Title3'.
	
	cart _ Cart initializeWithCatalogue:catalogue.
		
	
	cart add:'Title'.
	cart add:5 of: 'Title2'.
	cart add:2 of:'Title3'.
	
	self assert: cart totalBooks equals: 8.! !


!CartTests methodsFor: 'support' stamp: 'nme 11/14/2018 20:40:16'!
setUp
	
	cart _ Cart new.! !


!classDefinition: #Cart category: #'TusLibros-Ejercicio'!
Object subclass: #Cart
	instanceVariableNames: 'content catalogue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!Cart methodsFor: 'accessing' stamp: 'nme 11/14/2018 19:42:25'!
includes:aBook
	
	^content keys includes:aBook.! !

!Cart methodsFor: 'accessing' stamp: 'nme 11/12/2018 20:32:07'!
isEmpty
	
	^content isEmpty.! !

!Cart methodsFor: 'accessing' stamp: 'nme 11/14/2018 19:48:02'!
quantityOf:aBook
	
	^content at: aBook.! !

!Cart methodsFor: 'accessing' stamp: 'nme 11/12/2018 20:33:57'!
size

	^ content size.! !

!Cart methodsFor: 'accessing' stamp: 'nme 11/14/2018 21:01:31'!
totalBooks
	
	^content keys inject: 0 into: [:total :key| total + (content at:key)]. ! !


!Cart methodsFor: 'adding' stamp: 'nme 11/14/2018 20:47:28'!
add:aBook

	self add:1 of:aBook.! !

!Cart methodsFor: 'adding' stamp: 'nme 11/14/2018 20:34:05'!
add: aQuantity of:aBook

	aQuantity < 1 ifTrue: [self error: self class invalidQuantityErrorMessage ].
	(catalogue includes: aBook) ifFalse: [self error:self class notInCatalogueErrorMessage].
	
	content at: aBook ifPresent:
	[:oldQuantity|	content at:aBook put:oldQuantity +aQuantity	] 
	ifAbsent: [content at:aBook put:aQuantity].! !


!Cart methodsFor: 'initialization' stamp: 'nme 11/14/2018 19:38:16'!
initialize
	
	content _ Dictionary new.! !

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


!Cart class methodsFor: 'error messages' stamp: 'nme 11/14/2018 19:48:47'!
invalidQuantityErrorMessage
	'Negative Quantity'! !

!Cart class methodsFor: 'error messages' stamp: 'nme 11/12/2018 20:52:50'!
notInCatalogueErrorMessage
	^ 'The book is not available'.! !
