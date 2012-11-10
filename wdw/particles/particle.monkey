
Strict

Import particlesystem
Import wdw.tools.color

'summary: Particle class.
Class Particle
	
	Private
	
	Field engine:ParticleSystem
	
	Field emitter:ParticleEmitter
	
	Field posX:Float
	Field posY:Float
	
	Field velX:Float
	Field velY:Float
	
	Field color:Color
	
	Field life:Int
	
	Field originalLife:Int
	
	Field image:Image
	
	Field type:Int
	
	Field oriented:Bool
	
	Field scaleY:Float
	
	Field size:Float
		
	Public
	
	
	'summary: Constructor.
	Method New(ps:ParticleSystem, em:ParticleEmitter)
		engine = ps
		emitter = em
		color = New Color
	End Method
	
	
	Method Render:Void()
		PushMatrix
		
		Translate(posX, posY)

		color.Use()
		
		If engine.UsePoints = True
			DrawPoint(posX, posY)
			Return
		End If
	
		If oriented
			Local angle:Float = ATan2(posX, posY) * 180 / PI
			Rotate(angle)
		Else
			Rotate(0)
		End If
		
		Scale(size)
		
		DrawImage(image, posX, posY, 0)
	
		PopMatrix
	End Method
	
	
	Method Update:Void()
	
		'emitter performs the updates for size, color, animation, etc.
		emitter.UpdateParticle(Self)
		
		life -= 1
		If live > 0
			posX += velX
			posY += velY
		Else
			engine.Release(Self)
		End If
		
	End Method
		
		
	Method x:Float() Property
		Return posX
	End Method
	
	
	Method x:Void(value:Float) Property
		posX = value
	End Method
	
	
	Method y:Float() Property
		Return posY
	End Method
	
	
	Method y:Void(value:Float) Property
		posY = value
	End Method
		
		
	Method SetImage:Void(i:Image)
		image = i
	End Method
	
	
	Method InUse:Bool()
		Return life > 0
	End Method
	
	
	Method Life:Void(value:Int) Property
		life = value
	End Method
	
	
	Method Life:Int() Property
		Return life
	End Method
	
		
	Method Kill:Void()
		life = 1
	End Method
	
	
	Method GetOriginalLife:Int()
		Return originalLife
	End Method
	
	
	Method Size:Void(amount:Float) Property
		size = amount
	End Method
	
	
	Method Size:Float() Property
		Return size
	End Method
	
	
	Method AdjustSize:Void(amount:Float)
		size += amount
	End Method

		
	Method SetColor:Void(r:Int, g:Int, b:Int, a:float)
		color.Set(r, g, b, a)
	End Method
	
	
	Method GetColor:Color()
		Return color
	End Method
	
	
	Method AdjustColor:Void(r:Int, g:Int, b:Int, a:Float)
		color.Set(color.r + r, color.g + g, color.b + b, color.a + a)
	End Method
	
	
	Method SetPosition:Void(x:Float, y:Float)
		posX = x
		posY = y
	End Method
	
	
	Method AdjustPosition:Void(dx:Float, dy:Float)
		posX += dx
		posY += dy
	End Method
	
	
	Method SetSpeed:Void(speed:Float)
		Local currentSpeed:Float = Sqrt( (velX * velX) + (velY * velY))
		velX *= speed
		velY *= speed
		velX /= currentSpeed
		velY /= currentSpeed
	End Method
	
	
	Method SetVelocity:Void(vx:Float, vy:Float)
		velX = vx
		velY = vy
	End Method
	
	
	Method AdjustVelocity:Void(dx:Float, dy:Float)
		velX += dx
		velY += dy
	End Method
	
	
	Method Emitter:ParticleEmitter() Property
		Return emitter
	End Method
	
	
	Method Type:Int() Property
		Return type
	End Method
	
	
	Method Type:Void(t:Int) Property
		type = t
	End Method
	
	
	Method Oriented:Void(value:Bool) Property
		oriented = value
	End Method
	
	
	Method Oriented:Bool() Property
		Return oriented
	End Method
	
	
	Method ScaleY:Float() Property
		Return scaleY
	End Method
	
	
	Method ScaleY:Void(sy:Float) Property
		scaleY = sy
	End Method
		
End Class
