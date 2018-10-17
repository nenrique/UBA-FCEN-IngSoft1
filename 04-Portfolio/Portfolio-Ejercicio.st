!classDefinition: #AccountTransaction category: #'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'NME 10/17/2018 14:16:01'!
realValue 

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #Deposit category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'LR 10/17/2018 05:11:15'!
applyTransaction: aValue
	^ aValue + (self value).! !

!Deposit methodsFor: 'value' stamp: 'NME 10/17/2018 14:14:28'!
realValue

	^ value! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'LR 10/17/2018 05:11:24'!
applyTransaction: aValue
	^ aValue - (self value).! !

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'NME 10/17/2018 14:15:47'!
realValue

	^  value negated! !

!Withdraw methodsFor: 'value' stamp: 'LR 10/17/2018 03:53:12'!
value

	^  value ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #SummarizingAccount category: #'Portfolio-Ejercicio'!
Object subclass: #SummarizingAccount
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!SummarizingAccount methodsFor: 'testing' stamp: 'HAW 10/11/2018 16:53:28'!
doesManage: anAccount

	self subclassResponsibility ! !

!SummarizingAccount methodsFor: 'testing' stamp: 'HAW 10/11/2018 16:53:54'!
hasRegistered: aTransaction

	self subclassResponsibility ! !


!SummarizingAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:35'!
transactions

	self subclassResponsibility ! !


!SummarizingAccount methodsFor: 'balance' stamp: 'HernanWilkinson 7/13/2011 18:34'!
balance

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
SummarizingAccount subclass: #Portfolio
	instanceVariableNames: 'accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'balance' stamp: 'NME 10/17/2018 14:08:44'!
balance


 ^accounts sum: [ :account | account balance ].! !


!Portfolio methodsFor: 'testing' stamp: 'NME 10/17/2018 14:31:12'!
doesManage: anAccount

	^self = anAccount or: [accounts anySatisfy: [:managedAccount| managedAccount doesManage: anAccount ]].! !

!Portfolio methodsFor: 'testing' stamp: 'LR 10/17/2018 05:20:17'!
hasRegistered: aTransaction

	accounts do: [:account | (account hasRegistered: aTransaction) ifTrue: [^true] ].
	^false.! !


!Portfolio methodsFor: 'transactions' stamp: 'NME 10/17/2018 14:48:14'!
initializeWith: leftAccount with: rightAccount
	accounts _ OrderedCollection new.
	accounts add: leftAccount.
	accounts add: rightAccount.! !

!Portfolio methodsFor: 'transactions' stamp: 'NME 10/17/2018 14:48:25'!
initializeWithAll: aCollectionOfAccounts

accounts _ aCollectionOfAccounts 

! !

!Portfolio methodsFor: 'transactions' stamp: 'LR 10/17/2018 05:40:32'!
manages: anAccount
	"NOTA no hay que usar el ordered collection ya que cada account maneja solo 2 accounts o portfolios, hay que cambiar el codigo anterior" ! !

!Portfolio methodsFor: 'transactions' stamp: 'LR 10/17/2018 05:25:35'!
transactions 

	| transactions |
	transactions  _ OrderedCollection new.
	
	accounts do: [:account | transactions addAll: (account transactions)].
	
	^ transactions.! !

!Portfolio methodsFor: 'transactions' stamp: 'NME 10/17/2018 14:34:31'!
transactionsOf: anAccount 
	
	(self doesManage: anAccount) ifTrue: [^ anAccount transactions].
	
	^self error: self class accountNotManagedMessageDescription.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'instance creation' stamp: 'NME 10/17/2018 14:58:57'!
with: leftAccount with: rightAccount

|aCollectionOfAccounts|

aCollectionOfAccounts _ OrderedCollection with: leftAccount with: rightAccount .

(leftAccount doesManage: rightAccount ) ifFalse: [^self withAll: aCollectionOfAccounts].

	self error: self accountAlreadyManagedErrorMessage.! !

!Portfolio class methodsFor: 'instance creation' stamp: 'NME 10/17/2018 14:50:40'!
withAll: aCollectionOfAccounts

^self new initializeWithAll: aCollectionOfAccounts .

! !


!Portfolio class methodsFor: 'error messages' stamp: 'HAW 5/8/2018 16:08:43'!
accountAlreadyManagedErrorMessage

	^ 'Account already managed'! !

!Portfolio class methodsFor: 'error messages' stamp: 'HAW 5/8/2018 16:08:53'!
accountNotManagedMessageDescription
	
	^ 'Account not managed'! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Ejercicio'!
SummarizingAccount subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'NME 10/17/2018 14:14:08'!
balance

	^ transactions inject: 0 into:[:sum :transaction | sum+ transaction realValue]. ! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 10/11/2018 16:53:28'!
doesManage: anAccount

	^ self = anAccount 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 10/11/2018 16:53:54'!
hasRegistered: aTtransaction

	^ transactions includes: aTtransaction 
! !
