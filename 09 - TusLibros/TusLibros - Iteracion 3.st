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
	instanceVariableNames: 'testObjectsFactory interfaz users aTimer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestInterfaceTests methodsFor: 'testing' stamp: 'NME 12/3/2018 01:40:44'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	users _ Dictionary new.
	users at: 0 put: 'contraseña'.
	
	aTimer _ Timer new initialize.
	
	interfaz :=  RestInterface initializeWithUsers: users andCatalog: testObjectsFactory defaultCatalog withMerchantProcessor: self withSalesBook: OrderedCollection new withTimer:aTimer.! !

!RestInterfaceTests methodsFor: 'testing' stamp: 'LR 11/26/2018 21:05:32'!
test01CreateCartWithValidUserAndPassword
 	
	| carritoId |
	
	carritoId _ (interfaz createCartwithUID: 0 andPassword: 'contraseña').
	self assert: (interfaz listCart: carritoId) isEmpty.
	
	" Escribo ideas habladas en clase antes de olvidarme:
	
	Hay que tener un especie de '''CartSession''' que junte al carrito, tiempo de expiración y un par de cosas más, a este se le van a preguntar muchas cosas que son código repetido.
	Hay que crear un clock aparte y pasarselo a la interfaz rest cuando se crea, este reloj tiene que tener advance by minutes y go back by minutes para hacer los tests correspondientes.
	Hay que volver a testear algunas cosas que ya testeabamos en el cashier y e lcart, por ej que el checkout sea de un user correcto y la contraseña sea valida etc. (Hay que ver si es TDD o estamos haciendo testing general, lo ulitmo no esta mal).
	Hay que agregar un especie de 'Ticket' para la parte de listar purchases ya que este tiene que responder varios mensajes como la lista y el precio total.
	Si hay un error que throwea el cart o cashier etc, hay que testear sobre ese error (es deir no atraparlo en la interfaz, pero si poner un mensaje de error en la interfaz que sea igual al que tiene el cart cashier o creditcard)."! !

!RestInterfaceTests methodsFor: 'testing' stamp: 'LR 11/26/2018 18:49:49'!
test02CantCreateCartWithInvalidPassword
 	
	self 
		should: [ (interfaz createCartwithUID: 0 andPassword: 'password'). ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = RestInterface invalidPasswordErrorMessage.
			].! !

!RestInterfaceTests methodsFor: 'testing' stamp: 'NME 12/2/2018 20:35:22'!
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

!RestInterfaceTests methodsFor: 'testing' stamp: 'NME 12/3/2018 01:30:56'!
test13CantCheckOutWithAnExpiredCreditCard
 	| carritoId  |
	carritoId _ (interfaz createCartwithUID: 0 andPassword: 'contraseña').
	interfaz addToCart: carritoId aQuantityOf: 1 item: testObjectsFactory itemSellByTheStore.

	
	self should: [ interfaz checkoutCart: carritoId withCreditCard: testObjectsFactory expiredCreditCard withExpirationDate: testObjectsFactory expiredDate andName: 'name'.]
		  raise: Error - MessageNotUnderstood
		  withExceptionDo: [ :anError | self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage].
! !

!RestInterfaceTests methodsFor: 'testing' stamp: 'NME 12/3/2018 01:51:25'!
test20CantAddItemsToCartAfterMoreThan30MinutesHavePassed

 	| carritoId  |
	carritoId _ (interfaz createCartwithUID: 0 andPassword: 'contraseña').
	aTimer advance: 31 minutes.
	
	self
		should: [interfaz addToCart: carritoId aQuantityOf: 3 item: testObjectsFactory itemSellByTheStore .] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | self assert: (anError messageText = RestInterface  moreThan30MinutesErrorMessage )]! !

!RestInterfaceTests methodsFor: 'testing' stamp: 'NME 12/3/2018 02:20:07'!
test21CantListCartItemsAfterMoreThan30MinutesHavePassed

 	| carritoId  |
	carritoId _ (interfaz createCartwithUID: 0 andPassword: 'contraseña').
	interfaz addToCart: carritoId aQuantityOf: 3 item: testObjectsFactory itemSellByTheStore .
	aTimer advance: 31 minutes.
	
	self
		should: [interfaz listCart: carritoId] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | self assert: (anError messageText = RestInterface  moreThan30MinutesErrorMessage )]! !

!RestInterfaceTests methodsFor: 'testing' stamp: 'NME 12/3/2018 02:21:45'!
test22CantCheckoutACartAfterMoreThan30MinutesHavePassed

 	
 	| carritoId  |
	carritoId _ (interfaz createCartwithUID: 0 andPassword: 'contraseña').
	interfaz addToCart: carritoId aQuantityOf: 3 item: testObjectsFactory itemSellByTheStore .
	aTimer advance: 31 minutes.
	
	self
		should: [interfaz checkoutCart: carritoId withCreditCard: testObjectsFactory notExpiredCreditCard withExpirationDate: testObjectsFactory creditCardNotExpirationDate andName: 'name'.] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | self assert: (anError messageText = RestInterface  moreThan30MinutesErrorMessage )]! !


