
Strict

Import wdw.unittest
Import wdw.particles.particle


Class ParticleTest Extends Test
	
	Field p:Particle
	
	Method DoBefore:Void()
		p = New Particle(Null, Null)
	End Method
	
	Method DoAfter:Void()
		p = Null
	End Method
	
	
	Method ConstructorTest:Void()
		assertNotNull(p, "")
	End Method
	
	
	Method PositionTest:Void()
		p.x = 100.0
		p.y = 200.0
		assertEquals(100.0, p.x, "x")
		assertEquals(200.0, p.y, "y")
		
		p.AdjustPosition(5, 5)
		assertEquals(105.0, p.x, "x2")
		assertEquals(205.0, p.y, "y2")
		
		p.SetPosition(200, 100)
		assertEquals(200.0, p.x, "x3")
		assertEquals(100.0, p.y, "y3")
	End Method
	
	
	Method LifeTest:Void()
		p.Life = 100
		assertEquals(100, p.Life, "life")
		assertTrue(p.InUse(), "in use")
		
		p.Kill()
		assertEquals(1, p.Life, "kill")
	End Method
	
	
	Method SizeTest:Void()
		p.Size = 200.0
		assertEquals(200.0, p.Size, "size")
		
		p.AdjustSize(10.0)
		assertEquals(210.0, p.Size, "adjust size")
	End Method
	
	
	Method ColorTest:Void()
		p.SetColor(100, 200, 150, 0.5)
		Local c:Color = p.GetColor()
		assertEquals(100, c.r, "red")
		assertEquals(200, c.g, "green")
		assertEquals(150, c.b, "blue")
		assertEquals(0.5, c.a, "alpha")
		
		p.AdjustColor(5, 5, 5, 0.1)
		assertEquals(105, c.r, "red2")
		assertEquals(205, c.g, "green2")
		assertEquals(155, c.b, "blue2")
		assertEquals(0.6, c.a, "alpha2")		
	End Method
	
	
	Method TypeTest:Void()
		p.Type = 202
		assertEquals(202, p.Type, "type")
	End Method
	
	
	Method ScaleYTest:Void()
		p.ScaleY = 200.0
		assertEquals(200.0, p.ScaleY, "scaley")
	End Method

	
	Method OrientedTest:Void()
		p.Oriented = True
		assertTrue(p.Oriented, "oriented")
	End Method
	

End Class

