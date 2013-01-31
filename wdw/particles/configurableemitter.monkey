
Strict

Import particleemitter
Import range
Import value
Import wdw.tools.vector2d


Class ConfigurableEmitter Implements ParticleEmitter

	
	Private
	
	'how often does spawn happen
	Field spawnInterval:Range
	'how many particles are spawned each time?
	Field spawnCount:Range
	'initial life of the particles
	Field initialLife:Int
	'inital size of the particles
	Field initalSize:Int
	
	'draw offset
	Field xOffset:Int
	Field yOffset:Int
	
	'the spread of the particles
	Field spread:Int
	Field angularOffset:Int
	'initial distance of the particles
	Field initialDistance:Int
	'initial speed of the particles
	Field speed:Float
	
	'growth factor of the particles
	Field growthFactor:Float
	'gravity factor of the particles
	Field gravityFactor:Float
	'wind factor of the particles
	Field windFactor:Float
	
	'length of the effect
	Field length:Int
	'color range
	Field colors:Bag<Vector2D)
	
	'particle settings that can change over time
	Field startAlpha:LinearInterpolator
	Field endAlpha:LinearInterpolator
	Field velocity:LinearInterpolator
	Field scaleY:LinearInterpolator
		
	'the amount of particles that will be emitted
	Field emitCount:Int
	Field useOriented:Bool
	Field useAdditive:Bool
	
	
	Field name:String
	Field imageName:String
	Field image:Image
	'true if the image needs updating
	Field updateImage:Bool
	
	'true if the emitter is enabled
	Field enabled:Bool
	
	'position of emitter
	Field x:Float
	Field y:Float
	
	'the time (in updates) until next spawn
	Field nextSpawn:Int = 0
	'timeout counting down to spawn.
	Field timeOut:Int
	'particles in use by this emitter
	Field particleCount:Int
	'engine owning this emitter
	Field engine:ParticleSystem
	'particles left to emit
	Field leftToEmit:Int
	
	'true if we're wrapping up	
	Field wrapUp:Bool
	'true if the system has completed
	Field completed:Bool
	'true of we need to adjust particles for movement
	Field adjust:Bool
	'amount to adjust x and y
	Field adjustX:Float
	Field adjustY:Float
		
	Public
	


End Class