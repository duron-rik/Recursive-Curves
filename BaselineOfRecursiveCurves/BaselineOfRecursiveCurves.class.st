"
BaseLineOfRecursiveCurves defines the dependencies for the project Recursive-Curves
"
Class {
	#name : #BaselineOfRecursiveCurves,
	#superclass : #BaselineOf,
	#category : #BaselineOfRecursiveCurves
}

{ #category : #baselines }
BaselineOfRecursiveCurves >> baseline: spec [
	<baseline>
	spec for: #common do: [ spec package: 'Recursive-Curves' ]
]
