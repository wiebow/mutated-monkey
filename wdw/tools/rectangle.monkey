
Strict

Import vector2d


'summary: 2d Rectangle
Class Rectangle
	
	Private
	
	Field position:Vector2D
	Field dimension:Vector2D
	
	Public
	
	
	Method New()
		Self.position = New Vector2D
		Self.dimension = New Vector2D
	End Method
	
	
	#REM
	summary: Creates a new rect using passed position and dimension.
	Optionally centers the rectangle on the position.
	#END
	Method New(x:Float, y:Float, w:Float, h:Float, centered:Int = False)
		Self.position = New Vector2D
		Self.dimension = New Vector2D
		Self.SetDimension(w, h)
		If centered
			Self.SetPosition(x - w / 2, y - w / 2)
		Else
			Self.SetPosition(x, y)
		End If
	End Method
	
	
	
	'summary: Sets the rectangle position.
	Method SetPosition:Void(x:float, y:float)
		Self.position.Set(x, y)
	End Method
	
	
	'summary: Sets the rectangle dimension.
	Method SetDimension:Void(w:Float, h:Float)
		Self.dimension.Set(w, h)
	End Method
	
	
	'summary: Returns top left X value.
	Method x:Float() Property
		Return Self.position.x
	End Method
	
	
	'summmary: Returns top left Y value.
	Method y:Float() Property
		Return Self.position.y
	End Method
	
	
	'summary: Returns width of rectangle.
	Method width:Float() Property
		Return Self.dimension.x
	End Method
	
	
	'summary: Returns height of rectangle.
	Method height:Float() Property
		Return Self.dimension.y
	End Method

	
	'summary: Returns true if passed coordinates are inside this rectangle.
	Method XYInside:Bool(x:Float, y:Float)
		Return x >= Self.x And x <= Self.x + Self.width And y >= Self.y And y <= Self.y + Self.height
	End Method
	
	
	'summary: Returns true if passed vector point is inside this rectangle.	
	Method PointInside:Bool(p:Vector2D)
		Return p.x >= Self.x And p.x <= Self.x + Self.width And p.y >= Self.y And p.y <= Self.y + Self.height
	End Method
	
	
	'returns true if this rectangle contains passed rectangle.
	Method ContainsRectangle:Bool(r:Rectangle)
		Return (r.x >= Self.x) And (r.x + r.width <= Self.x + Self.width) And (r.y >= Self.y) And (r.y + r.height <= Self.y + Self.height)	
	End Method
	
	
	'returns true if this rectangle overlaps passed rectangle.
	Method IntersectsRectangle:Bool(r:Rectangle)
		Return (Self.x + Self.width >= r.x) And (Self.y + Self.height >= r.y) And (Self.x <= r.x + r.width) And (Self.y <= Self.y + r.height)
	End Method
	
	
	'summary: Returns true if the rectangle has no dimension.
	Method IsEmpty:Bool()
		Return (Self.width = 0) or (Self.height = 0)
	End Method
	
	
	'summary: Returns a string describing the rectangle.
	Method ToString:String()
		Return "(x: " + Self.x + ", y: " + Self.y + ", w: " + Self.width + ", h: " + Self.height + ")"
	End Method

End Class