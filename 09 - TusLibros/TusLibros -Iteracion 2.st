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

!CartTest methodsFor: 'support' stamp: 'nme 11/21/2018 17:38:13'!
defaultCatalog

	
	^ Dictionary newFromPairs:( Array with: self itemSellByTheStore with:5).! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: 'cashier simulatedMerchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'support' stamp: 'nme 11/21/2018 19:35:24'!
anItem

	^'anItemInTheCart'! !

!CashierTest methodsFor: 'support' stamp: 'nme 11/21/2018 19:35:33'!
anotherItem

	^'anotherItemInTheCart'! !

!CashierTest methodsFor: 'support' stamp: 'nme 11/21/2018 19:35:44'!
defaultCatalog
	
	^ Dictionary newFromPairs: (Array with: self anItem with:5 with: self anotherItem with: 8).! !

!CashierTest methodsFor: 'support' stamp: 'nme 11/21/2018 19:36:15'!
invalidCreditCardByDate

^CreditCard name: 'Juan' withNumber: 2222222222222222 expiresOn:(GregorianMonthOfYear yearNumber: 2017 monthNumber:1) . 

	! !

!CashierTest methodsFor: 'support' stamp: 'nme 11/21/2018 19:36:07'!
invalidCreditCardByName

^CreditCard name: 'sssssssssssssssssssssssssssssss' withNumber: 2222222222222222 expiresOn:(GregorianMonthOfYear yearNumber: 2019 monthNumber:1) . 

	! !

!CashierTest methodsFor: 'support' stamp: 'nme 11/21/2018 19:35:59'!
invalidCreditCardByNumber

^CreditCard name: 'Juan' withNumber: 22222222222222 expiresOn:(GregorianMonthOfYear yearNumber: 2019 monthNumber:1) . 

	! !

!CashierTest methodsFor: 'support' stamp: 'nme 11/21/2018 19:40:15'!
validCreditCard

^CreditCard name: 'Juan' withNumber: 2222222222222222 expiresOn:(GregorianMonthOfYear yearNumber: 2019 monthNumber:1) . 

	! !


!CashierTest methodsFor: 'merchant processor' stamp: 'NME 11/22/2018 16:24:47'!
charge: anAmount from: aCard

	simulatedMerchantProcessor value: anAmount value:aCard .! !


!CashierTest methodsFor: 'tests' stamp: 'NME 11/22/2018 13:54:05'!
test01SholdNotAcceptAnEmptyCart

	|aCart aDate aSalesBook |
	aCart _ Cart acceptingItemsOf: self defaultCatalog.
	aDate _(GregorianMonthOfYear yearNumber: 2017 monthNumber:1) .
	aSalesBook _ OrderedCollection new.
	simulatedMerchantProcessor := [:anAmount :aCard | ].
	
	
	self
		should: [ Cashier doCheckoutOf: aCart 
			with: self validCreditCard 
			OnDate: aDate 
			registeringOn:  aSalesBook 
			withMerchandtProcessor: simulatedMerchantProcessor ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals:  Cashier emptyCartErrorMessage.
			self assert: aSalesBook isEmpty].
	! !

!CashierTest methodsFor: 'tests' stamp: 'NME 11/22/2018 16:28:04'!
test02TotalFromAnElementCheckedOutIsThePriceInTheListsPrices

	|aCart aCashier aSalesBook aDay|
	aCart _ Cart acceptingItemsOf: self defaultCatalog.
	aCart add: 1 of: self anItem.
	
	aSalesBook _ OrderedCollection new.
	aDay _ (GregorianMonthOfYear yearNumber: 2017 monthNumber:1) . 
	
	
	simulatedMerchantProcessor := [:anAmount :aCard | ].
	aCashier _ Cashier doCheckoutOf: aCart with: self validCreditCard  OnDate: aDay registeringOn: aSalesBook withMerchandtProcessor: self.
	
	self assert: aCashier totalCheckOut equals: (aCart price: self anItem).
	! !

