!classDefinition: #QueueTest category: #'Queue-Exercise'!
TestCase subclass: #QueueTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Queue-Exercise'!

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test01QueueShouldBeEmptyWhenCreated

	| queue |

	queue _ Queue new.

	self assert: queue isEmpty.! !

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test02EnqueueAddElementsToTheQueue

	| queue |

	queue _ Queue new.
	queue enqueue: 'Something'.

	self deny: queue isEmpty.! !

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test03DequeueRemovesElementsFromTheQueue

	| queue |

	queue _ Queue new.
	queue enqueue: 'Something'.
	queue dequeue.

	self assert: queue isEmpty.! !

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test04DequeueReturnsFirstEnqueuedObject

	| queue firstQueued secondQueued |

	queue _ Queue new.
	firstQueued _ 'Something1'.
	secondQueued _ 'Something2'.
	queue enqueue: firstQueued.
	queue enqueue: secondQueued.
	
	self assert: queue dequeue equals: firstQueued.! !

!QueueTest methodsFor: 'test' stamp: 'NME 10/3/2018 23:50:38'!
test05QueueBehavesFIFO

	| queue firstQueued secondQueued |

	queue _ Queue new.
	firstQueued _ 'First'.
	secondQueued _ 'Second'.
	queue enqueue: firstQueued.
	queue enqueue: secondQueued.

	self assert: queue dequeue equals: firstQueued.
	self assert: queue dequeue equals: secondQueued.
	self assert: queue isEmpty.! !

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test06NextReturnsFirstEnqueuedObject

	| queue firstQueued |

	queue _ Queue new.
	firstQueued _ 'Something'.
	queue enqueue: firstQueued.

	self assert: queue next equals: firstQueued.! !

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test07NextDoesNotRemoveObjectFromQueue

	| queue firstQueued |

	queue _ Queue new.
	firstQueued _ 'Something'.
	queue enqueue: firstQueued.

	queue next.
	self assert: queue size equals: 1.! !

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test08CanNotDequeueWhenThereAreNoObjectsInTheQueue

	| queue |

	queue _ Queue new.
	
	self
		should: [ queue dequeue ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Queue queueEmptyErrorDescription ].! !

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test09CanNotDequeueWhenThereAreNoObjectsInTheQueueAndTheQueueHadObjects

	| queue |

	queue _ Queue new.
	queue enqueue: 'Something'.
	queue dequeue.

	self
		should: [ queue dequeue ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Queue queueEmptyErrorDescription ].! !

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test10CanNotNextWhenThereAreNoObjectsInTheQueue

	| queue |

	queue _ Queue new.

	self
		should: [ queue next ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Queue queueEmptyErrorDescription ].! !


!classDefinition: #EmptyElement category: #'Queue-Exercise'!
Object subclass: #EmptyElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Queue-Exercise'!

!EmptyElement methodsFor: 'testing' stamp: 'NME 10/4/2018 00:33:42'!
isEmpty

	^true.! !


!EmptyElement methodsFor: 'accessing' stamp: 'NME 10/4/2018 00:10:49'!
next

	^self error: Queue queueEmptyErrorDescription! !

!EmptyElement methodsFor: 'accessing' stamp: 'NME 10/4/2018 00:10:40'!
size

	^0.! !


!EmptyElement methodsFor: 'removing' stamp: 'NME 10/4/2018 00:11:11'!
removeElement
	
	
	^self error: Queue queueEmptyErrorDescription! !


!EmptyElement methodsFor: 'adding' stamp: 'NME 10/4/2018 00:08:12'!
add:anElement
	^NonEmptyElement initializeWith: anElement and: self ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EmptyElement class' category: #'Queue-Exercise'!
EmptyElement class
	instanceVariableNames: ''!

!EmptyElement class methodsFor: 'as yet unclassified' stamp: 'NME 10/4/2018 00:46:27'!
isEmpty

^true.! !


!classDefinition: #NonEmptyElement category: #'Queue-Exercise'!
Object subclass: #NonEmptyElement
	instanceVariableNames: 'element next'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Queue-Exercise'!

!NonEmptyElement methodsFor: 'adding' stamp: 'NME 10/4/2018 00:02:21'!
add:anElement
	
	next:= NonEmptyElement initializeWith: anElement and: EmptyElement .
	^next! !


!NonEmptyElement methodsFor: 'initialization' stamp: 'NME 10/4/2018 00:02:51'!
initializeWith:anElement and:nextElement

	element :=anElement.
	next:= nextElement .! !


!NonEmptyElement methodsFor: 'testing' stamp: 'NME 10/4/2018 00:03:31'!
isEmpty
	
	^false.! !


!NonEmptyElement methodsFor: 'accessing' stamp: 'NME 10/4/2018 00:04:20'!
next

	^element! !

!NonEmptyElement methodsFor: 'accessing' stamp: 'NME 10/4/2018 00:04:34'!
size

	^1+ next size.! !


!NonEmptyElement methodsFor: 'removing' stamp: 'NME 10/4/2018 00:04:52'!
removeElement

	^next.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NonEmptyElement class' category: #'Queue-Exercise'!
NonEmptyElement class
	instanceVariableNames: ''!

!NonEmptyElement class methodsFor: 'initialization' stamp: 'NME 10/3/2018 20:28:44'!
initializeWith:anElement and: nextElement

	^self basicNew initializeWith: anElement and:nextElement .! !


!classDefinition: #Queue category: #'Queue-Exercise'!
Object subclass: #Queue
	instanceVariableNames: 'firstElement lastElement'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Queue-Exercise'!

!Queue methodsFor: 'accessing' stamp: 'NME 10/4/2018 00:01:32'!
next

	^firstElement next
	
	! !

!Queue methodsFor: 'accessing' stamp: 'NME 10/3/2018 20:01:42'!
size

	^firstElement size.! !


!Queue methodsFor: 'initialization' stamp: 'NME 10/3/2018 23:59:30'!
initializeWith: anElement

	firstElement := anElement .
	lastElement :=anElement .! !


!Queue methodsFor: 'removing' stamp: 'NME 10/4/2018 00:29:15'!
dequeue
	
	
	|elementToRemove|
	
	elementToRemove  := firstElement next.
	
	firstElement := firstElement removeElement.
	
	^elementToRemove ! !


!Queue methodsFor: 'testing' stamp: 'NME 10/4/2018 00:33:08'!
isEmpty
	
	^firstElement isEmpty
	
	
	! !


!Queue methodsFor: 'adding' stamp: 'NME 10/4/2018 00:00:02'!
enqueue: anElement
	
	|firstElementClass|
	
	firstElementClass  := firstElement class.
	
	(firstElementClass = EmptyElement) ifTrue: 
	[firstElement:= firstElement add:anElement.
		lastElement := firstElement].
	
	firstElementClass = NonEmptyElement ifTrue: 
	[lastElement := lastElement add:anElement.]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Queue class' category: #'Queue-Exercise'!
Queue class
	instanceVariableNames: ''!

!Queue class methodsFor: 'error descriptions' stamp: 'NME 10/3/2018 12:40:45'!
new

	^self basicNew initializeWith: EmptyElement new.! !

!Queue class methodsFor: 'error descriptions'!
queueEmptyErrorDescription
	^ 'Queue is empty'.! !
