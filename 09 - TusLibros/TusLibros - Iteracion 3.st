!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'NME 12/3/2018 00:37:29'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook
			withClient: 'cliente']
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'NME 12/3/2018 00:39:09'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new
		withClient:'cliente'.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'NME 12/3/2018 00:39:23'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook
				withClient: 'cliente'  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'NME 12/3/2018 00:40:04'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook
		
		withClient: 'client'.
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'NME 12/3/2018 00:40:30'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook
		withClient: 'cliente'.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'NME 12/3/2018 00:40:51'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook
		
		withClient: 'cliente'.
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #RestInterfaceTests category: #TusLibros!
TestCase subclass: #RestInterfaceTests
	instanceVariableNames: 'testObjectsFactory interfaz users clock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestInterfaceTests methodsFor: 'testing' stamp: 'LR 12/3/2018 02:59:04'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	users _ Dictionary new.
	users at: 0 put: 'contraseña'.
	
	clock _ Clock new initialize.
	
	interfaz :=  RestInterface initializeWithUsers: users andCatalog: testObjectsFactory defaultCatalog withMerchantProcessor: self withSalesBook: OrderedCollection new withTimer: clock.! !

!RestInterfaceTests methodsFor: 'testing' stamp: 'LR 12/3/2018 08:31:38'!
test01CreateCartWithValidUserAndPassword
 	
	| carritoId |
	
	carritoId _ (interfaz createCartwithUID: 0 andPassword: 'contraseña').
	self assert: (interfaz listCart: carritoId) isEmpty.
! !

!RestInterfaceTests methodsFor: 'testing' stamp: 'LR 12/3/2018 05:58:53'!
test02CantCreateCartWithInvalidPassword
 	
	self 
		should: [ (interfaz createCartwithUID: 0 andPassword: 'password'). ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = RestInterface invalidPasswordErrorMessage.
			].! !

!RestInterfaceTests methodsFor: 'testing' stamp: 'LR 12/3/2018 07:11:06'!
test03CantCreateCartWithInvalidUserId
 	
	
	self
		should: [ (interfaz createCartwithUID: 1 andPassword: 'password'). ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = RestInterface invalidUserIdErrorMessage.
			].! !

!RestInterfaceTests methodsFor: 'testing' stamp: 'NME 12/2/2018 20:42:56'!
test04CanAddAnItemToACart
 	
	
	|carritoId|
	
	carritoId _ (interfaz createCartwithUID: 0 andPassword: 'contraseña').
	
	self shouldnt: [ interfaz addToCart: carritoId aQuantityOf: 1 item: testObjectsFactory itemSellByTheStore] raise: Error! !

!RestInterfaceTests methodsFor: 'testing' stamp: 'NME 12/2/2018 21:42:05'!
test05CantAddAnItemToACartWithInvalidId	
	
	self should: [ interfaz addToCart: 5 aQuantityOf: 1 item:testObjectsFactory itemSellByTheStore ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | self assert: (anError messageText = RestInterface  invalidCartIdErrorMessage )]! !

!RestInterfaceTests methodsFor: 'testing' stamp: 'NME 12/2/2018 21:42:33'!
test06CantAddAnInvalidNumberOfItemsIntoTheCart

 	| carritoId users  |
	
	users _ Dictionary new.
	users at: 0 put: 'contraseña'.
	
	carritoId _ (interfaz createCartwithUID: 0 andPassword: 'contraseña').
	
	self should: [ interfaz addToCart: carritoId aQuantityOf: 0 item: testObjectsFactory itemSellByTheStore. ]
		  raise: Error - MessageNotUnderstood
		  withExceptionDo: [ :anError | self assert: anError messageText = RestInterface invalidQuantityErrorMessage .].

	! !

!RestInterfaceTests methodsFor: 'testing' stamp: 'NME 12/2/2018 21:56:03'!
test07AddAnItemWhichDoesntExistInCatalogRaiseAnError

 	| carritoId users  |
	
	users _ Dictionary new.
	users at: 0 put: 'contraseña'.
	carritoId _ (interfaz createCartwithUID: 0 andPassword: 'contraseña').
	
	self should: [ interfaz addToCart: carritoId aQuantityOf: 1 item: testObjectsFactory itemNotSellByTheStore.]
		  raise: Error - MessageNotUnderstood
		  withExceptionDo: [ :anError | self assert: anError messageText = RestInterface invalidItemErrorMessage .].

	! !

