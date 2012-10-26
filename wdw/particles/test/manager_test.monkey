
Strict

Import wdw.unittest
Import wdw.particles.manager


Class ManagerTest Extends Test

	Field m:ParticleManager
	
	Method doBefore:Void()
		m = New ParticleManager
	End Method
	
	Method doAfter:Void()
		m = Null
	End Method
	
	
	Method ContructorTest:Void()
		assertNotNull(m.Active, "no in use bag")
		assertNotNull(m.Available, " no available bag")
		
		assertEquals(100, m.Active.Capacity(), "inuse bag size not set")
		assertEquals(100, m.Available.Capacity(), "available bag size not set")		
	End Method
	
	
	Method GetParticleTest:Void()
		'check defaults
		assertEquals(100, m.Available.Size(), "no particle taken")
		assertEquals(0, m.Active.Size(), "no particle active!")
	
		Local p:Particle = m.GetParticle()
		assertNotNull(p, "no particle!")
		
		'available bag size should have one less particle
		assertEquals(99, m.Available.Size(), "particle taken")
		
		'one should be active now
		assertEquals(1, m.Active.Size(), "particle active!")	
	End Method
	
	
End Class