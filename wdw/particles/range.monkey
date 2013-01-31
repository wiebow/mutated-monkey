
Strict

'A simple range value.
Class Range
	
	Private
	
	Field max:Float
	Field min:Float
	Field enabled:Float = True
	
	Public
	
	
	Method New(minValue:Float, maxValue:Float)
		min = minValue
		max = maxValue
	End Method
	
	
	Method Random:Float()
		Return Rnd(min, max)
	End Method
	
	
	Method Enabled:Bool() Property
		Return enabled
	End Method
	
	
	Method Enabled:Void(value:Bool) Property
		enabled = value
	End Method
	
	
	Method Min:Float() Property
		Return min
	End Method
	
	
	Method Min:Float(value:Float) Property
		min = value
	End Method
	
	
	Method Max:Float() Property
		Return max
	End Method
	
	
	Method Max:Void(value:float) Property
		max = value
	End Method
	
End Class
