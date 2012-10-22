
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
	End Method
	
	Method UpdateTest:Void()
		i.Update(50, 50)
		
		'bounding box topleft should be at 0,0
		assertEquals(0.0, i.BoundingBox.x, "x")
		assertEquals(0.0, i.BoundingBox.y, "y")		
		
		i.Update(100, 100)
		assertEquals(50.0, i.BoundingBox.x, "x1")
		assertEquals(50.0, i.BoundingBox.y, "y1")
	End
	
End Class