
'unit tests for quadtreenode item

Strict

Import wdw.unittest
Import wdw.quadtree.node

Class NodeTest Extends Test

	Field n:QuadTreeNode

	
	Method doBefore:Void()
		n = New QuadTreeNode(0, 0, 100, 100, Null, 50)
	End Method
	
	Method doAfter:Void()
		n = Null
	End Method
	
	Method ConstructorTest:Void()
		assertNotNull(n, "")
	End Method
	
	
	Method SetAreaTest:Void()
		n.SetArea(10, 5, 50, 15)
		assertEquals(10.0, n.Area.x, "rect x")
		assertEquals(5.0, n.Area.y, "rect y")
		assertEquals(50.0, n.Area.width, "rect w")
		assertEquals(15.0, n.Area.height, "rect h")
	End
	
	
	Method MaxItemsTest:Void()
		n.MaxItems = 10
		assertEquals(10, n.MaxItems, "maxitems")
	End
	
	
	Method PartitionTest:Void()
		n.SetArea(0, 0, 100, 200)
		n.Partition()
		
		'the node should now contain 4 new nodes
		assertNotNull(n.Nodes[0], "node 0")
		assertNotNull(n.Nodes[1], "node 1")
		assertNotNull(n.Nodes[2], "node 2")
		assertNotNull(n.Nodes[3], "node 3")
		
		'parents should be set
		assertSame(n, n.Nodes[0].ParentNode, "parent 0")
		assertSame(n, n.Nodes[1].ParentNode, "parent 1")
		assertSame(n, n.Nodes[2].ParentNode, "parent 2")
		assertSame(n, n.Nodes[3].ParentNode, "parent 3")
		
		'node 0 should be rect: 0,0,50,100
		assertEquals(0.0, n.Nodes[0].Area.x, "rect0, x")
		assertEquals(0.0, n.Nodes[0].Area.y, "rect0, y")
		assertEquals(50.0, n.Nodes[0].Area.width, "rect0, w")
		assertEquals(100.0, n.Nodes[0].Area.height, "rect0, h")

		'node 1 should be rect: 50,0,50,100
		assertEquals(50.0, n.Nodes[1].Area.x, "rect1, x")
		assertEquals(0.0, n.Nodes[1].Area.y, "rect1, y")
		assertEquals(50.0, n.Nodes[1].Area.width, "rect1, w")
		assertEquals(100.0, n.Nodes[1].Area.height, "rect1, h")

		'node 2 should be rect: 0,100,50,100
		assertEquals(0.0, n.Nodes[2].Area.x, "rect2, x")
		assertEquals(100.0, n.Nodes[2].Area.y, "rect2, y")
		assertEquals(50.0, n.Nodes[2].Area.width, "rect2, w")
		assertEquals(100.0, n.Nodes[2].Area.height, "rect2, h")
		
		'node 3 should be rect: 50,100,50,100
		assertEquals(50.0, n.Nodes[3].Area.x, "rect3, x")
		assertEquals(100.0, n.Nodes[3].Area.y, "rect3, y")
		assertEquals(50.0, n.Nodes[3].Area.width, "rect3, w")
		assertEquals(100.0, n.Nodes[3].Area.height, "rect3, h")
	End
	
	
	Method InsertItemTest:Void()
		Local i:QuadTreeItem = New QuadTreeItem(10, 10, 5, 5)
		n.InsertItem(i)
		assertTrue(n.Items.Contains(i), "item not added!")
		
		'item parent should be the test node.
		assertSame(i.Parent, n, "parent not set")
	End
	
	
	Method InsertItemOnlyOnceTest:Void()
		Local i:QuadTreeItem = New QuadTreeItem(10, 10, 5, 5)
		n.InsertItem(i)
		n.InsertItem(i)
		assertEquals(1, n.Items.Count(), "added twice!")
	End
	
	
	Method InsertItemToPartitionedNodeTest:Void()
		n.SetArea(0, 0, 100, 100)
		n.Partition()
		
		Local i:= New QuadTreeItem(10, 60, 10, 10)
		n.InsertItem(i)
		
		'item should be added to a leaf node, not to this node
		assertFalse(n.Items.Contains(i), "should be in leaf")
		'should be in node[2]
		assertTrue(n.Nodes[2].Items.Contains(i), "should be in node 2")
	End Method
	
	
	Method MoveItemTest:Void()
		n.SetArea(-100, -100, 200, 200)
		n.Partition()
		
		Local i:= New QuadTreeItem(50, 50, 10, 10)
		n.InsertItem(i)
		
		'should be in node[3] (bottomright)
		assertTrue(n.Nodes[3].Items.Contains(i), "should be in node 3")
			
		'lets modify item position and then move it.
		i.Update(50, -50)
		n.Nodes[3].MoveItem(i)
		
		'should now be in node[1] (topright)
		assertTrue(n.Nodes[1].Items.Contains(i), "should be in node 1")
		assertFalse(n.Nodes[3].Items.Contains(i), "should not be in node 3 anymore")
		
	End Method
	
End Class