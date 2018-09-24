!classDefinition: #CantSuspend category: #'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: #'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: 'customerBook paulMcCartney'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'toolsForTests' stamp: 'NME 9/23/2018 20:49:39'!
assertActiveCustomers: activeCustomersToAssert suspendedCustomers: suspendedCustomersToAssert totalCustomers: totalToAssert

	self assert: activeCustomersToAssert equals: customerBook numberOfActiveCustomers.
	self assert: suspendedCustomersToAssert equals: customerBook numberOfSuspendedCustomers.
	self assert: totalToAssert equals: customerBook numberOfCustomers.
! !

!CustomerBookTest methodsFor: 'toolsForTests' stamp: 'NME 9/23/2018 20:59:26'!
setUp
	
	customerBook :=  CustomerBook new.! !

!CustomerBookTest methodsFor: 'toolsForTests' stamp: 'NME 9/21/2018 21:59:26'!
should: aBlockToRun takeLessThan: timeToCompare in:measureOfTime

	| millisecondsBeforeRunning millisecondsAfterRunning |
	
	
	millisecondsBeforeRunning := Time millisecondClockValue * measureOfTime.
	aBlockToRun value.
	millisecondsAfterRunning := Time millisecondClockValue * measureOfTime.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < (timeToCompare*measureOfTime)! !

!CustomerBookTest methodsFor: 'toolsForTests' stamp: 'NME 9/22/2018 00:08:10'!
should:aClosure throw:errorType asserting:assertionsToCheck
	
	[ aClosure value.
	self fail ]
		on: errorType 
		do: assertionsToCheck. ! !


!CustomerBookTest methodsFor: 'testing' stamp: 'NME 9/23/2018 20:55:50'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	self should:[customerBook addCustomerNamed: 'John Lennon'] takeLessThan: 50 in:millisecond.
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'NME 9/23/2018 20:57:04'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| paulMcCartney |
	
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	
	self should: [customerBook removeCustomerNamed: paulMcCartney] takeLessThan: 100 in: millisecond.
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'NME 9/23/2018 20:56:41'!
test03CanNotAddACustomerWithEmptyName 
	
	self should: [customerBook addCustomerNamed: '']
	throw: Error 
	asserting: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'NME 9/23/2018 20:57:18'!
test04CanNotRemoveAnInvalidCustomer
	
	| johnLennon |
			
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self should: [customerBook removeCustomerNamed: 'Paul McCartney']
	 throw:NotFound
	asserting: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]


! !

!CustomerBookTest methodsFor: 'testing' stamp: 'NME 9/23/2018 20:57:26'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self assertActiveCustomers: 0 suspendedCustomers: 1 totalCustomers: 1.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'NME 9/23/2018 20:57:34'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	
	self assertActiveCustomers: 0 suspendedCustomers: 0 totalCustomers: 0.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'NME 9/23/2018 20:57:42'!
test07CanNotSuspendAnInvalidCustomer
	
	| johnLennon |
			
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self should:[ customerBook suspendCustomerNamed: 'Paul McCartney'] 
		throw:CantSuspend 
		asserting:[ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'NME 9/23/2018 20:57:50'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| johnLennon |
			
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	self should:[customerBook suspendCustomerNamed: johnLennon]
		 throw:CantSuspend 
		 asserting:[ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NME 9/23/2018 20:12:49'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NME 9/23/2018 20:12:49'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NME 9/23/2018 20:12:49'!
initialize

	super initialize.
	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'NME 9/23/2018 20:12:49'!
addCustomerNamed: aName

	self checkIfItIsAValidName: aName.
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NME 9/22/2018 00:35:00'!
checkIfItIsAValidName: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ]! !

!CustomerBook methodsFor: 'customer management' stamp: 'NME 9/23/2018 20:12:49'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NME 9/23/2018 20:12:49'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NME 9/23/2018 20:22:36'!
removeCustomerNamed: aName 
 
	active remove: aName ifAbsent: [suspended remove: aName ifAbsent: [NotFound signal]].

	
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NME 9/23/2018 20:12:49'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/6/2011 17:57'!
customerAlreadyExistsErrorMessage

	^'Customer already exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/6/2011 17:53'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty'! !
