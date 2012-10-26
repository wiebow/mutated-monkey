
Strict

Import wdw.tools.vector2d
Import wdw.tools.color

'Import mojo

'summary: Particle class.
Class Particle

	Private
	
'	Global image:Image = LoadImage()
'	Global frames:Image[10]
	
	
	Field position:Vector2D
	Field previousPosition:Vector2D
	Field velocity:Vector2D
	
	Field friction:Float
	Field rgba:Color
	
	Public
	
	
	'summary: Constructor.
	Method New()
		position = New Vector2D
		previousPosition = New Vector2D
		rgba = New Color(255, 255, 255, 1.0)
		friction = 0.0
	End Method
	
	
	'summary: Set friction value for this particle.
	Method Friction:Void(value:Float) Property
		friction = 1.0 - value
	End Method
	
	
	Method SetPosition:Void(x:Float, y:Float)
		position.Set(x, y)
		previousPosition.Set(x, y)
	End Method
	
	
	Method SetVelocity:Void(angle:Float, speed:Float)
		velocity.Set(Sin(angle) * speed, -Cos(angle) * speed)
	End Method
			
	
	Method Update:Bool()
		previousPosition.Copy(position)
		position.Add(velocity)
		velocity.Multiply(friction)
	End Method
		
End Class

