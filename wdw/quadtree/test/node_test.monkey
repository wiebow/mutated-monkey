
'unit tests for quadtreenode item

Strict

Import wdw.unittest
Import wdw.quadtree.node

Class NodeTest Extends Test

	Field i:QuadTreeNode

	
	Method doBefore:Void()
		i = New QuadTreeNode()
	End Method
	
	Method doAfter:Void()
		i = Null
	End Method
	
	Method ConstructorTest:Void()
		assertNotNull(i, "")
	End Method

	
End Class