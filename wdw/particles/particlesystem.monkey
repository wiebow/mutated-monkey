
Strict

Import particle
Import particleemitter
Import wdw.tools.bag
Import wdw.tools.vector2d
Import mojo


Private


'static particle pool for emitters.
Class ParticlePool
	Field particles:Bag<Particle>
	Field available:Bag<Particle>
	
	Method New(system:ParticleSystem, maxParticles:Int)
		particles = New Bag<Particle>(maxParticles)
		available = New Bag<Particle>(maxParticles)
		
		For Local index:Int = 0 To particles.Size() -1
			particles.Add(New Particle(system))
		End For
		Self.Reset()
	End Method
	
	
	Method Reset:Void()
		available.Clear()
		For Local index:Int = 0 To particles.Size() -1
			available.Add(particles.Get(index))
		End For
	End Method

End Class


Public

#REM
summary: Particle System.
Emitters and Particles are created in a pool.
Emitters can be reconfigured with effects.
#END
Class ParticleSystem
	
	Private
	
	'particles are rendered as points when this is set to True.
	Field renderPoints:Bool = False

	'emitters in the system
	Field emitters:Bag<ParticleEmitter>
	
	'bag containing pools. index is emitter id.
	Field particlesByEmitter:Bag<ParticlePool>
	
	Field maxParticlesPerEmitter:Int = 100
	
	'emitters are removed from the system when they are complete when this is set to True.
	Field removeCompletedEmitters:Bool = False
	
	'dummy particle used when emitter has no more free particles.
	Field dummyParticle:Particle
	
	'the position where this system should be rendered.
	Field systemPosition:Vector2D
	
	'The system is visible when this is set to True.
	Field visible:Bool = True
	
	'default image for particles.
	Field defaultImage:Image
	
	'current system blend mode.
	Field blendMode:Int
	
	'the next free ID for new emitter.
	Field nextFreeEmitterID:Int = 0
	
	Public
	
	
	Method New()
		emitters = New Bag<Emitter>
		particlesByEmitter = New Bag<ParticlePool>
	End Method
	
	
	'summary: Constructor
	Method New(texture:Image, maxParticles:Int)
		sprite = texture
		maxParticlesPerEmitter = maxParticles
		dummyParticle = New Particle(system)
	End Method
	
	
	'summary: Reset the state of the system.
	Method Reset:Void()
		Local index:Int
		
		For index = 0 To particlesByEmitter.Size() -1
			particlesByEmitter.Get(index).Reset()
		End For
		
		For index = 0 To emitters.Size() -1
			emitters.Get(index).ResetState()
		End For
	End Method
	
	
	'summary: Returns true if the system if visible.
	Method Visible:Bool() Property
		Return visible
	End Method
	
	
	'summary: Sets system visibility flag.
	Method Visible:Void(value:Bool) Property
		visible = value
	End Method
	
	
	'summary: Emitters are deleted if this is set to True.
	Method RemoveCompletedEmitter:Void(value:Bool) Property
		removeCompletedEmitters = Value
	End Method
	
	
	Method UsePoints:Bool() Property
		Return renderPoints
	End Method
	
	
	Method UsePoints:Void(value:Bool) Property
		renderPoints = value
	End Method
	
	
	'summary: Returns system render blend mode.
	Method BlendMode:Bool() Property
		Return blendMode
	End Method
	
	
	'summary: Returns the number of emitters in the system.
	Method GetEmitterCount:Int()
		Return emitters.Size()
	End Method
	
	
	Method GetEmitter:ParticleEmitter(index:Int)
		Return emitters.Get(index)
	End Method
	
	
	'summary: Adds passed emitter to the system.
	Method AddEmitter:Void(e:ParticleEmitter)
		e.id = nextFreeEmitterID
		emitters.Set(nextFreeEmitterID, e)
		particlesByEmitter.Set(nextFreeEmitterID, New ParticlePool(Self, maxParticlesPerEmitter))
		nextFreeEmitterID += 1
	End Method
	
	
	'summary: Removes the emitter with passed ID from the system.
	Method RemoveEmitter:Void(e:ParticleEmitter)
		emitters.Set(e.Id, Null)
		particlesByEmitter.Set(e.id, Null)
	End Method
	
	
	'summary: Deletes all emitters (an their particles) from the system.
	Method RemoveAllEmitters:Void()
		For Local index:Int = 0 To emitters.Size() -1
			RemoveEmitter(emitters.Get(index))
		End For
		nextFreeEmitterID = 0
	End Method
	
	
	'summary: Returns the system render position.
	Method Position:Vector2D() Property
		Return systemPosition
	End Method
	
	
	'summary: Returns the X component of the system render position.
	Method PositionX:Float()
		Return systemPosition.x
	End Method
	
	
	'summary: Returns the Y component of the system render position.
	Method PositionY:Float()
		Return systemPosition.y
	End Method
	
	
	'summary: Sets the system render offset.
	Method SetPosition:Void(x:Float, y:Float)
		systemPosition.Set(x, y)
	End Method
	
	
	'summary: Renders the system.
	Method Render:Void()
		If Not visible Then Return
		
		Local pool:ParticlePool
		Local emitter:Emitter
		Local image:Image
		
		PushMatrix
				
		Translate(systemPosition.x, systemPosition.y)
		
		For Local index:Int = 0 To emitters.Size() -1			
			emitter = emitters.Get(index)
			pool = particlesByEmitter.Get(index)
			
			image = emitter.GetImage()
			If image = Null Then image = defaultImage
			
			'render the in use particles from emitter pool						
			For Local poolIndex:Int = 0 To pool.particles.Size() -1
				pool.particles.Get(poolIndex).Render()
			End For
					
		End For
		
		
		PopMatrix

	End Method
		
End Class
