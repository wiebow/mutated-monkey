
Strict

Import wdw.unittest
Import wdw.particles.manager


Class ManagerTest Extends Test

	Field m:ParticleManager
	
	Method doBefore:Void()
		m = New ParticleManager(10)
	End Method
	
	
	Method doAfter:Void()
		m = Null
	End Method
	
	
	Method ContructorTest:Void()
		assertNotNull(m.Active, "no in use bag")
		assertNotNull(m.Available, " no available bag")
		
		assertEquals(10, m.Active.Capacity(), "inuse bag size not set")
		assertEquals(10, m.Available.Capacity(), "available bag size not set")
	End Method
	
	
	Method CleanupTest:Void()
		m.CleanUp()
		assertNull(m.Active, "not cleaned")
		assertNull(m.Available, "not cleaned!")		
	End Method
	
	
	Method GetParticleTest:Void()
		Local img:Image[] = New Image[1]
		m.Initialize(img)
		'check defaults
		assertEquals(10, m.Available.Size(), "no particle taken")
		assertEquals(0, m.Active.Size(), "no particle active!")
	
		Local p:Particle = m.GetParticle()
		assertNotNull(p, "no particle!")
		
		'available bag size should have one less particle
		assertEquals(9, m.Available.Size(), "particle taken")
		
		'one should be active now
		assertEquals(1, m.Active.Size(), "particle active!")
	End Method
	
	
End Class

