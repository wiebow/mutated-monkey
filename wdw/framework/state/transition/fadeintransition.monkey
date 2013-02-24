
Strict
Import transition
Import wdw.tools.color


'summary: A fade-in transition.
Class FadeInTransition Implements Transition


Public


	Method New(r:Int, g:Int, b:Int, a:Float)
		color.Set(r, g, b, a)
	End
	
	
	Method Init:Void()
		color.a = 1.0
		'1 sec
		transitionChange = 1.0 / UpdateRate()
	End

		
	Method Update:Void()
		color.a -= transitionChange
		If color.a < 0.0 Then color.a = 0.0
	End
	
	
	Method Render:Void()
		color.Use()
		SetBlend(AlphaBlend)
		SetAlpha(color.a)
			
		PushMatrix()
			Translate(0, 0)
			Rotate(0)
			Scale(1.0, 1.0)
			DrawRect(0, 0, DeviceWidth(), DeviceHeight())
		PopMatrix()
	End
	
	
	Method IsComplete:Bool()
		Return color.a <= 0.0
	End


Private

	
	Field color:Color = New Color(0, 0, 0, 1.0)
	Field transitionChange:Float
	
End