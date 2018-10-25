!classDefinition: #AccountTransaction category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountTransaction methodsFor: 'print' stamp: 'nme 10/22/2018 13:29:39'!
print

	^self subclassResponsibility.! !


!AccountTransaction methodsFor: 'evaluating' stamp: 'HAW 10/18/2018 20:20:37'!
affectBalance: currentBalance  

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'evaluating' stamp: 'HernanWilkinson 7/14/2011 06:48'!
value

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'HAW 10/18/2018 21:06:37'!
for: anAmount

	self subclassResponsibility ! !


!AccountTransaction class methodsFor: 'registering' stamp: 'HAW 10/18/2018 19:48:18'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #CertificateOfDeposit category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #CertificateOfDeposit
	instanceVariableNames: 'value days interesRate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!CertificateOfDeposit methodsFor: 'initialization' stamp: 'NME 10/25/2018 12:51:39'!
initializeFor:anAmount during:aNumberOfDays at:anInteresRate

	value _ anAmount.
	days _ aNumberOfDays .
	interesRate _ anInteresRate.! !


!CertificateOfDeposit methodsFor: 'acception' stamp: 'nme 10/22/2018 19:39:17'!
accept:aVisitor

	aVisitor visitCertificateOfDepositFor:self.! !


!CertificateOfDeposit methodsFor: 'evaluating' stamp: 'NME 10/25/2018 12:50:49'!
affectBalance: currentBalance

	^currentBalance - value! !

!CertificateOfDeposit methodsFor: 'evaluating' stamp: 'NME 10/25/2018 12:51:03'!
days

	^days! !

!CertificateOfDeposit methodsFor: 'evaluating' stamp: 'NME 10/25/2018 12:51:11'!
earning

	^100* ((interesRate)/360)*days.! !

!CertificateOfDeposit methodsFor: 'evaluating' stamp: 'NME 10/25/2018 12:51:20'!
interesRate

	^interesRate ! !

!CertificateOfDeposit methodsFor: 'evaluating' stamp: 'NME 10/25/2018 12:50:56'!
value

	^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CertificateOfDeposit class' category: #'PortfolioTreePrinter-Ejercicio'!
CertificateOfDeposit class
	instanceVariableNames: ''!

!CertificateOfDeposit class methodsFor: 'instance creation' stamp: 'nme 10/22/2018 15:46:15'!
for:anAmount during:aNumberOfDays at:anInteresRate 

	^self new initializeFor:anAmount during:aNumberOfDays at:anInteresRate.! !

!CertificateOfDeposit class methodsFor: 'instance creation' stamp: 'nme 10/22/2018 15:49:39'!
register:anAmount during:aNumberOfDays at:anInteresRate on: anAccount

	|transaction|
	
	transaction _ self for:anAmount during:aNumberOfDays at:anInteresRate.
	
	anAccount register: transaction.
	
	^transaction .! !


!classDefinition: #Deposit category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'acception' stamp: 'NME 10/25/2018 12:52:44'!
accept:aVisitor

	^aVisitor visitDepositFor: self.! !


!Deposit methodsFor: 'value' stamp: 'HAW 10/18/2018 20:37:28'!
affectBalance: currentBalance  

	^currentBalance + self value! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'PortfolioTreePrinter-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 19:41'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #TransferLeg category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #TransferLeg
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!TransferLeg methodsFor: 'evaluating' stamp: 'NME 10/25/2018 12:53:16'!
transfer

	^transfer! !

!TransferLeg methodsFor: 'evaluating' stamp: 'NME 10/25/2018 12:53:10'!
value

	^transfer value! !


!TransferLeg methodsFor: 'initialization' stamp: 'nme 10/22/2018 12:32:45'!
initializeRelatedTo: aTransfer

	transfer _ aTransfer.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: #'PortfolioTreePrinter-Ejercicio'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'instance creation' stamp: 'nme 10/22/2018 12:32:12'!
relatedTo: aTransfer

	^self new initializeRelatedTo: aTransfer.! !