!RestInterfaceTests methodsFor: 'merchant processor' stamp: 'NME 12/3/2018 01:21:07'!
debit: anAmout from: aCreditCard! !


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


!Cart methodsFor: 'queries' stamp: 'nme 11/22/2018 20:57:43'!
items

	^items! !

!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


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
	instanceVariableNames: 'users carts carritoId catalog currentTime merchantProcessor salesBook timer cartsLastAccessTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestInterface methodsFor: 'initialization' stamp: 'NME 12/3/2018 02:04:42'!
createCartwithUID: id andPassword: password	
	
	(users at: id ifAbsent: [self error: self class invalidUserIdErrorMessage ]).
	(users at: id) = password ifFalse: [ self error: self class invalidPasswordErrorMessage. ]. 
	
	carritoId _ carritoId + 1.
	carts at: carritoId put: (Cart acceptingItemsOf: catalog).
	
	cartsLastAccessTime at: carritoId put: (Session new initializeWithTimeout: 30 minutes andInitialTime: timer now).
	
	
	^ carritoId.

	"((users at: id) = password" 
	 ! !

!RestInterface methodsFor: 'initialization' stamp: 'NME 12/3/2018 01:54:38'!
initializeInterfaceWithUsers: aDictionary andCatalog: aCatalog withMerchantProcessor: aMerchantProcessor withSalesBook: aSalesBook withTimer:aTimer
	
	catalog _ aCatalog .
	users _ aDictionary .
	carts _ Dictionary new.
	carritoId _ 0.
	merchantProcessor _ aMerchantProcessor .
	salesBook _ aSalesBook.
	timer _ aTimer.
	cartsLastAccessTime _ Dictionary new.! !


!RestInterface methodsFor: 'accessing' stamp: 'nme 11/22/2018 20:26:01'!
getCarritoWithId: id 
	^ carts at: id.! !

!RestInterface methodsFor: 'accessing' stamp: 'NME 12/3/2018 02:28:31'!
listCart: cartId 
	carts at: cartId ifAbsent: [self error: self class invalidCartIdErrorMessage].
	self assertDoesntExpiredTime: carritoId.
	^ (carts at: cartId ifAbsent: [ self error: self class invalidCartIdErrorMessage ] ) items.! !

!RestInterface methodsFor: 'accessing' stamp: 'LR 11/26/2018 18:05:01'!
listPurchasesFrom: clientId withPassword: password 
! !


!RestInterface methodsFor: 'time' stamp: 'NME 12/3/2018 01:03:56'!
today

	^testObjectsFactory today! !


!RestInterface methodsFor: 'operations' stamp: 'NME 12/3/2018 02:08:47'!
addToCart: carritoId aQuantityOf: cant item: item
	
	|aCart|
	carts at: carritoId ifAbsent: [self error: self class invalidCartIdErrorMessage].
	catalog at:item ifAbsent: [self error: self class invalidItemErrorMessage].
	
	self assertDoesntExpiredTime: carritoId.
	
	aCart _ carts at: carritoId.
	aCart add: cant of: item. 
	! !

!RestInterface methodsFor: 'operations' stamp: 'NME 12/3/2018 02:10:09'!
assertDoesntExpiredTime: aCarritoId

	cartsLastAccessTime at: aCarritoId ifAbsent: [self error: self class cartWithoutSessionErrorMessage].
	((cartsLastAccessTime at: aCarritoId) hasExpiredOn: timer now) ifTrue: [self error: self class moreThan30MinutesErrorMessage]! !

!RestInterface methodsFor: 'operations' stamp: 'NME 12/3/2018 02:22:04'!
checkoutCart: cartId withCreditCard: creditCardNumber withExpirationDate: expirationDate andName: userName 
	|aCashier cart aCreditCard|
	
	self assertDoesntExpiredTime: carritoId.
	
	cart _ carts at:cartId.
	aCreditCard _ CreditCard expiringOn: expirationDate .
	
	aCashier _ Cashier toCheckout: cart charging: aCreditCard throught: merchantProcessor on: DateAndTime now registeringOn: salesBook withClient:userName.
	
	aCashier checkOut .! !

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


!classDefinition: #Session category: #TusLibros!
Object subclass: #Session
	instanceVariableNames: 'timeout lastTimeSession'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Session methodsFor: 'initialization' stamp: 'NME 12/3/2018 02:13:18'!
initializeWithTimeout: aTimeOut andInitialTime: anInitialTime

	timeout _ aTimeOut .
	lastTimeSession _ anInitialTime ! !


!Session methodsFor: 'Expired Session' stamp: 'NME 12/3/2018 02:15:57'!
hasExpiredOn: aTime

	^aTime > (timeout + lastTimeSession)

	! !


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


!classDefinition: #Timer category: #TusLibros!
Object subclass: #Timer
	instanceVariableNames: 'time'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Timer methodsFor: 'modifications' stamp: 'NME 12/3/2018 01:49:21'!
advance: anAmountOfTime

	time := time + anAmountOfTime ! !


!Timer methodsFor: 'initialization' stamp: 'NME 12/3/2018 01:42:33'!
initialize

	time _ 0 minutes! !

!Timer methodsFor: 'initialization' stamp: 'NME 12/3/2018 02:04:04'!
now
	^time! !
