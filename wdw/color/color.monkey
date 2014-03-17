
Strict

Import mojo

'summary: Color and Alpha class.
Class Color

	Private
	
	'summary: Red component.
	Field _r:Int
	
	'summary: Green component.
	Field _g:Int
	
	'summary: Blue component.
	Field _b:Int
	
	'summary: Alpha component.
	Field _a:Float
	
	Public
	
	Method New()
		_r = 255
		_g = 255
		_b = 255
		_a = 1.0
	End Method
	
	
	'summary: Default constructor.
	Method New(red:Int, green:Int, blue:Int, alpha:float)
		_r = red
		_g = green
		_b = blue
		_a = alpha
	End
		
	
	'summary: Sets all components.
	Method Set:Void(red:Int, green:Int, blue:Int, alpha:float)
		_r = red
		_g = green
		_b = blue
		_a = alpha
	End
		
		
	Method r:Int() Property
		Return _r
	End
	
	Method r:Void(red:Int) Property
		_r = red
	End
		
	Method g:Int() property
		Return _g
	End
	
	Method g:Void(green:Int) Property
		_g = green
	End
	
	Method b:Int() property
		Return _b
	End
	
	Method b:Void(blue:Int) Property
		_r = blue
	End
	
	Method a:Float() property
		Return _a
	End
    
    Method a:Void(alpha:Float) Property
        _a = alpha
    End
	    
	
	'summary: Uses the color and alpha values.
	Method Use:Void()
		SetColor(_r, _g, _b)
		SetAlpha(_a)
	End
	
End