!classDefinition: #TransferDeposit category: #'PortfolioTreePrinter-Ejercicio'!
TransferLeg subclass: #TransferDeposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!TransferDeposit methodsFor: 'evaluating' stamp: 'NME 10/25/2018 12:56:44'!
affectBalance: currentBalance

	^currentBalance + self value.! !


!TransferDeposit methodsFor: 'acception' stamp: 'nme 10/22/2018 19:39:17'!
accept:aVisitor

	aVisitor visitTransferDepositFor:self.! !


!classDefinition: #TransferWithdraw category: #'PortfolioTreePrinter-Ejercicio'!
TransferLeg subclass: #TransferWithdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!TransferWithdraw methodsFor: 'evaluating' stamp: 'NME 10/25/2018 12:57:24'!
affectBalance:currentBalance

	^currentBalance - self value.! !


!TransferWithdraw methodsFor: 'acception' stamp: 'nme 10/22/2018 19:39:17'!
accept:aVisitor

	aVisitor visitTransferWithdrawFor:self.! !


!classDefinition: #Withdraw category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'acception' stamp: 'NME 10/25/2018 12:57:50'!
accept:aVisitor

	aVisitor visitWithdrawFor:self.! !


!Withdraw methodsFor: 'value' stamp: 'HAW 10/18/2018 18:49:08'!
affectBalance: currentBalance

	^currentBalance - value! !

!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/14/2011 05:54'!
value

	^ value ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'PortfolioTreePrinter-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/14/2011 05:32'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #AccountVisitor category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #AccountVisitor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountVisitor methodsFor: 'visiting' stamp: 'nme 10/22/2018 19:48:51'!
visitCertificateOfDepositeFor: aDeposit
	self subclassResponsibility .! !

!AccountVisitor methodsFor: 'visiting' stamp: 'nme 10/22/2018 19:48:31'!
visitDepositFor: aDeposit
	self subclassResponsibility .! !

!AccountVisitor methodsFor: 'visiting' stamp: 'nme 10/22/2018 19:48:46'!
visitTransferDepositFor: aDeposit
	self subclassResponsibility .! !

!AccountVisitor methodsFor: 'visiting' stamp: 'nme 10/22/2018 19:48:43'!
visitTransferWithdrawFor: aDeposit
	self subclassResponsibility .! !

!AccountVisitor methodsFor: 'visiting' stamp: 'nme 10/22/2018 19:48:38'!
visitWithdrawFor: aDeposit
	self subclassResponsibility .! !


!classDefinition: #AccountInvestmentEarnings category: #'PortfolioTreePrinter-Ejercicio'!
AccountVisitor subclass: #AccountInvestmentEarnings
	instanceVariableNames: 'account value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountInvestmentEarnings methodsFor: 'visiting' stamp: 'nme 10/22/2018 20:10:42'!
visitCertificateOfDepositFor:aCof

value _  value + aCof earning 
! !

!AccountInvestmentEarnings methodsFor: 'visiting' stamp: 'nme 10/22/2018 20:02:50'!
visitDepositFor:aDeposit
! !

!AccountInvestmentEarnings methodsFor: 'visiting' stamp: 'nme 10/22/2018 20:04:04'!
visitTransferDepositFor:aTransferDeposit
! !

!AccountInvestmentEarnings methodsFor: 'visiting' stamp: 'nme 10/22/2018 20:03:27'!
visitTransferWithdrawFor:aTransferWithdraw
! !

!AccountInvestmentEarnings methodsFor: 'visiting' stamp: 'nme 10/22/2018 20:03:10'!
visitWithdrawFor:aWithdraw
! !


!AccountInvestmentEarnings methodsFor: 'initialization' stamp: 'nme 10/22/2018 20:08:21'!
initializeOf: aReceptiveAccount
	
	account _ aReceptiveAccount ! !


!AccountInvestmentEarnings methodsFor: 'operations' stamp: 'nme 10/22/2018 20:09:18'!
earning

	value _ 0.
	account transactions do: [ :transaction | (transaction accept: self)].
	^ value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountInvestmentEarnings class' category: #'PortfolioTreePrinter-Ejercicio'!
AccountInvestmentEarnings class
	instanceVariableNames: ''!

!AccountInvestmentEarnings class methodsFor: 'instance creation' stamp: 'nme 10/22/2018 20:07:55'!
of: aReceptiveAccount
	
	^self new initializeOf: aReceptiveAccount! !


!classDefinition: #AccountInvestmentNet category: #'PortfolioTreePrinter-Ejercicio'!
AccountVisitor subclass: #AccountInvestmentNet
	instanceVariableNames: 'account value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountInvestmentNet methodsFor: 'initialization' stamp: 'NME 10/25/2018 12:58:29'!
initializeOf: aReceptiveAccount
	
	account _ aReceptiveAccount ! !


!AccountInvestmentNet methodsFor: 'evaluating' stamp: 'nme 10/22/2018 20:14:41'!
investment

	value _ 0.
	account transactions do: [ :transaction | (transaction accept: self)].
	^ value.! !


!AccountInvestmentNet methodsFor: 'visiting' stamp: 'nme 10/22/2018 20:17:21'!
visitCertificateOfDepositFor: aCertificateOfDeposit 

value _ value + aCertificateOfDeposit  value! !

!AccountInvestmentNet methodsFor: 'visiting' stamp: 'nme 10/22/2018 20:15:24'!
visitDepositFor: aDeposit ! !

!AccountInvestmentNet methodsFor: 'visiting' stamp: 'nme 10/22/2018 20:15:52'!
visitTransferWithdrawFor: aTransferWithdraw! !

!AccountInvestmentNet methodsFor: 'visiting' stamp: 'nme 10/22/2018 20:15:39'!
visitWithdrawFor: aWithdraw 
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountInvestmentNet class' category: #'PortfolioTreePrinter-Ejercicio'!
AccountInvestmentNet class
	instanceVariableNames: ''!

!AccountInvestmentNet class methodsFor: 'instance creation' stamp: 'nme 10/22/2018 20:13:42'!
of: aReceptiveAccount
	
	^self new initializeOf: aReceptiveAccount ! !


!classDefinition: #AccountSummaryLines category: #'PortfolioTreePrinter-Ejercicio'!
AccountVisitor subclass: #AccountSummaryLines
	instanceVariableNames: 'account lines'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountSummaryLines methodsFor: 'visiting' stamp: 'NME 10/25/2018 12:59:08'!
visitCertificateOfDepositFor: aCod

	lines add:('Plazo fijo por ', aCod value printString, ' durante ', aCod days printString, ' dias a una tna de ', (100 * aCod interesRate) printString,'%')! !

!AccountSummaryLines methodsFor: 'visiting' stamp: 'NME 10/25/2018 12:59:14'!
visitDepositFor:aDeposit
	lines add: ('Deposito por ', (aDeposit value) printString) ! !

!AccountSummaryLines methodsFor: 'visiting' stamp: 'NME 10/25/2018 12:59:20'!
visitTransferDepositFor: aTransferDeposit
	lines add: ('Transferencia por ', (aTransferDeposit value) printString)! !

!AccountSummaryLines methodsFor: 'visiting' stamp: 'NME 10/25/2018 12:59:28'!
visitTransferWithdrawFor: aTransferWithdraw
	lines add: ('Transferencia por -', (aTransferWithdraw value) printString)! !

!AccountSummaryLines methodsFor: 'visiting' stamp: 'NME 10/25/2018 12:59:36'!
visitWithdrawFor:aDeposit

	lines add: ('Extraccion por ', (aDeposit value) printString)! !


!AccountSummaryLines methodsFor: 'initialization' stamp: 'NME 10/25/2018 12:59:53'!
initializeOf: aReceptiveAccount
	account _ aReceptiveAccount ! !


!AccountSummaryLines methodsFor: 'evaluating' stamp: 'nme 10/22/2018 19:40:11'!
summary

	lines _ OrderedCollection new.
	account transactions do: [ :transaction | (transaction accept: self)].
	^ lines.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummaryLines class' category: #'PortfolioTreePrinter-Ejercicio'!
AccountSummaryLines class
	instanceVariableNames: ''!

!AccountSummaryLines class methodsFor: 'instance creation' stamp: 'nme 10/22/2018 19:31:58'!
of: aReceptiveAccount

	^ self new initializeOf: aReceptiveAccount .
	! !


!classDefinition: #AccountTransferNet category: #'PortfolioTreePrinter-Ejercicio'!
AccountVisitor subclass: #AccountTransferNet
	instanceVariableNames: 'account transfer value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountTransferNet methodsFor: 'visiting' stamp: 'NME 10/25/2018 13:01:00'!
visitCertificateOfDepositFor: aCod! !

!AccountTransferNet methodsFor: 'visiting' stamp: 'NME 10/25/2018 13:01:07'!
visitDepositFor: aDeposit! !

!AccountTransferNet methodsFor: 'visiting' stamp: 'NME 10/25/2018 13:01:13'!
visitTransferDepositFor: aTransferWithdraw
	value _ value + aTransferWithdraw value.! !

!AccountTransferNet methodsFor: 'visiting' stamp: 'NME 10/25/2018 13:01:19'!
visitTransferWithdrawFor: aTransferWithdraw
	value _ value - aTransferWithdraw value.! !

!AccountTransferNet methodsFor: 'visiting' stamp: 'NME 10/25/2018 13:01:25'!
visitWithdrawFor: aCod
! !


!AccountTransferNet methodsFor: 'initialization' stamp: 'NME 10/25/2018 13:01:37'!
initializeOf: anAccount
	account _ anAccount ! !


!AccountTransferNet methodsFor: 'evaluating' stamp: 'nme 10/22/2018 19:52:05'!
transfer
	value _ 0.
	account transactions do: [ :transaction | (transaction accept: self)].
	^ value.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransferNet class' category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransferNet class
	instanceVariableNames: ''!

!AccountTransferNet class methodsFor: 'instance creation' stamp: 'nme 10/22/2018 19:47:27'!
of: anAccount

	^ self new initializeOf: anAccount.! !


!classDefinition: #SummarizingAccount category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #SummarizingAccount
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!SummarizingAccount methodsFor: 'testing' stamp: 'HAW 10/18/2018 16:31:24'!
doesManage: anAccount

	self subclassResponsibility ! !

!SummarizingAccount methodsFor: 'testing' stamp: 'HAW 10/18/2018 16:32:05'!
hasRegistered: aTransaction

	self subclassResponsibility ! !


!SummarizingAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:34'!
balance

	self subclassResponsibility ! !

!SummarizingAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:35'!
transactions

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: #'PortfolioTreePrinter-Ejercicio'!
SummarizingAccount subclass: #Portfolio
	instanceVariableNames: 'accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Portfolio methodsFor: 'testing' stamp: 'NME 10/25/2018 13:03:01'!
accountsDo: aBlock
	accounts do: aBlock.! !

!Portfolio methodsFor: 'testing' stamp: 'NME 10/25/2018 13:02:56'!
accountsReverseDo: aBlock
	accounts reverseDo: aBlock.! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 10/18/2018 16:31:24'!
anyManagedAccountManages: anAccount 

	^accounts anySatisfy: [ :managedAccount | (managedAccount doesManage: anAccount) or: [ anAccount doesManage: managedAccount ] ] ! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 10/18/2018 16:31:24'!
doesManage: anAccount

	^ self = anAccount  or: [ self anyManagedAccountManages: anAccount ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 10/18/2018 16:32:05'!
hasRegistered: aTransaction

	^ accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]  ! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 8/13/2017 17:47:44'!
balance

	^ accounts sum: [ :account | account balance ]
! !

!Portfolio methodsFor: 'transactions' stamp: 'nme 10/22/2018 17:16:10'!
printWith:aDictionary! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 9/25/2017 19:40:20'!
transactions 

	^ accounts 
		inject: OrderedCollection new 
		into: [ :transactions :account | transactions addAll: account transactions. transactions ]
	! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 10/18/2018 16:31:24'!
transactionsOf: anAccount 

	^ (self doesManage: anAccount)
		ifTrue: [ anAccount transactions ] 
		ifFalse: [ self error: self class accountNotManagedMessageDescription]
	! !


!Portfolio methodsFor: 'acception' stamp: 'NME 10/25/2018 13:02:29'!
accept: aVisitor
	aVisitor visitPortfolioFor: self.! !


!Portfolio methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 19:19'!
initializeWithAll: aCollectionOfAccounts

	accounts := aCollectionOfAccounts   ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'PortfolioTreePrinter-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/8/2018 16:33:13'!
with: leftAccount with: rightAccount

	^ self withAll: (Array with: leftAccount with: rightAccount)! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/8/2018 16:40:55'!
withAll: aCollectionOfAccounts

	self checkCreationPreconditions: aCollectionOfAccounts.
	
	^self new initializeWithAll: aCollectionOfAccounts ! !


!Portfolio class methodsFor: 'assertions' stamp: 'HAW 10/18/2018 16:31:24'!
check: sourceAccount doesNotManagaAnyOf: aCollectionOfAccounts

	^ aCollectionOfAccounts do: [ :targetAccount | 
			(sourceAccount = targetAccount) not ifTrue: [ 
				(sourceAccount doesManage: targetAccount) ifTrue: [ self error: self accountAlreadyManagedErrorMessage ] ] ]! !

!Portfolio class methodsFor: 'assertions' stamp: 'HernanWilkinson 9/18/2011 17:21'!
checkAccountsAreUnique: aCollectionOfAccounts

	aCollectionOfAccounts asSet size = aCollectionOfAccounts size
		ifFalse: [ self error: self accountAlreadyManagedErrorMessage ]! !

!Portfolio class methodsFor: 'assertions' stamp: 'HernanWilkinson 9/18/2011 17:21'!
checkCreationPreconditions: aCollectionOfAccounts

	self checkAccountsAreUnique: aCollectionOfAccounts.
	self checkNoCircularReferencesIn: aCollectionOfAccounts! !

!Portfolio class methodsFor: 'assertions' stamp: 'HernanWilkinson 9/18/2011 17:22'!
checkNoCircularReferencesIn: aCollectionOfAccounts

	aCollectionOfAccounts do: [ :sourceAccount | self check: sourceAccount doesNotManagaAnyOf: aCollectionOfAccounts ]! !


!Portfolio class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/13/2011 19:28'!
accountAlreadyManagedErrorMessage

	^ 'Account already managed'! !

!Portfolio class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/13/2011 19:27'!
accountNotManagedMessageDescription
	
	^ 'Account not managed'! !


!classDefinition: #ReceptiveAccount category: #'PortfolioTreePrinter-Ejercicio'!
SummarizingAccount subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 10/18/2018 18:49:23'!
balance

	^ transactions inject: 0 into: [ :balance :transaction | transaction affectBalance: balance ]! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'acception' stamp: 'NME 10/25/2018 13:03:22'!
accept: aVisitor
	aVisitor visitAccountFor: self.! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 10/18/2018 16:31:24'!
doesManage: anAccount

	^ self = anAccount 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 10/18/2018 16:32:05'!
hasRegistered: aTtransaction

	^ transactions includes: aTtransaction 
! !


!classDefinition: #SummarizingVisitor category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #SummarizingVisitor
	instanceVariableNames: 'lines names baseString portfolio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!SummarizingVisitor methodsFor: 'initialization' stamp: 'NME 10/25/2018 13:04:05'!
initializeOf: aPortfolio with: aDictionaryOfNames
	portfolio _ aPortfolio.
	names _ aDictionaryOfNames.! !


!SummarizingVisitor methodsFor: 'evaluating' stamp: 'nme 10/22/2018 20:36:44'!
depthFirstTraversal
	
	lines _ OrderedCollection new.
	baseString _ String new.
	portfolio accept: self.
	^ lines.
	! !


!SummarizingVisitor methodsFor: 'visiting' stamp: 'NME 10/25/2018 13:03:46'!
visitAccountFor: anAccount
	lines add: (baseString, (names at: anAccount)).! !

!SummarizingVisitor methodsFor: 'visiting' stamp: 'NME 10/25/2018 13:03:53'!
visitPortfolioFor: aPortfolio

	lines add: (baseString, (names at: aPortfolio)).
	
	baseString _ ((String new: ((baseString size) + 1)) atAllPut: $ ).
	aPortfolio accountsDo: [ :account | account accept: self].
	baseString _ ((String new: ((baseString size) - 1)) atAllPut: $ ).

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SummarizingVisitor class' category: #'PortfolioTreePrinter-Ejercicio'!
SummarizingVisitor class
	instanceVariableNames: ''!

!SummarizingVisitor class methodsFor: 'instance creation' stamp: 'nme 10/22/2018 20:55:55'!
of: aPortfolio with: names
	^ self new initializeOf: aPortfolio with: names.! !


!classDefinition: #SummarizingVisitorReverse category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #SummarizingVisitorReverse
	instanceVariableNames: 'lines names baseString portfolio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!SummarizingVisitorReverse methodsFor: 'visiting' stamp: 'NME 10/25/2018 13:04:26'!
visitAccountFor: anAccount
	lines add: (baseString, (names at: anAccount)).! !

!SummarizingVisitorReverse methodsFor: 'visiting' stamp: 'NME 10/25/2018 13:04:32'!
visitPortfolioFor: aPortfolio
	
	baseString _ ((String new: ((baseString size) + 1)) atAllPut: $ ).
	aPortfolio accountsReverseDo: [ :account | account accept: self].
	baseString _ ((String new: ((baseString size) - 1)) atAllPut: $ ).

	lines add: (baseString, (names at: aPortfolio)).
	! !


!SummarizingVisitorReverse methodsFor: 'initialization' stamp: 'NME 10/25/2018 13:04:44'!
initializeOf: aPortfolio with: aDictionaryOfNames
	portfolio _ aPortfolio.
	names _ aDictionaryOfNames.! !


!SummarizingVisitorReverse methodsFor: 'evaluating' stamp: 'nme 10/22/2018 20:54:29'!
leafTraversal
	
	lines _ OrderedCollection new.
	baseString _ String new.
	portfolio accept: self.
	^ lines.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SummarizingVisitorReverse class' category: #'PortfolioTreePrinter-Ejercicio'!
SummarizingVisitorReverse class
	instanceVariableNames: ''!

!SummarizingVisitorReverse class methodsFor: 'instance creation' stamp: 'nme 10/22/2018 20:55:59'!
of: aPortfolio with: names
	^ self new initializeOf: aPortfolio with: names.! !


!classDefinition: #Transfer category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #Transfer
	instanceVariableNames: 'value depositLeg withdrawLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Transfer methodsFor: 'evaluating' stamp: 'NME 10/25/2018 13:05:18'!
depositLeg

^ depositLeg.! !

!Transfer methodsFor: 'evaluating' stamp: 'NME 10/25/2018 13:05:24'!
value

	^ value.! !

!Transfer methodsFor: 'evaluating' stamp: 'NME 10/25/2018 13:05:32'!
withdrawLeg

	^withdrawLeg.! !


!Transfer methodsFor: 'initialization' stamp: 'nme 10/22/2018 12:27:40'!
initializeOf: anAmount

	value _ anAmount.
	depositLeg _ TransferDeposit relatedTo: self.
	withdrawLeg _ TransferWithdraw relatedTo:self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: #'PortfolioTreePrinter-Ejercicio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'nme 10/22/2018 12:45:40'!
of: anAmount

	^self new initializeOf: anAmount .! !

!Transfer class methodsFor: 'instance creation' stamp: 'nme 10/22/2018 12:21:01'!
registerFrom:fromAccount to:toAccount for:anAmount 



	| transfer| 
	
	transfer _ self of:anAmount.
	fromAccount register: transfer withdrawLeg.
	toAccount register: transfer depositLeg.
	
	^transfer! !
