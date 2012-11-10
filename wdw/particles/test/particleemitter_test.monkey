
Strict

Import wdw.unittest
Import wdw.particles.particleemitter


Class ParticleTest Extends Test
	
	Field e:ParticleEmitter
	
	Method DoBefore:Void()
		e = New ParticleEmitter()
	End Method
	
	Method DoAfter:Void()
		e = Null
	End Method
	
	
	Method ConstructorTest:Void()
		assertNotNull(e, "")
	End Method
	
	
End Class

