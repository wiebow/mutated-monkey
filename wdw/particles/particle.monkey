
Strict

Import wdw.tools.vector2d
Import wdw.tools.color

'Import mojo

'summary: Particle class.
Class Particle

	Private
	
	Global imageFrames:Image[]
	
	Field position:Vector2D
	Field previousPosition:Vector2D
	Field velocity:Vector2D
	
	Field rotationAngle:Float
	Field scaleX:Float, scaleY:Float
	Field friction:Float
	Field rgba:Color
	Field blend:Int
	Field life:Int
	
	Field frame:Int
		
	Public
	
	
	'summary: Constructor.
	Method New()
		position = New Vector2D
		previousPosition = New Vector2D
		scaleX = 1.0
		scaleY = 1.0
		blend = AlphaBlend
		rgba = New Color(255, 255, 255, 1.0)
		friction = 0.0
		life = -1
	End Method
	
	
	'summary: Set friction value for this particle.
	Method Friction:Void(value:Float) Property
		friction = 1.0 - value
	End Method
	
	
	'summary: Sets the particle position.
	Method SetPosition:Void(x:Float, y:Float)
		position.Set(x, y)
		previousPosition.Set(x, y)
	End Method
	
	
	'summary: Sets the particle velocity.
	Method SetVelocity:Void(angle:Float, speed:Float)
		velocity.Set(Sin(angle) * speed, -Cos(angle) * speed)
	End Method
	
	
	Method Update:Bool()
		previousPosition.Copy(position)
		position.Add(velocity)
		velocity.Multiply(friction)
		
		If life > 0 Then life -= 1
		If rgba.a > 0.0
		
		End If
		
	End Method
	
	
	Method Render:Void()
		Rotate(rotationAngle)
		Scale(scaleX, scaleY)
		SetBlend(blend)
		rgba.Use()
		DrawImage(imageFrames[frame], position.x, position.y)
	End Method
	
	
	'summary: Sets the global particle image field.
	Function SetImageFrames:Void(img:Image[])
		imageFrames = img
	End Function
		
End Class