!CashierTest methodsFor: 'tests' stamp: 'NME 11/22/2018 16:28:09'!
test03TotalFromMoreThanAnElementCheckedOutIsTheSumOfThePrices

	|aCart aCashier aSalesBook aDay|
	aCart _ Cart acceptingItemsOf: self defaultCatalog.
	aCart add: 1 of: self anItem.
	aCart  add: 1 of: self anotherItem.
	
	aSalesBook _ OrderedCollection new.
	aDay _ (GregorianMonthOfYear yearNumber: 2017 monthNumber:1) . 
	
	
	simulatedMerchantProcessor := [:anAmount :aCard | ].
	
	
	aCashier _ Cashier doCheckoutOf: aCart with: self validCreditCard  OnDate:  aDay registeringOn: aSalesBook withMerchandtProcessor: self .
	
	self assert: aCashier totalCheckOut equals: (aCart price: self anItem) + (aCart price:self anotherItem ).
	! !

!CashierTest methodsFor: 'tests' stamp: 'NME 11/22/2018 16:28:13'!
test04CheckOutWithAnExpiredCardRaiseAnException

	|aCart aDay aSalesBook|
	aCart _ Cart acceptingItemsOf: self defaultCatalog.
	aCart add: 1 of: self anItem.
	aDay _ GregorianMonthOfYear yearNumber: 2018 monthNumber:8.
	aSalesBook _ OrderedCollection new.
	simulatedMerchantProcessor := [:anAmount :aCard | ].
	
	self 
		should: [ Cashier doCheckoutOf: aCart with: self invalidCreditCardByDate  OnDate: aDay registeringOn: aSalesBook withMerchandtProcessor: self ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals:  Cashier expiredCardErrorMessage.
			self assert: aSalesBook isEmpty].! !

!CashierTest methodsFor: 'tests' stamp: 'NME 11/22/2018 16:28:18'!
test05CheckOutWithAnInvalidNameCardRaiseAnException

	|aCart aDay aSalesBook|
	aCart _ Cart acceptingItemsOf: self defaultCatalog.
	aCart add: 1 of: self anItem.
	aDay _ GregorianMonthOfYear yearNumber: 2018 monthNumber:8.
	aSalesBook _ OrderedCollection new.
	simulatedMerchantProcessor := [:anAmount :aCard | ].
	
	self 		
	should: [ Cashier doCheckoutOf: aCart with: self invalidCreditCardByName  OnDate: aDay registeringOn: aSalesBook withMerchandtProcessor: self ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals:  Cashier invalidNameCardErrorMessage.
			self assert: aSalesBook isEmpty].! !

!CashierTest methodsFor: 'tests' stamp: 'NME 11/22/2018 16:28:23'!
test06CheckOutWithAnInvalidNumberCardRaiseAnException

	|aCart aDay aSalesBook |
	aCart _ Cart acceptingItemsOf: self defaultCatalog.
	aCart add: 1 of: self anItem.
	aDay _ GregorianMonthOfYear yearNumber: 2018 monthNumber:8.
	aSalesBook _ OrderedCollection new.
	simulatedMerchantProcessor := [:anAmount :aCard | ].
	
	self 
		should: [ Cashier doCheckoutOf: aCart with: self invalidCreditCardByNumber OnDate: aDay registeringOn: aSalesBook withMerchandtProcessor: self ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals:  Cashier invalidNumberCardErrorMessage.
			self assert: aSalesBook isEmpty].! !

!CashierTest methodsFor: 'tests' stamp: 'NME 11/22/2018 16:28:28'!
test07CheckOutRegistersASale

	|aCart aCashier aSalesBook aDay total|
	aCart _ Cart acceptingItemsOf: self defaultCatalog.
	aCart add: 1 of: self anItem.
	aCart  add: 1 of: self anotherItem.
	aSalesBook _ OrderedCollection new.
	aDay _ (GregorianMonthOfYear yearNumber: 2017 monthNumber:1) . 
	
	
	simulatedMerchantProcessor := [:anAmount :aCard | ].
	
	aCashier _ Cashier doCheckoutOf: aCart 
	with: self validCreditCard 
	OnDate: aDay 
	registeringOn: aSalesBook
	withMerchandtProcessor: self .
	
	total := aCashier totalCheckOut .
	
	self assert: aSalesBook notEmpty.
	self assert: aSalesBook first = total.
	! !

