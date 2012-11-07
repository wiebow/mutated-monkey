
Strict

Import particle
Import wdw.tools.bag

Const PARTICLE_POOL_SIZE:Int = 100


'summary: Simple particle manager.
Class ParticleManager
	
	Private

	Field available:Bag<Particle>
	Field active:Bag<Particle>
	Field frames:Image[]
	
	Public

	
	'summary: Constructor.
	Method New(poolSize:Int = PARTICLE_POOL_SIZE)
		active = New Bag<Particle>(poolSize)
		available = New Bag<Particle>(poolSize)
	End Method
	
	
	'summary: Sets the particle image frames and create particle pool.
	Method Initialize:Void(imageFrames:Image[])
		frames = imageFrames
		
		'set global image field in particle Class
		Particle.SetImageFrames(frames)
		
		'create pool of particles
		'images are passed to particle.
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
'			EndIf
			End If
		End For
	End Method
	
	
	'summary: Renders all in-use particles.
	Method Render:Void()
		For Local i:Int = 0 To active.Size() -1
			active.Get(i).Render()
		End For
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
		active = Null
	End Method
	
	
	Method Active:Bag<Particle>() Property
		Return active
	End Method
	
	
	Method Available:Bag<Particle>() Property
		Return available
	End Method

End Class
