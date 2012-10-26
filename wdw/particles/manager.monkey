
Strict

Import particle
Import wdw.tools.bag

Const PARTICLE_POOL_SIZE:Int = 100


'summary: Simple particle manager.
Class ParticleManager
	
	Private

	Field available:Bag<Particle>
	Field active:Bag<Particle>
	
	Public

	
	'summary: Constructor.
	Method New(poolSize:Int = PARTICLE_POOL_SIZE)
		active = New Bag<Particle>(poolSize)
		available = New Bag<Particle>(poolSize)
		
		'create pool of particles
		For Local i:Int = 0 To available.Capacity() -1
			available.Add(New Particle)
		End For
	End Method
	
	
	'summary: Updates all in-use particles.
	Method Update:Void()
		For Local index:Int = 0 To active.Size() -1
			Local particle:= active.Get(index)
			
			Local finished:Bool = particle.Update()
			If finished
				active.RemoveByIndex(index)
				available.Add(particle)
			End If
		End For
		
	End Method
	
	
	'summary: Renders all in-use particles.
	Method Render:Void()
		
	End Method
	
	
	'summary: Returns an available particle from the pool.
	'or Null if no particle is available.
	'Particle is added to the active bag.
	Method GetParticle:Particle()
		Local lastIndex:Int = available.Size() -1
		If lastIndex = 0 Then Return Null
		
		Local particle:= available.Get(lastIndex)
		If particle
			available.RemoveByIndex(lastIndex)
			active.Add(particle)
			Return particle
		End If
		Return Null
	End Method
	
	
	Method CleanUp:Void()
		available = Null
		inuse = Null
	End Method
	
	
	Method Active:Bag<Particle>() Property
		Return active
	End Method
	
	
	Method Available:Bag<Particle>() Property
		Return available
	End Method

End Class

'example particle effects creation functions

'Function CreateExplosion(x:Float, y:Float, amount:Float, force:Float)
'End Function