!CashierTest methodsFor: 'tests' stamp: 'NME 11/22/2018 16:27:39'!
test08CheckOutWithAnStolenCardRaiseAnException

	|aCart aDay aSalesBook aCashier|
	aCart _ Cart acceptingItemsOf: self defaultCatalog.
	aCart add: 1 of: self anItem.
	aDay _ GregorianMonthOfYear yearNumber: 2018 monthNumber:8.
	aSalesBook _ OrderedCollection new.
	simulatedMerchantProcessor := [:anAmount :aCard | self error: Cashier stolenCardErrorMessage].
	
	aCashier _ Cashier doCheckoutOf: aCart 
			with: self validCreditCard 
			OnDate: aDay registeringOn: aSalesBook 
			withMerchandtProcessor: self.
	
	self 
		should: [ aCashier totalCheckOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals:  Cashier stolenCardErrorMessage.
			self assert: aSalesBook isEmpty].! !

!CashierTest methodsFor: 'tests' stamp: 'NME 11/22/2018 16:33:55'!
test09CheckOutWithAnNonStolenRegistersASale

	|aCart aDay aSalesBook aCashier total amountRecievedByMP cardRecievedByMP|
	aCart _ Cart acceptingItemsOf: self defaultCatalog.
	aCart add: 1 of: self anItem.
	aDay _ GregorianMonthOfYear yearNumber: 2018 monthNumber:8.
	aSalesBook _ OrderedCollection new.
	simulatedMerchantProcessor := [:anAmount :aCard | amountRecievedByMP := anAmount. cardRecievedByMP := aCard.].
	
	aCashier _ Cashier doCheckoutOf: aCart 
			with: self validCreditCard 
			OnDate: aDay registeringOn: aSalesBook 
			withMerchandtProcessor: self.
	
	total _ aCashier totalCheckOut.
	
	self assert: aSalesBook notEmpty.
	self assert: aSalesBook first = total.
	self assert: self validCreditCard number equals: cardRecievedByMP number.
	self assert: total equals: amountRecievedByMP.! !

!CashierTest methodsFor: 'tests' stamp: 'NME 11/22/2018 16:35:22'!
test10CheckOutWithACreditCardWithoutCreditRaisesAnException

	|aCart aDay aSalesBook aCashier|
	aCart _ Cart acceptingItemsOf: self defaultCatalog.
	aCart add: 1 of: self anItem.
	aDay _ GregorianMonthOfYear yearNumber: 2018 monthNumber:8.
	aSalesBook _ OrderedCollection new.
	simulatedMerchantProcessor := [:anAmount :aCard | self error: Cashier withoutCreditErrorMessage].
	
	aCashier _ Cashier doCheckoutOf: aCart 
			with: self validCreditCard 
			OnDate: aDay registeringOn: aSalesBook 
			withMerchandtProcessor: self.
	
	self 
		should: [ aCashier totalCheckOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals:  Cashier withoutCreditErrorMessage.
			self assert: aSalesBook isEmpty].! !


!classDefinition: #CreditCardTest category: #TusLibros!
TestCase subclass: #CreditCardTest
	instanceVariableNames: 'cashier'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'tests' stamp: 'nme 11/21/2018 19:42:05'!
test01CreditCardIsValid
	| card |
	card _ CreditCard name: 'Ricky' withNumber: 5423240012345555 expiresOn: (GregorianMonthOfYear januaryOf: (GregorianYear number: 2020)). 
	
	self assert: card name equals: 'Ricky'.
	self assert: card number equals: 5423240012345555.
	self assert: card expirationDate equals: (GregorianMonthOfYear januaryOf: (GregorianYear number: 2020)).! !


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


!Cart methodsFor: 'assertions' stamp: 'nme 11/21/2018 17:32:29'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ].
	! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'nme 11/21/2018 17:40:03'!
