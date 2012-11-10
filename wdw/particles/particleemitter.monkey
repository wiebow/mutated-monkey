
Strict

Import particle
Import particlesystem


Interface ParticleEmitter
	
	Method Update:Void(system:ParticleSystem)
	
	Method Completed:Bool()
	
	Method WrapUp:Void()
	
	Method UpdateParticle:Void(p:Particle)
	
	Method Enabled:Bool() Property
	
	Method Enabled:Void(value:Bool) Property
	
	Method UseAdditive:Void(value:Bool)

	Method GetImage:Image()
	
	Method IsOriented:Bool()
	
	Method UsePoints:Bool()
	
	Method ResetState:Void()

End Interface

