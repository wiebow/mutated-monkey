
Strict

'source: http://sol.gfxile.net/interpolation/
'awesome guide!

'interpolation modes
Const MODE_LINEAR:Int = 1
Const MODE_SMOOTHSTEP:Int = 2

'cycle restart options.
Const TYPE_PINGPONG:Int = 1
Const TYPE_STOP:Int = 2
Const TYPE_RESTART:Int = 2

Const STEP_FORWARD:Int = 1
Const STEP_BACKWARD:Int = 2


'summary: Interpolating value, with optional smooth step
Class InterpolatedValue
	
	Private
	
	Field min:Float
	Field max:Float
	Field currentValue:Float
	
	Field stepsAmount:Int
	Field currentStep:Int
	Field stepDirection:Int
	
	'interpolation value (0.0 to 1.0)
	Field v:Float
	
	Field active:Bool
	
	'current interpolation mode
	Field mode:Int
	
	'what to do when interpolation has finished
	Field restartType:Int
			
	Public
	
	
	'summary: Constructor
	Method New(minValue:Float, maxValue:Float, steps:Int, startStep:Int)
		min = minValue
		max = maxValue
		stepsAmount = steps
		currentStep = startStep
		stepDirection = STEP_FORWARD
		restartType = TYPE_STOP
		mode = MODE_LINEAR
		active = False
	End Method

	
	'summary: Updates the interpolated value.
	Method Update()
		If Not active Then Return
		
		v = currentStep / stepsAmount
		If mode = MODE_SMOOTHSTEP Then SmoothStep(v)
		
		currentValue = (min * v) + (max * (1.0 - v))
		
		'update the step position
		'and restart if needed.
		If stepDirection = STEP_FORWARD
			currentStep += 1
			If currentStep = stepsAmount
				Select restartType
					Case TYPE_PINGPONG stepDirection = STEP_BACKWARD
					Case TYPE_RESTART currentStep = 0
					Case TYPE_STOP active = False
				End Select
			End If
		ElseIf stepDirection = STEP_BACKWARD
			currentStep -= 1
			If currentStep = 0
				Select restartType
					Case TYPE_PINGPONG stepDirection = STEP_FORWARD
					Case TYPE_RESTART currentStep = stepsAmount
					Case TYPE_STOP active = False
				End Select
			End If
		End If
		
	End Method
	

	'smoothsteps passed value.
	Method SmoothStep:Float(x:Float)
    	Return x * x * (3 - 2 * x)
	End Method
	

	#REM
	summary: Sets the step direction.
	Accepted values: STEP_FORWARD, STEP_BACKWARD
	#END
	Method StepDirection:Void(value:Int) Property
		stepDirection = value
	End Method
	
	
	#REM
	summary: Sets the interpolation restart type.
	Accepted values: TYPE_PINGPONG, TYPE_STOP, TYPE_RESTART
	#END	
	Method RestartType:Void(value:Int) Property
		restartType = value
	End Method
	
	
	'summary: Returns the current interpolated value.
	Method Value:Float() Property
		Return currentValue
	End Method

	
	'summary: Sets the current interpolation step.
	Method CurrentStep:Void(value:Int) Property
		currentStep = value
	End Method
	
	
	'summary: Interpolation is running when this is set to True.
	Method Active:Void(value:Bool) Property
		active = value
	End Method
	
	
End Class