!RestInterfaceTests methodsFor: 'testing' stamp: 'NME 12/2/2018 22:09:44'!
test08ListCartFromAnEmptyCartIsEmpty
 	| carritoId |
	
	carritoId _ (interfaz createCartwithUID: 0 andPassword: 'contraseña').
	
	self assert: (interfaz listCart: carritoId) isEmpty.! !

!RestInterfaceTests methodsFor: 'testing' stamp: 'NME 12/3/2018 02:27:03'!
test09CantListItemsWithWrongId

	self should: [ interfaz listCart: 40. ]
		  raise: Error - MessageNotUnderstood
		  withExceptionDo: [ :anError | self assert: anError messageText = RestInterface invalidCartIdErrorMessage . ].! !

!RestInterfaceTests methodsFor: 'testing' stamp: 'NME 12/2/2018 22:17:42'!
test10ListCartItemsFromAValidIDShowItems

 	| carritoId listCart expectedListCart|
	
	carritoId _ (interfaz createCartwithUID: 0 andPassword: 'contraseña').
	interfaz addToCart: carritoId aQuantityOf: 3 item: testObjectsFactory itemSellByTheStore .
	
	listCart _ interfaz listCart: carritoId.
	expectedListCart _ OrderedCollection with: testObjectsFactory itemSellByTheStore with: testObjectsFactory itemSellByTheStore with:testObjectsFactory itemSellByTheStore .
	
	self assert: listCart equals: expectedListCart.
	self assert: listCart size = 3.! !

!RestInterfaceTests methodsFor: 'testing' stamp: 'NME 12/3/2018 01:13:36'!
test11CanCheckOutACart

 	| carritoId  |
	carritoId _ (interfaz createCartwithUID: 0 andPassword: 'contraseña').
	interfaz addToCart: carritoId aQuantityOf: 1 item: testObjectsFactory itemSellByTheStore.
	
	self shouldnt: [interfaz checkoutCart: carritoId withCreditCard: testObjectsFactory notExpiredCreditCard withExpirationDate: testObjectsFactory creditCardNotExpirationDate andName: 'name'.]
	raise: Error! !

!RestInterfaceTests methodsFor: 'testing' stamp: 'NME 12/3/2018 01:28:02'!
test12CantCheckOutAnEmpyCart

 	| carritoId  |
	carritoId _ (interfaz createCartwithUID: 0 andPassword: 'contraseña').

	
	self should: [ interfaz checkoutCart: carritoId withCreditCard: testObjectsFactory notExpiredCreditCard withExpirationDate: testObjectsFactory creditCardNotExpirationDate andName: 'name'.]
		  raise: Error - MessageNotUnderstood
		  withExceptionDo: [ :anError | self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage].
! !

!RestInterfaceTests methodsFor: 'testing' stamp: 'LR 12/3/2018 05:58:43'!
test13CantCheckOutWithAnExpiredCreditCard
 	| carritoId  |
	carritoId _ (interfaz createCartwithUID: 0 andPassword: 'contraseña').
	interfaz addToCart: carritoId aQuantityOf: 1 item: testObjectsFactory itemSellByTheStore.

	
	self should: [ interfaz checkoutCart: carritoId withCreditCard: testObjectsFactory expiredCreditCard withExpirationDate: testObjectsFactory expiredDate andName: 'name'.]
		  raise: Error - MessageNotUnderstood
		  withExceptionDo: [ :anError | self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage].
! !

!RestInterfaceTests methodsFor: 'testing' stamp: 'LR 12/3/2018 07:10:03'!
test14ListPurchasesWhenValidIdAndPassword

 	| carritoId purchases |
	carritoId _ (interfaz createCartwithUID: 0 andPassword: 'contraseña').
	interfaz addToCart: carritoId aQuantityOf: 1 item: testObjectsFactory itemSellByTheStore.
	
	interfaz checkoutCart: carritoId withCreditCard: testObjectsFactory notExpiredCreditCard withExpirationDate: testObjectsFactory creditCardNotExpirationDate andName: 'name'.

	purchases _ interfaz listPurchasesFrom: 0 withPassword: 'contraseña'.

	self assert: (purchases size) = 1.
	self assert: purchases amount = (testObjectsFactory itemSellByTheStorePrice).
	self assert: (purchases includes: (testObjectsFactory itemSellByTheStore)).! !

