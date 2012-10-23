
'unit tests for quadtree module

Strict

Import wdw.unittest
Import wdw.quadtree.tree

Class TreeTest Extends Test

	Field t:QuadTree
	
	Method doBefore:Void()
		t = New QuadTree(-100, -100, 200, 200)
	End Method
	
	Method doAfter:Void()
		t = Null
	End Method
	
	
	Method ConstructorTest:Void()
		assertNotNull(t, "not created!")
		assertNotNull(t.Area, "Area not present!")
		assertNotNull(t.Head, "Head node not present!")
		assertEquals(DEFAULT_MAX_ITEMS, t.MaxItems, "Maxitems")
	End Method
	
	
	Method SetMaxItemsTest:Void()
		t.MaxItems = 10
		assertEquals(10, t.MaxItems, "maxitems not set")
	End Method
	
	
	Method ResizeWorldTest:Void()
		Local i:= New QuadTreeItem(-150, -50, 10, 10)
		t.InsertItem(i)
		
		'world should be resized once.
		assertEquals(-200.0, t.Area.x, "x")
		assertEquals(-200.0, t.Area.y, "y")
		assertEquals(400.0, t.Area.width, "w")
		assertEquals(400.0, t.Area.height, "h")
	End Method
	
End Class