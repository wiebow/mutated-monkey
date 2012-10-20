
'unit tests for wdw.tools.rectangle

Strict

Import wdw.unittest
Import wdw.tools.rectangle
Import wdw.tools.vector2d


Class RectTest Extends Test
	
	Field r:Rectangle
	
	Method doBefore:Void()
		r = New Rectangle
	End
	
	Method doAfter:Void()
		r = Null
	End
	
	
	Method IsEmptyTest:Void()
		assertTrue(r.IsEmpty(), "")
	End Method
	
		
	Method PositionTest:Void()
		r.SetPosition(10.0, 15.0)
		assertEquals(10.0, r.x, "x")
		assertEquals(15.0, r.y, "y")
	End Method
	
	
	Method DimensionTest:Void()
		r.SetDimension(50.0, 10.0)
		assertEquals(50.0, r.width, "w")
		assertEquals(10.0, r.height, "h")
	End Method
	
	
	Method PointInsideTest:Void()
		r.SetPosition(0, 0)
		r.SetDimension(50, 50)
		
		'inside
		Local p:= New Vector2D(10, 10)
		assertTrue(r.PointInside(p), "Is inside")
		
		'outside
		p.Set(-10, 10)
		assertFalse(r.PointInside(p), "Is outside")
	End Method
	
	
	Method ContainsTest:Void()		
		r.SetPosition(0, 0)
		r.SetDimension(100, 100)
		
		'inside
		Local r2:= New Rectangle(10, 10, 50, 50)
		assertTrue(r.ContainsRectangle(r2), "Inside")

		'not inside (outside)
		r2.SetPosition(200, 200)
		assertFalse(r.ContainsRectangle(r2), "Outside")
		
		'not inside (overlapping)
		r2.SetPosition(-10, -10)
		assertFalse(r.ContainsRectangle(r2), "Overlapping")
	End Method

	
	Method IntersectTest:Void()
		r.SetPosition(0, 0)
		r.SetDimension(50, 50)
		
		'intersect		
		Local r2:= New Rectangle(20, 20, 50, 50)
		assertTrue(r.IntersectsRectangle(r2), "Intersects")
		
		'no intersect
		r2.SetPosition(100, 100)
		assertFalse(r.IntersectsRectangle(r2), "No Intersect")
	End Method
	
End