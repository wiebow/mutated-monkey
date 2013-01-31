
'all kinds of classes to manipulate values with.
  
Strict

Import wdw.tools.vector2d
Import wdw.tools.bag
Import wdw.tools.color


Interface Value
	
	Method Value:Float() Property
	
End Interface


'summary: A configurable simple single value
Class SimpleValue Implements Value
	
	Private
	
	Field value:Float
	Field nextValue:Float
	
	Public
	
	
	Method New(v:Float)
		value = v
	End Method
	
	Method Value:Float() Property
		Return value
	End Method
	
	Method Value:Float(v:Float) Property
		value = v
	End Method

End Class


Class LinearInterpolator Implements Value

	Private
	'a curve contains vectors holding the point values
	'curve point x value is time/range, y value is value
	Field curve:Bag<Vector2D>
	Field active:Bool
	Field min:int
	Field max:Int

	Public

		
	Method New(newCurve:Bag<Vector2D>, minValue:Int, maxValue:Int)
		curve = newCurve
		min = minValue
		max = maxValue
		active = False
	End Method
	
	
	'time = 0..1
	Method GetValue:Float(time:Float)
	
		'determine the segment we're in
		Local p0:Vector2D = curve.Get(0)
		For Local i:Int = 1 To curve.Size() -1
			Local p1:Vector2D = curve.Get(i)
			If time >= p0.x And time <= p1.x
			
				'found the segment
				Local st:Float = (time - p0.x) / (p1.x - p0.x)
				Local r:Float = p0.y + st * (p1.y - p0.y)
				Return r
			End If
			p0 = p1
		End For
		Return 0
	End Method
	
	
	Method Curve:Void(newCurve:Bag<Vector2D>) Property
		curve = newCurve
	End Method
	
	
	Method Curve:Bag<Vector2D> Property
		Return curve
	End Method	
	
	
	Method Active:Bool() Property
		Return active
	End Method
	
	
	Method Active:Void(value:Bool) Property
		active = value
	End Method
	
	
	Method Min:Int() Property
		Return min
	End Method
	
	Method Min:Void(value:Int) Property
		min = value
	End Method
	
	
	Method Max:Int() Property
		Return max
	End Method
	
	
	Method Max:Void(value:Int) Property
		max = value
	End Method

End Class



'summary: A single element in the color range of this emitter.
Class ColorRecord
	
	Field pos:Float
	Field clr:Color

	'summary: position: position in the life cycle (0.0 is start, 1.0 = end)
	Method New(position:Float, color:Color)
		pos = position
		clr = color
	End Method

End Class
