
'unit tests for quadtree item

Strict

Import wdw.unittest
Import wdw.quadtree.item

Class ItemTest Extends Test

	Field i:QuadTreeItem

	
	Method doBefore:Void()
		i = New QuadTreeItem(0, 0, 100, 100)
	End Method
	
	Method doAfter:Void()
		i = Null
	End Method
	
	
	Method ConstructorTest:Void()
		assertNotNull(i, "No Item")
		assertNotNull(i.BoundingBox, "No Rectangle")
		assertNotNull(i.Position, "No Position")
	End Method
	
End Class