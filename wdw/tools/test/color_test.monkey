
'unit tests for wdw.tools.color

Strict

Import wdw.unittest
Import wdw.tools.color


Class ColorTest Extends Test
	
	Field c:Color
	
	Method doBefore:Void()
		c = New Color
	End
	
	Method doAfter:Void()
		c = Null
	End
	
	Method SetTest:Void()
		c.Set(255, 100, 50, 0.6)
		assertEquals(c.r, 255, "r")
		assertEquals(c.g, 100, "g")
		assertEquals(c.b, 50, "b")
		assertEquals(c.a, 0.6, "a")
	End	
	
End