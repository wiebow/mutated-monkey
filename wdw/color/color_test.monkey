
'unit tests for wdw.color

Strict

Import wdw.unittest
#REFLECTION_FILTER+="*_test"

Import wdw.color

Function Main:Int()
	Local t:= New TestSuite
	t.Run()
	Return 0
End



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