catalog

	^catalog! !

!Cart methodsFor: 'queries' stamp: 'nme 11/15/2018 19:24:25'!
items

	^items ! !

!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !

!Cart methodsFor: 'queries' stamp: 'nme 11/21/2018 18:21:19'!
price: anItem

	^catalog at:anItem .! !


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
	instanceVariableNames: 'cart total creditCard date salesBook merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'initialization' stamp: 'NME 11/22/2018 13:45:37'!
initializeCheckOutOf:aCart with:aCreditCard onDate:aDay registerOn: aSalesBook withMerchandtProcessor:simulatedMerchantProcessor .
 
	cart _ aCart.
	creditCard _ aCreditCard .
	date _ aDay.	
	salesBook _ aSalesBook .
	merchantProcessor _ simulatedMerchantProcessor .! !


!Cashier methodsFor: 'checkingOut' stamp: 'NME 11/22/2018 16:11:41'!
totalCheckOut
	|totalSale|
	totalSale _  cart items inject: 0 into:[:total :item| total+ (cart price: item)]. 
	
	merchantProcessor charge: totalSale from: creditCard.
	
	salesBook add: totalSale.
	
	^totalSale.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'initialization' stamp: 'NME 11/22/2018 13:40:45'!
doCheckoutOf: aCart with:aCreditCard  OnDate: aDay  registeringOn: aSalesBook withMerchandtProcessor: simulatedMerchantProcessor
	
	
	(aCreditCard expirationDate< aDay ) ifTrue: [self error: self expiredCardErrorMessage].
	(aCreditCard name size >30) ifTrue: [self error: self invalidNameCardErrorMessage].
	(aCreditCard number asString size= 16) ifFalse: [self error: self invalidNumberCardErrorMessage].
	aCart isEmpty ifTrue: [self error: self emptyCartErrorMessage].
	
	^self new initializeCheckOutOf:aCart with:aCreditCard onDate:aDay registerOn: aSalesBook withMerchandtProcessor:simulatedMerchantProcessor .! !


!Cashier class methodsFor: 'error messages' stamp: 'nme 11/15/2018 18:40:43'!
emptyCartErrorMessage
	^'The cart is Empty'! !

!Cashier class methodsFor: 'error messages' stamp: 'nme 11/21/2018 18:41:13'!
expiredCardErrorMessage
	^'Expired card'! !

!Cashier class methodsFor: 'error messages' stamp: 'nme 11/21/2018 19:31:50'!
invalidNameCardErrorMessage
	^'Invalid Name'! !

!Cashier class methodsFor: 'error messages' stamp: 'nme 11/21/2018 19:31:59'!
invalidNumberCardErrorMessage
	^'Invalid Number'! !

!Cashier class methodsFor: 'error messages' stamp: 'NME 11/22/2018 16:35:51'!
withoutCreditErrorMessage
^ 'Withot credit'! !


!Cashier class methodsFor: 'as yet unclassified' stamp: 'NME 11/22/2018 16:15:02'!
stolenCardErrorMessage
	^'Stolen Card'! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'name creditCardNumber expirationDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'access' stamp: 'nme 11/21/2018 17:25:44'!
expirationDate
	
	^expirationDate ! !

!CreditCard methodsFor: 'access' stamp: 'nme 11/21/2018 17:24:45'!
name
	^name.! !

!CreditCard methodsFor: 'access' stamp: 'nme 11/21/2018 17:25:23'!
number
	^creditCardNumber ! !


!CreditCard methodsFor: 'initialization' stamp: 'LR 11/20/2018 06:05:08'!
initializeWithName: aName with: aCreditCardNumber expiresOn: aGregorianMonthOfYear.
	name _ aName.
	creditCardNumber  _ aCreditCardNumber.
	expirationDate _ aGregorianMonthOfYear.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'initialization' stamp: 'nme 11/21/2018 17:51:35'!
name: aName withNumber: aNumber expiresOn: aGregorianMonthOfYear 
	^ CreditCard new initializeWithName: aName with: aNumber expiresOn: aGregorianMonthOfYear.! !