!RestInterfaceTests methodsFor: 'testing' stamp: 'LR 12/3/2018 07:11:13'!
test15CantListPurchasesWithInvalidUserID

 	| carritoId |
	carritoId _ (interfaz createCartwithUID: 0 andPassword: 'contraseña').
	interfaz addToCart: carritoId aQuantityOf: 1 item: testObjectsFactory itemSellByTheStore.
	
	interfaz checkoutCart: carritoId withCreditCard: testObjectsFactory notExpiredCreditCard withExpirationDate: testObjectsFactory creditCardNotExpirationDate andName: 'name'.


	self 
		should: [ (interfaz listPurchasesFrom: 1 withPassword: 'contraseña'). ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = RestInterface invalidUserIdErrorMessage.
			].! !

!RestInterfaceTests methodsFor: 'testing' stamp: 'LR 12/3/2018 08:16:58'!
test16CantListPurchasesWithInvalidPassword

 	| carritoId |
	carritoId _ (interfaz createCartwithUID: 0 andPassword: 'contraseña').
	interfaz addToCart: carritoId aQuantityOf: 1 item: testObjectsFactory itemSellByTheStore.
	
	interfaz checkoutCart: carritoId withCreditCard: testObjectsFactory notExpiredCreditCard withExpirationDate: testObjectsFactory creditCardNotExpirationDate andName: 'name'.

	self 
		should: [ (interfaz listPurchasesFrom: 0 withPassword: 'password'). ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = RestInterface invalidPasswordErrorMessage.
			].! !

!RestInterfaceTests methodsFor: 'testing' stamp: 'LR 12/3/2018 08:31:56'!
test17CantAddItemsToCartAfterMoreThan30MinutesHavePassed

 	| carritoId  |
	carritoId _ (interfaz createCartwithUID: 0 andPassword: 'contraseña').
	clock advance: 31 minutes.
	
	self
		should: [interfaz addToCart: carritoId aQuantityOf: 3 item: testObjectsFactory itemSellByTheStore .] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | self assert: (anError messageText = RestInterface  moreThan30MinutesErrorMessage )]! !

!RestInterfaceTests methodsFor: 'testing' stamp: 'LR 12/3/2018 08:32:04'!
test18CantListCartItemsAfterMoreThan30MinutesHavePassed

 	| carritoId  |
	carritoId _ (interfaz createCartwithUID: 0 andPassword: 'contraseña').
	interfaz addToCart: carritoId aQuantityOf: 3 item: testObjectsFactory itemSellByTheStore .
	clock advance: 31 minutes.
	
	self
		should: [interfaz listCart: carritoId] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | self assert: (anError messageText = RestInterface  moreThan30MinutesErrorMessage )]! !

!RestInterfaceTests methodsFor: 'testing' stamp: 'LR 12/3/2018 08:32:11'!
test19CantCheckoutACartAfterMoreThan30MinutesHavePassed

 	
 	| carritoId  |
	carritoId _ (interfaz createCartwithUID: 0 andPassword: 'contraseña').
	interfaz addToCart: carritoId aQuantityOf: 3 item: testObjectsFactory itemSellByTheStore .
	clock advance: 31 minutes.
	
	self
		should: [interfaz checkoutCart: carritoId withCreditCard: testObjectsFactory notExpiredCreditCard withExpirationDate: testObjectsFactory creditCardNotExpirationDate andName: 'name'.] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | self assert: (anError messageText = RestInterface  moreThan30MinutesErrorMessage )]! !


!RestInterfaceTests methodsFor: 'merchant processor' stamp: 'NME 12/3/2018 01:21:07'!
debit: anAmout from: aCreditCard! !


!classDefinition: #Ticket category: #TusLibros!
TestCase subclass: #Ticket
	instanceVariableNames: 'items totalAmount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Ticket methodsFor: 'operations' stamp: 'LR 12/3/2018 05:30:07'!
amount
	^ totalAmount.! !

!Ticket methodsFor: 'operations' stamp: 'LR 12/3/2018 05:35:37'!
includes: item
	^ items includes: item.! !

!Ticket methodsFor: 'operations' stamp: 'LR 12/3/2018 05:26:13'!
size
	^ items size.! !


