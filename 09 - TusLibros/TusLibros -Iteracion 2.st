!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 0 of: self itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSellByTheStore.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !


!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
defaultCatalog
	
	^ Array with: self itemSellByTheStore! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: 'cashier'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'as yet unclassified' stamp: 'nme 11/15/2018 18:51:33'!
anItem

	^'anItemInTheCart'! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'nme 11/15/2018 18:54:31'!
anotherItem

	^'anotherItemInTheCart'! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'nme 11/15/2018 19:18:01'!
defaultCatalog
	
	^ Array with: self anItem with:self anotherItem.! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'nme 11/15/2018 19:03:48'!
listPrices

	|list|
	
	list _ Dictionary new.
	
	list at: self anItem  put: 5.
	list at:  self anotherItem put: 10.
	
	^list ! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'nme 11/15/2018 18:44:42'!
test01SholdNotAcceptAnEmptyCart

	|aCart aCashier|
	aCart _ Cart new.
	aCashier _ Cashier doCheckoutOf: aCart.
	
	self 
		should: [ aCashier doCheckOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals:  Cashier emptyCartErrorMessage].
	! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'nme 11/15/2018 19:02:43'!
test02TotalFromAnElementCheckedOutIsThePriceInTheListsPrices

	|aCart aCashier|
	aCart _ Cart acceptingItemsOf: self defaultCatalog.
	aCart add: 1 of: self anItem.
	
	aCashier _ Cashier doCheckoutOf: aCart with: self listPrices.
	
	self assert: aCashier totalCheckOut equals: (aCashier priceOfItem: self anItem).
	! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'nme 11/15/2018 19:45:57'!
test03TotalFromMoreThanAnElementCheckedOutIsTheSumOfThePrices

	|aCart aCashier|
	aCart _ Cart acceptingItemsOf: self defaultCatalog.
	aCart add: 1 of: self anItem.
	aCart  add: 1 of: self anotherItem.
	
	aCashier _ Cashier doCheckoutOf: aCart with: self listPrices.
	
	self assert: aCashier totalCheckOut equals: ((self listPrices at: self anItem) +( self listPrices at: self anotherItem)).
	! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'nme 11/15/2018 19:59:34'!
test04CanNotCheckOutAnItemThatIsNotInThePriceList

	|aCart aCashier|
	aCart _ Cart acceptingItemsOf: self defaultCatalog.
	aCart add: 1 of: self anItem.
	aCart  add: 1 of: self anItemWithoutPrice.
	
	aCashier _ Cashier doCheckoutOf: aCart with: self listPrices.
	
	self assert: aCashier totalCheckOut equals: ((self listPrices at: self anItem) +( self listPrices at: self anotherItem)).
	! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidItem: anItem

	(catalog includes: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'nme 11/15/2018 19:24:25'!
items

	^items ! !

!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'cart prices total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'initialization' stamp: 'nme 11/15/2018 18:37:42'!
initializeWith: aCart 
	
	cart _ aCart .! !

!Cashier methodsFor: 'initialization' stamp: 'nme 11/15/2018 19:06:13'!
initializeWith: aCart and: aListOfPrices
	cart _ aCart .
	prices _ aListOfPrices! !


!Cashier methodsFor: 'checkingOut' stamp: 'nme 11/15/2018 18:39:55'!
doCheckOut
	^self error:self class emptyCartErrorMessage ! !

!Cashier methodsFor: 'checkingOut' stamp: 'nme 11/15/2018 19:46:30'!
priceOfItem: anItem
	^prices at: anItem! !

!Cashier methodsFor: 'checkingOut' stamp: 'nme 11/15/2018 19:24:35'!
totalCheckOut
	
	^ cart items inject: 0 into:[:total :item| total+ (prices at:item)]. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'initialization' stamp: 'nme 11/15/2018 18:37:15'!
doCheckoutOf: aCart 
	^self new initializeWith: aCart .! !

!Cashier class methodsFor: 'initialization' stamp: 'nme 11/15/2018 19:05:29'!
doCheckoutOf: aCart with: aListOfPrices
	^self new initializeWith:aCart and: aListOfPrices.! !


!Cashier class methodsFor: 'error messages' stamp: 'nme 11/15/2018 18:40:43'!
emptyCartErrorMessage
	^'The cart is Empty'! !
