
'2d vector class.

Strict

'summary: A 2d vector class.
Class Vector2D
	
	Private
	
	Field vx:Float
	Field vy:Float
	
	Public
	
	
	'summary: Creates a new vector with passed values.
	Method New(x:Float, y:Float)
		Self.vx = x
		Self.vy = y
	End	
	
	
	'summary: Returns a clone of this vector.
	Method Clone:Vector2D()	
		Local v:= new Vector2D
		v.vx = x
		v.vy = y
		Return v
	End	
	
	
	'summary: Copies the values from passed vector to this vector.
	Method Copy:Void(v:Vector2D)
		Self.vx = v.x
		Self.vy = v.y
	End	
	
	
	'summary: Sets this vector to passed values.
	Method Set:Void(x:Float, y:Float)
		Self.vx = x
		Self.vy = y
	End	
	
	
	'summary: Returns the value of X.
	Method x:Float() Property
		Return Self.vx
	End
	
		
	'summary: Sets the value of X.
	Method x:Void(x:Float) Property
		Self.vx = x
	End
	
		
	'summary: Sets the value of Y.
	Method y:Void(y:Float) Property
		Self.vy = y
	End
	
		
	'summary: Returns the value of Y.
	Method y:Float() Property
		Return Self.vy
	End
	
	
	'summary: Adds passed values to this vector.
	Method Add:Void(x:Float, y:Float)
		Self.vx += x
		Self.vy += y
	End	
	
	'summary: Adds passed vector to this vector.
	Method Add:Void(v:Vector2D)
		Self.vx += v.x
		Self.vy += v.y
	End
	
	'summary: Subtracts passed values from this vector.
	Method Subtract:Void(x:Float, y:Float)
		Self.vx -= x
		Self.vy -= y
	End	
	
	
	'summary: Subtracts passed vector from this vector.
	Method Subtract:Void(v:Vector2D)
		Self.vx -= v.x
		Self.vy -= v.y
	End
	
	
	'summary: Returns the length of this vector.
	Method Length:Float()
		Return Sqrt(Self.vx * Self.vx + Self.vy * Self.vy)
	End

		
	'summary: Divides this vector by passed value.
	Method Divide:Void(f:Float)
		If f = 0.0 Then Error( "Divide by 0!" )
		Self.vx /= f
		Self.vy /= f
	End

	
	'summary: Devides this vector by passed vector.
	Method Divide:Void(v:Vector2D)
		If v.x = 0.0 or v.y = 0.0 Then Error( "Divide by 0!" )
		Self.vx /= v.x
		Self.vy /= v.y
	End
		
	'summary: Multiplies this vector by passed value.
	Method Multiply:Void(f:Float)
		Self.vx *= f
		Self.vy *= f
	End
	
	'summary: Multiplies this vector by passed vector.
	Method Multiply:Void(v:Vector2D)
		Self.vx *= v.x
		Self.vy *= v.y
	End	
	
	'summary: Make this vector length = 1.0
	Method Normalize:Void()
		Divide( Length() )
	End

	'summary: Swaps values between this and passed vector.
	Method Swap:Void( v:Vector2D)
		Local temp:Float = Self.vx
		Self.vx = v.x
		v.x = temp
		
		temp = Self.vy
		Self.vy = v.y
		v.y = temp		
	End
	
		
	'summary: Returns the dot product of this and passed vector.
	Method Dot:Float( v:Vector2D )
		Return (Self.vx * v.x + Self.vy * v.y)
	End
	
	
	'summary: Returns the distance between this and passed vector.
	Method Distance:Float( v:Vector2D)
		Local dx:Float = Self.vx - v.x
		Local dy:Float = Self.vy - v.y
		Return Sqrt(dx*dx + dy*dy )	
	End
	
	
	#rem
	summary: Returns angle of vector rotation.
	Angle range is -180 to 180:
[code]
-135 -90 -45
    \ | /
+180 -+-  0
    / | \
+135 +90 +45
[/code]
	#end
	Method Rotation:Float()
		Return ATan2( y, x )
	End
	
	
	'summary: Rotates this vector with specified amount, origin = 0,0.
	Method Rotate:Void( theta:Float )
		Local cos:Float = Cos(theta)	
		Local sin:Float = Sin(theta)
		Local qx:Float = Self.vx * cos + Self.vy * sin
		Local qy:Float = -Self.vx * cos + Self.vy * cos
		Self.vx = qx
		Self.vy = qy
	End

	
	'summary: Rotates this vector with specified amount around passed vector.
	Method Rotate:Void( theta:Float, v:Vector2D )
		Local cos:Float = Cos(theta)	
		Local sin:Float = Sin(theta)
		Self.vx -= v.x
		Self.vy -= v.y
		Local qx:Float = Self.vx * cos + Self.vy * sin
		Local qy:Float = -Self.vx * cos + Self.vy * cos
		Self.vx = qx + v.x
		Self.vy = qy + v.y
	End
	
		
	'summary: Returns a string describing the vector.
	Method ToString:String()
		Return "(x: " + Self.vx + ", y: " + Self.vy + ")"
	End Method	

End