
Strict

Import mojo


'summary: Fixed timer, used for desktop target.
Class fwFixedTime

	Private
	
	Field accumulator:Float
	Field deltaTime:Float
	Field time:Int
	
	Public


	Method New(freq:Int)
		Self.SetFrequency(freq)
	End Method


	Method SetFrequency:Void(f:Int)
		deltaTime = 1000.0 / f
	End Method


	Method Reset:Void()
		time = Millisecs()
		accumulator = 0.0
	End Method


	Method Update:Void()
		Local thistime:Int = Millisecs()
		Local passedtime:Int = thistime - time
		time = thistime
		accumulator += passedtime
	End Method


	Method TimeStepNeeded:Bool()
		If accumulator >= deltaTime
			accumulator -= deltaTime
			Return True
		End If
		Return False
	End Method

	
	Method GetTweening:Float()
		Return accumulator / deltaTime
	End Method	
	
End Class