!Ticket methodsFor: 'initialization' stamp: 'LR 12/3/2018 05:29:53'!
initializeWithItems: purchasedItems andAmount: amount
	items _ purchasedItems.
	totalAmount _ amount.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Ticket class' category: #TusLibros!
Ticket class
	instanceVariableNames: ''!

!Ticket class methodsFor: 'initialization' stamp: 'LR 12/3/2018 05:33:29'!
withItems: purchasedItems andAmount: amount 
	^ self new initializeWithItems: purchasedItems andAmount: amount! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog items startTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'LR 11/26/2018 20:59:38'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'LR 11/26/2018 19:01:26'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'LR 12/3/2018 05:09:40'!
items
	^ items! !

!Cart methodsFor: 'queries' stamp: 'LR 12/3/2018 05:09:49'!
occurrencesOf: anItem
	^ items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


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


!classDefinition: #CartSession category: #TusLibros!
Object subclass: #CartSession
	instanceVariableNames: 'timeout lastTimeSession'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartSession methodsFor: 'initialization' stamp: 'NME 12/3/2018 02:13:18'!
initializeWithTimeout: aTimeOut andInitialTime: anInitialTime

	timeout _ aTimeOut .
	lastTimeSession _ anInitialTime ! !


!CartSession methodsFor: 'Expired Session' stamp: 'NME 12/3/2018 02:15:57'!
hasExpiredOn: aTime

	^aTime > (timeout + lastTimeSession)

	! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total client'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:07'!
createSale

	^ Sale of: total
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

!Cashier methodsFor: 'initialization' stamp: 'NME 12/3/2018 00:35:37'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook withClient: aClient
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook.
	client := aClient.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'nme 11/22/2018 20:31:34'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !

!Cashier class methodsFor: 'instance creation' stamp: 'NME 12/3/2018 00:38:19'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook withClient:aClient
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook withClient:aClient.! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #Clock category: #TusLibros!
Object subclass: #Clock
	instanceVariableNames: 'time'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Clock methodsFor: 'modifications' stamp: 'NME 12/3/2018 01:49:21'!
advance: anAmountOfTime

	time := time + anAmountOfTime ! !


!Clock methodsFor: 'initialization' stamp: 'NME 12/3/2018 01:42:33'!
initialize

	time _ 0 minutes! !

!Clock methodsFor: 'initialization' stamp: 'NME 12/3/2018 02:04:04'!
now
	^time! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #RestInterface category: #TusLibros!
Object subclass: #RestInterface
	instanceVariableNames: 'users carts carritoId catalog currentTime merchantProcessor salesBook timer cartSessions purchases'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestInterface methodsFor: 'initialization' stamp: 'LR 12/3/2018 08:29:56'!
createCartwithUID: id andPassword: password	
	
	self checkValidUserId: id andPassword: password.
		
	carritoId _ carritoId + 1.
	carts at: carritoId put: (Cart acceptingItemsOf: catalog).
	
	cartSessions at: carritoId put: (CartSession new initializeWithTimeout: 30 minutes andInitialTime: timer now).
	
	^ carritoId.

	 ! !

!RestInterface methodsFor: 'initialization' stamp: 'LR 12/3/2018 08:30:59'!
initializeInterfaceWithUsers: aDictionary andCatalog: aCatalog withMerchantProcessor: aMerchantProcessor withSalesBook: aSalesBook withTimer:aTimer
	
	catalog _ aCatalog .
	users _ aDictionary .
	carts _ Dictionary new.
	carritoId _ 0.
	merchantProcessor _ aMerchantProcessor .
	salesBook _ aSalesBook.
	timer _ aTimer.
	cartSessions _ Dictionary new.! !


!RestInterface methodsFor: 'accessing' stamp: 'nme 11/22/2018 20:26:01'!
getCarritoWithId: id 
	^ carts at: id.! !

!RestInterface methodsFor: 'accessing' stamp: 'LR 12/3/2018 08:26:26'!
listCart: cartId 
	carts at: cartId ifAbsent: [self error: self class invalidCartIdErrorMessage].
	self assertDoesntExpiredTime: carritoId.
	^ (carts at: cartId) items.! !

!RestInterface methodsFor: 'accessing' stamp: 'LR 12/3/2018 08:18:39'!
listPurchasesFrom: clientId withPassword: password 

	self checkValidUserId: clientId andPassword: password.
	^ purchases.! !



