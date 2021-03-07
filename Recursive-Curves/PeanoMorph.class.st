"
""I represent a PeanoMorph to draw a Peano curve using parameters order and length"".

""Instance variables:
  - order : the order of the recursion : from 0 to ... 
  - length : the length of one side of the peano curve in pixels 
  - angle : the direction of the line when drawing 
  - point : the starting position of the algorithm is set at (0 @ 0)
  - points : the calculated points that are set to the PolygonMorph vertex array
  - ninetyDegrees : pi/2
""

"
Class {
	#name : #PeanoMorph,
	#superclass : #PolygonMorph,
	#instVars : [
		'order',
		'length',
		'angle',
		'points',
		'point',
		'ninetyDegrees'
	],
	#category : #'Recursive-Curves'
}

{ #category : #calculations }
PeanoMorph >> curveWithOrder0: aLength [
	"draw the curve with order 0 which is a line of length aLength"

	self drawLine: aLength
]

{ #category : #calculations }
PeanoMorph >> curveWithOrder1: aLength angle: anAngle [
	"draw the curve with order 1"

	| lengthDividedBy3 |
	lengthDividedBy3 := aLength / 3.
	self curveWithOrder0: lengthDividedBy3.
	self curveWithOrder0: lengthDividedBy3.
	self turn: anAngle.
	self curveWithOrder0: lengthDividedBy3.
	self turn: anAngle.
	self curveWithOrder0: lengthDividedBy3.
	self curveWithOrder0: lengthDividedBy3.
	self turn: -1 * anAngle.
	self curveWithOrder0: lengthDividedBy3.
	self turn: -1 * anAngle.
	self curveWithOrder0: lengthDividedBy3.
	self curveWithOrder0: lengthDividedBy3
]

{ #category : #calculations }
PeanoMorph >> curveWithOrder2AndMore: anOrder length: aLength angle: anAngle [
	"draw the curve with order > 1"

	| lengthDividedBy3 |
	lengthDividedBy3 := aLength / 3.
	self
		curveWithOrder: anOrder - 1
		length: lengthDividedBy3
		angle: anAngle.
	self curveWithOrder0: aLength / (3 raisedTo: anOrder).
	self
		curveWithOrder: anOrder - 1
		length: lengthDividedBy3
		angle: -1 * anAngle.
	self curveWithOrder0: aLength / (3 raisedTo: anOrder).
	self
		curveWithOrder: anOrder - 1
		length: lengthDividedBy3
		angle: anAngle.
	self turn: anAngle.
	self curveWithOrder0: aLength / (3 raisedTo: anOrder).
	self turn: anAngle.
	self
		curveWithOrder: anOrder - 1
		length: lengthDividedBy3
		angle: -1 * anAngle.
	self curveWithOrder0: aLength / (3 raisedTo: anOrder).
	self
		curveWithOrder: anOrder - 1
		length: lengthDividedBy3
		angle: anAngle.
	self curveWithOrder0: aLength / (3 raisedTo: anOrder).
	self
		curveWithOrder: anOrder - 1
		length: lengthDividedBy3
		angle: -1 * anAngle.
	self turn: -1 * anAngle.
	self curveWithOrder0: aLength / (3 raisedTo: anOrder).
	self turn: -1 * anAngle.
	self
		curveWithOrder: anOrder - 1
		length: lengthDividedBy3
		angle: anAngle.
	self curveWithOrder0: aLength / (3 raisedTo: anOrder).
	self
		curveWithOrder: anOrder - 1
		length: lengthDividedBy3
		angle: -1 * anAngle.
	self curveWithOrder0: aLength / (3 raisedTo: anOrder).
	self
		curveWithOrder: anOrder - 1
		length: lengthDividedBy3
		angle: anAngle
]

{ #category : #calculations }
PeanoMorph >> curveWithOrder: anOrder length: aLength angle: anAngle [
	"recursive drawing of the peano curve"

	anOrder == 0
		ifTrue: [ self curveWithOrder0: aLength ].
	anOrder == 1
		ifTrue: [ self curveWithOrder1: aLength angle: anAngle ].
	anOrder > 1
		ifTrue:
			[ self curveWithOrder2AndMore: anOrder length: aLength angle: anAngle ]
]

{ #category : #calculations }
PeanoMorph >> drawLine: aLength [
	"add a line with length using angle as direction"

	| newX newY newPoint |
	newX := aLength * angle cos.
	newY := aLength * angle sin.
	newPoint := point + (newX @ newY) asIntegerPoint.
	points add: newPoint.
	point := newPoint
]

{ #category : #calculations }
PeanoMorph >> generatePoints [
	"generate the points for a peano curve with length and order"

	points add: point.
	self turn: ninetyDegrees.
	self curveWithOrder: order length: length angle: -1 * ninetyDegrees.
	self setVertices: points
]

{ #category : #initialization }
PeanoMorph >> initialize [
	"initialize the instance variables with default values"

	super initialize.
	self beStraightSegments.
	self makeOpen.
	self lineColor: Color white.
	self lineWidth: 2.
	self order: 0.
	self length: 0.
	points := OrderedCollection new.
	angle := 0.
	point := 0 @ 0.
	ninetyDegrees := Float halfPi
]

{ #category : #accessing }
PeanoMorph >> length [
	"return the length in pixels for the peano curve"

	^ length
]

{ #category : #accessing }
PeanoMorph >> length: anInteger [
	"set the length in pixels for the peano curve"

	length := anInteger
]

{ #category : #accessing }
PeanoMorph >> order [
	"return the order of the peano curve"

	^ order
]

{ #category : #accessing }
PeanoMorph >> order: anInteger [
	"set the order of the peano curve"

	order := anInteger
]

{ #category : #calculations }
PeanoMorph >> turn: aFloat [
	"turn the angle of the drawing line with aFloat (+/-90 degrees) and guarantee the angle to be in the range [0..2*pi]"

	angle := angle + aFloat rem: Float pi * 2
]
