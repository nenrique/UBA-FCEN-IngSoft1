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

!CertificateOfDeposit methodsFor: 'as yet unclassified' stamp: 'nme 10/22/2018 19:39:17'!
accept:aVisitor

	aVisitor visitCertificateOfDepositFor:self.! !

!CertificateOfDeposit methodsFor: 'as yet unclassified' stamp: 'nme 10/22/2018 15:55:12'!
affectBalance: currentBalance

	^currentBalance - value! !

!CertificateOfDeposit methodsFor: 'as yet unclassified' stamp: 'nme 10/22/2018 19:56:50'!
days

	^days! !

!CertificateOfDeposit methodsFor: 'as yet unclassified' stamp: 'nme 10/22/2018 16:04:40'!
earning

	^100* ((interesRate)/360)*days.! !

!CertificateOfDeposit methodsFor: 'as yet unclassified' stamp: 'nme 10/22/2018 15:47:36'!
initializeFor:anAmount during:aNumberOfDays at:anInteresRate

	value _ anAmount.
	days _ aNumberOfDays .
	interesRate _ anInteresRate.! !

!CertificateOfDeposit methodsFor: 'as yet unclassified' stamp: 'nme 10/22/2018 19:57:11'!
interesRate

	^interesRate ! !

!CertificateOfDeposit methodsFor: 'as yet unclassified' stamp: 'nme 10/22/2018 15:55:32'!
value

	^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CertificateOfDeposit class' category: #'PortfolioTreePrinter-Ejercicio'!
CertificateOfDeposit class
	instanceVariableNames: ''!

!CertificateOfDeposit class methodsFor: 'as yet unclassified' stamp: 'nme 10/22/2018 15:46:15'!
for:anAmount during:aNumberOfDays at:anInteresRate 

	^self new initializeFor:anAmount during:aNumberOfDays at:anInteresRate.! !

!CertificateOfDeposit class methodsFor: 'as yet unclassified' stamp: 'nme 10/22/2018 15:49:39'!
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



!Deposit methodsFor: 'value' stamp: 'nme 10/22/2018 19:39:17'!
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

!TransferLeg methodsFor: 'as yet unclassified' stamp: 'nme 10/22/2018 12:32:45'!
initializeRelatedTo: aTransfer

	transfer _ aTransfer.! !

!TransferLeg methodsFor: 'as yet unclassified' stamp: 'nme 10/22/2018 12:41:16'!
transfer

	^transfer! !

!TransferLeg methodsFor: 'as yet unclassified' stamp: 'nme 10/22/2018 12:41:28'!
value

	^transfer value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: #'PortfolioTreePrinter-Ejercicio'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'as yet unclassified' stamp: 'nme 10/22/2018 12:32:12'!
relatedTo: aTransfer

	^self new initializeRelatedTo: aTransfer.! !


!classDefinition: #TransferDeposit category: #'PortfolioTreePrinter-Ejercicio'!
TransferLeg subclass: #TransferDeposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!TransferDeposit methodsFor: 'as yet unclassified' stamp: 'nme 10/22/2018 19:39:17'!
accept:aVisitor

	aVisitor visitTransferDepositFor:self.! !

!TransferDeposit methodsFor: 'as yet unclassified' stamp: 'nme 10/22/2018 12:42:06'!
affectBalance: currentBalance

	^currentBalance + self value.! !


!classDefinition: #TransferWithdraw category: #'PortfolioTreePrinter-Ejercicio'!
TransferLeg subclass: #TransferWithdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!TransferWithdraw methodsFor: 'as yet unclassified' stamp: 'nme 10/22/2018 19:39:17'!
accept:aVisitor

	aVisitor visitTransferWithdrawFor:self.! !

!TransferWithdraw methodsFor: 'as yet unclassified' stamp: 'nme 10/22/2018 12:42:40'!
affectBalance:currentBalance

	^currentBalance - self value.! !


!classDefinition: #Withdraw category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'nme 10/22/2018 19:39:17'!
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

!AccountVisitor methodsFor: 'as yet unclassified' stamp: 'nme 10/22/2018 19:48:51'!
visitCertificateOfDepositeFor: aDeposit
	self subclassResponsibility .! !

!AccountVisitor methodsFor: 'as yet unclassified' stamp: 'nme 10/22/2018 19:48:31'!
visitDepositFor: aDeposit
	self subclassResponsibility .! !

!AccountVisitor methodsFor: 'as yet unclassified' stamp: 'nme 10/22/2018 19:48:46'!
visitTransferDepositFor: aDeposit
	self subclassResponsibility .! !

!AccountVisitor methodsFor: 'as yet unclassified' stamp: 'nme 10/22/2018 19:48:43'!
visitTransferWithdrawFor: aDeposit
	self subclassResponsibility .! !

!AccountVisitor methodsFor: 'as yet unclassified' stamp: 'nme 10/22/2018 19:48:38'!
visitWithdrawFor: aDeposit
	self subclassResponsibility .! !


!classDefinition: #AccountInvestmentEarnings category: #'PortfolioTreePrinter-Ejercicio'!
AccountVisitor subclass: #AccountInvestmentEarnings
	instanceVariableNames: 'account value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountInvestmentEarnings methodsFor: 'as yet unclassified' stamp: 'nme 10/22/2018 20:09:18'!
earning

	value _ 0.
	account transactions do: [ :transaction | (transaction accept: self)].
	^ value.! !

!AccountInvestmentEarnings methodsFor: 'as yet unclassified' stamp: 'nme 10/22/2018 20:08:21'!
initializeOf: aReceptiveAccount
	
	account _ aReceptiveAccount ! !

!AccountInvestmentEarnings methodsFor: 'as yet unclassified' stamp: 'nme 10/22/2018 20:10:42'!
visitCertificateOfDepositFor:aCof

value _  value + aCof earning 
! !

!AccountInvestmentEarnings methodsFor: 'as yet unclassified' stamp: 'nme 10/22/2018 20:02:50'!
visitDepositFor:aDeposit
! !

!AccountInvestmentEarnings methodsFor: 'as yet unclassified' stamp: 'nme 10/22/2018 20:04:04'!
visitTransferDepositFor:aTransferDeposit
! !

!AccountInvestmentEarnings methodsFor: 'as yet unclassified' stamp: 'nme 10/22/2018 20:03:27'!
visitTransferWithdrawFor:aTransferWithdraw
! !

!AccountInvestmentEarnings methodsFor: 'as yet unclassified' stamp: 'nme 10/22/2018 20:03:10'!
visitWithdrawFor:aWithdraw
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountInvestmentEarnings class' category: #'PortfolioTreePrinter-Ejercicio'!
AccountInvestmentEarnings class
	instanceVariableNames: ''!

!AccountInvestmentEarnings class methodsFor: 'as yet unclassified' stamp: 'nme 10/22/2018 20:07:55'!
of: aReceptiveAccount
	
	^self new initializeOf: aReceptiveAccount! !


!classDefinition: #AccountInvestmentNet category: #'PortfolioTreePrinter-Ejercicio'!
AccountVisitor subclass: #AccountInvestmentNet
	instanceVariableNames: 'account value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountInvestmentNet methodsFor: 'as yet unclassified' stamp: 'nme 10/22/2018 20:14:08'!
initializeOf: aReceptiveAccount
	
	account _ aReceptiveAccount ! !

!AccountInvestmentNet methodsFor: 'as yet unclassified' stamp: 'nme 10/22/2018 20:14:41'!
investment

	value _ 0.
	account transactions do: [ :transaction | (transaction accept: self)].
	^ value.! !


!AccountInvestmentNet methodsFor: 'visit' stamp: 'nme 10/22/2018 20:17:21'!
visitCertificateOfDepositFor: aCertificateOfDeposit 

value _ value + aCertificateOfDeposit  value! !

!AccountInvestmentNet methodsFor: 'visit' stamp: 'nme 10/22/2018 20:15:24'!
visitDepositFor: aDeposit ! !

!AccountInvestmentNet methodsFor: 'visit' stamp: 'nme 10/22/2018 20:15:52'!
visitTransferWithdrawFor: aTransferWithdraw! !

!AccountInvestmentNet methodsFor: 'visit' stamp: 'nme 10/22/2018 20:15:39'!
visitWithdrawFor: aWithdraw 
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountInvestmentNet class' category: #'PortfolioTreePrinter-Ejercicio'!
AccountInvestmentNet class
	instanceVariableNames: ''!

!AccountInvestmentNet class methodsFor: 'as yet unclassified' stamp: 'nme 10/22/2018 20:13:42'!
of: aReceptiveAccount
	
	^self new initializeOf: aReceptiveAccount ! !


!classDefinition: #AccountSummaryLines category: #'PortfolioTreePrinter-Ejercicio'!
AccountVisitor subclass: #AccountSummaryLines
	instanceVariableNames: 'account lines'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountSummaryLines methodsFor: 'as yet unclassified' stamp: 'nme 10/22/2018 19:41:14'!
initializeOf: aReceptiveAccount
	account _ aReceptiveAccount ! !

!AccountSummaryLines methodsFor: 'as yet unclassified' stamp: 'nme 10/22/2018 19:40:11'!
summary

	lines _ OrderedCollection new.
	account transactions do: [ :transaction | (transaction accept: self)].
	^ lines.
	! !

!AccountSummaryLines methodsFor: 'as yet unclassified' stamp: 'nme 10/22/2018 20:20:08'!
visitCertificateOfDepositFor: aCod

	lines add:('Plazo fijo por ', aCod value printString, ' durante ', aCod days printString, ' dias a una tna de ', (100 * aCod interesRate) printString,'%')! !

!AccountSummaryLines methodsFor: 'as yet unclassified' stamp: 'nme 10/22/2018 19:40:21'!
visitDepositFor:aDeposit
	lines add: ('Deposito por ', (aDeposit value) printString) ! !

!AccountSummaryLines methodsFor: 'as yet unclassified' stamp: 'nme 10/22/2018 19:40:33'!
visitTransferDepositFor: aTransferDeposit
	lines add: ('Transferencia por ', (aTransferDeposit value) printString)! !

!AccountSummaryLines methodsFor: 'as yet unclassified' stamp: 'nme 10/22/2018 19:40:45'!
visitTransferWithdrawFor: aTransferWithdraw
	lines add: ('Transferencia por -', (aTransferWithdraw value) printString)! !

!AccountSummaryLines methodsFor: 'as yet unclassified' stamp: 'nme 10/22/2018 19:41:02'!
visitWithdrawFor:aDeposit

	lines add: ('Extraccion por ', (aDeposit value) printString)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummaryLines class' category: #'PortfolioTreePrinter-Ejercicio'!
AccountSummaryLines class
	instanceVariableNames: ''!

!AccountSummaryLines class methodsFor: 'as yet unclassified' stamp: 'nme 10/22/2018 19:31:58'!
of: aReceptiveAccount

	^ self new initializeOf: aReceptiveAccount .
	! !


!classDefinition: #AccountTransferNet category: #'PortfolioTreePrinter-Ejercicio'!
AccountVisitor subclass: #AccountTransferNet
	instanceVariableNames: 'account transfer value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountTransferNet methodsFor: 'as yet unclassified' stamp: 'nme 10/22/2018 19:47:41'!
initializeOf: anAccount
	account _ anAccount ! !

!AccountTransferNet methodsFor: 'as yet unclassified' stamp: 'nme 10/22/2018 19:52:05'!
transfer
	value _ 0.
	account transactions do: [ :transaction | (transaction accept: self)].
	^ value.
	! !

!AccountTransferNet methodsFor: 'as yet unclassified' stamp: 'nme 10/22/2018 19:53:18'!
visitCertificateOfDepositFor: aCod! !

!AccountTransferNet methodsFor: 'as yet unclassified' stamp: 'nme 10/22/2018 19:47:52'!
visitDepositFor: aDeposit! !

!AccountTransferNet methodsFor: 'as yet unclassified' stamp: 'nme 10/22/2018 19:52:46'!
visitTransferDepositFor: aTransferWithdraw
	value _ value + aTransferWithdraw value.! !

!AccountTransferNet methodsFor: 'as yet unclassified' stamp: 'nme 10/22/2018 19:52:58'!
visitTransferWithdrawFor: aTransferWithdraw
	value _ value - aTransferWithdraw value.! !

!AccountTransferNet methodsFor: 'as yet unclassified' stamp: 'nme 10/22/2018 19:52:37'!
visitWithdrawFor: aCod
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransferNet class' category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransferNet class
	instanceVariableNames: ''!

!AccountTransferNet class methodsFor: 'as yet unclassified' stamp: 'nme 10/22/2018 19:47:27'!
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

!Portfolio methodsFor: 'testing' stamp: 'HAW 10/18/2018 16:31:24'!
anyManagedAccountManages: anAccount 

	^accounts anySatisfy: [ :managedAccount | (managedAccount doesManage: anAccount) or: [ anAccount doesManage: managedAccount ] ] ! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 10/18/2018 16:31:24'!
doesManage: anAccount

	^ self = anAccount  or: [ self anyManagedAccountManages: anAccount ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 10/18/2018 16:32:05'!
hasRegistered: aTransaction

	^ accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]  ! !


!Portfolio methodsFor: 'transactions' stamp: 'nme 10/22/2018 20:34:50'!
accept: aVisitor
	aVisitor visitPortfolioFor: self.! !

!Portfolio methodsFor: 'transactions' stamp: 'nme 10/22/2018 20:53:28'!
accountsDo: aBlock
	accounts do: aBlock.! !

!Portfolio methodsFor: 'transactions' stamp: 'nme 10/22/2018 20:53:22'!
accountsReverseDo: aBlock
	accounts reverseDo: aBlock.! !

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


!ReceptiveAccount methodsFor: 'transactions' stamp: 'nme 10/22/2018 20:35:06'!
accept: aVisitor
	aVisitor visitAccountFor: self.! !

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

!SummarizingVisitor methodsFor: 'as yet unclassified' stamp: 'nme 10/22/2018 20:36:44'!
depthFirstTraversal
	
	lines _ OrderedCollection new.
	baseString _ String new.
	portfolio accept: self.
	^ lines.
	! !

!SummarizingVisitor methodsFor: 'as yet unclassified' stamp: 'nme 10/22/2018 20:53:47'!
initializeOf: aPortfolio with: aDictionaryOfNames
	portfolio _ aPortfolio.
	names _ aDictionaryOfNames.! !

!SummarizingVisitor methodsFor: 'as yet unclassified' stamp: 'nme 10/22/2018 20:54:42'!
visitAccountFor: anAccount
	lines add: (baseString, (names at: anAccount)).! !

!SummarizingVisitor methodsFor: 'as yet unclassified' stamp: 'nme 10/22/2018 20:54:00'!
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

!SummarizingVisitor class methodsFor: 'as yet unclassified' stamp: 'nme 10/22/2018 20:55:55'!
of: aPortfolio with: names
	^ self new initializeOf: aPortfolio with: names.! !


!classDefinition: #SummarizingVisitorReverse category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #SummarizingVisitorReverse
	instanceVariableNames: 'lines names baseString portfolio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!SummarizingVisitorReverse methodsFor: 'as yet unclassified' stamp: 'nme 10/22/2018 20:53:52'!
initializeOf: aPortfolio with: aDictionaryOfNames
	portfolio _ aPortfolio.
	names _ aDictionaryOfNames.! !

!SummarizingVisitorReverse methodsFor: 'as yet unclassified' stamp: 'nme 10/22/2018 20:54:29'!
leafTraversal
	
	lines _ OrderedCollection new.
	baseString _ String new.
	portfolio accept: self.
	^ lines.
	! !

!SummarizingVisitorReverse methodsFor: 'as yet unclassified' stamp: 'nme 10/22/2018 20:54:46'!
visitAccountFor: anAccount
	lines add: (baseString, (names at: anAccount)).! !

!SummarizingVisitorReverse methodsFor: 'as yet unclassified' stamp: 'nme 10/22/2018 20:56:22'!
visitPortfolioFor: aPortfolio
	
	baseString _ ((String new: ((baseString size) + 1)) atAllPut: $ ).
	aPortfolio accountsReverseDo: [ :account | account accept: self].
	baseString _ ((String new: ((baseString size) - 1)) atAllPut: $ ).

	lines add: (baseString, (names at: aPortfolio)).
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SummarizingVisitorReverse class' category: #'PortfolioTreePrinter-Ejercicio'!
SummarizingVisitorReverse class
	instanceVariableNames: ''!

!SummarizingVisitorReverse class methodsFor: 'as yet unclassified' stamp: 'nme 10/22/2018 20:55:59'!
of: aPortfolio with: names
	^ self new initializeOf: aPortfolio with: names.! !


!classDefinition: #Transfer category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #Transfer
	instanceVariableNames: 'value depositLeg withdrawLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Transfer methodsFor: 'as yet unclassified' stamp: 'nme 10/22/2018 12:22:34'!
depositLeg

^ depositLeg.! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'nme 10/22/2018 12:27:40'!
initializeOf: anAmount

	value _ anAmount.
	depositLeg _ TransferDeposit relatedTo: self.
	withdrawLeg _ TransferWithdraw relatedTo:self.! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'nme 10/22/2018 12:43:13'!
value

	^ value.! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'nme 10/22/2018 12:22:27'!
withdrawLeg

	^withdrawLeg.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: #'PortfolioTreePrinter-Ejercicio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'as yet unclassified' stamp: 'nme 10/22/2018 12:45:40'!
of: anAmount

	^self new initializeOf: anAmount .! !

!Transfer class methodsFor: 'as yet unclassified' stamp: 'nme 10/22/2018 12:21:01'!
registerFrom:fromAccount to:toAccount for:anAmount 



	| transfer| 
	
	transfer _ self of:anAmount.
	fromAccount register: transfer withdrawLeg.
	toAccount register: transfer depositLeg.
	
	^transfer! !