!RestInterface methodsFor: 'operations' stamp: 'NME 12/3/2018 02:08:47'!
addToCart: carritoId aQuantityOf: cant item: item
	
	|aCart|
	carts at: carritoId ifAbsent: [self error: self class invalidCartIdErrorMessage].
	catalog at:item ifAbsent: [self error: self class invalidItemErrorMessage].
	
	self assertDoesntExpiredTime: carritoId.
	
	aCart _ carts at: carritoId.
	aCart add: cant of: item. 
	! !

!RestInterface methodsFor: 'operations' stamp: 'LR 12/3/2018 08:29:30'!
assertDoesntExpiredTime: aCarritoId

	cartSessions at: aCarritoId ifAbsent: [self error: self class cartWithoutSessionErrorMessage].
	((cartSessions at: aCarritoId) hasExpiredOn: timer now) ifTrue: [self error: self class moreThan30MinutesErrorMessage]! !

!RestInterface methodsFor: 'operations' stamp: 'LR 12/3/2018 08:18:12'!
checkValidUserId: id andPassword: password
	(users at: id ifAbsent: [self error: self class invalidUserIdErrorMessage ]).
	(users at: id) = password ifFalse: [ self error: self class invalidPasswordErrorMessage. ]. ! !

!RestInterface methodsFor: 'operations' stamp: 'LR 12/3/2018 05:34:46'!
checkoutCart: cartId withCreditCard: creditCardNumber withExpirationDate: expirationDate andName: userName 
	|aCashier cart aCreditCard|
	
	self assertDoesntExpiredTime: carritoId.
	
	cart _ carts at:cartId.
	aCreditCard _ CreditCard expiringOn: expirationDate .
	
	aCashier _ Cashier toCheckout: cart charging: aCreditCard throught: merchantProcessor on: DateAndTime now registeringOn: salesBook withClient:userName.
	
	purchases _ Ticket withItems: (cart items asBag) andAmount: (aCashier checkOut).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RestInterface class' category: #TusLibros!
RestInterface class
	instanceVariableNames: ''!

!RestInterface class methodsFor: 'initialization' stamp: 'NME 12/3/2018 01:43:06'!
initializeWithUsers: users andCatalog: aCatalog withMerchantProcessor: aMerchantProcessor withSalesBook: aSalesBook withTimer:aTimer
	^ self new initializeInterfaceWithUsers: users andCatalog: aCatalog withMerchantProcessor: aMerchantProcessor withSalesBook: aSalesBook withTimer:aTimer! !


!RestInterface class methodsFor: 'error messages' stamp: 'NME 12/3/2018 02:14:55'!
cartWithoutSessionErrorMessage

	^'cart Without Session'! !

!RestInterface class methodsFor: 'error messages' stamp: 'LR 11/26/2018 20:54:43'!
invalidCartIdErrorMessage
	^ 'Invalid or inexistent cart id'.! !

!RestInterface class methodsFor: 'error messages' stamp: 'NME 12/2/2018 21:58:37'!
invalidItemErrorMessage
	^'Invalid Item'! !

!RestInterface class methodsFor: 'error messages' stamp: 'nme 11/22/2018 20:35:11'!
invalidPasswordErrorMessage
	^ 'Invalid password'.! !

!RestInterface class methodsFor: 'error messages' stamp: 'LR 11/26/2018 20:59:47'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !

!RestInterface class methodsFor: 'error messages' stamp: 'nme 11/22/2018 20:37:23'!
invalidUserIdErrorMessage
	^ 'Invalid or inexistent user id'.! !

!RestInterface class methodsFor: 'error messages' stamp: 'NME 12/3/2018 02:14:21'!
moreThan30MinutesErrorMessage

	^'More than 30 minutes have passed'! !


!classDefinition: #Sale category: #TusLibros!
Object subclass: #Sale
	instanceVariableNames: 'total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:47'!
initializeTotal: aTotal

	total := aTotal ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:47'!
of: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ! !


!classDefinition: #StoreTestObjectsFactory category: #TusLibros!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'NME 12/3/2018 01:12:04'!
expiredDate
	
	^Month month: today monthIndex year: today yearNumber - 1! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:36'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'NME 12/2/2018 22:29:18'!
creditCardNotExpirationDate
	
	^(Month month: today monthIndex year: today yearNumber + 1)! !

!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !
