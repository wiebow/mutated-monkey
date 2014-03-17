
Strict

Import mojo
Import autofit2.autofit

Import wdw.bag
Import wdw.framework.state
Import wdw.framework.state.transition.emptytransition
Import wdw.framework.fwfixedtime
'Import wdw.framework.fwtext

'updating:
'app updaterate is set to 0. this will let the app 'run wild'
'so update rate is controlled with fwfixedtime.

'rendering:
'rendering is done as often as possible, using interpolated values.
'vsync is enabled.
'autofit2 is used to set up a virtual resolution for the game.
'url : monkeycoder.co.nz/Community/posts.php?topic=1500&page=1
'by default an 800x600 window is opened.
'the virtual resolution is by default the same as the pysical resolution



#rem
summary: A state based game, with transitions.
States are added by calling AddGameState().
Add user setup code in StartUp() method in extended class.
Add user cleanup code in the CleanUp() method in extended class.
#end
Class fwGame extends App

	Private
	
	'Engine uses this to determine if the game should shut down.	
	'Field closeRequested:Bool
	
	'Collection of game states, by index.
	Field gameStates:= New Bag<State>
		
	'The current game state.
	Field currentState:State
	
	'The state we will be going to.
	Field nextState:State
	
	'The transition to play when leaving this state.
	Field leaveTransition:Transition
	
	'The transition to play when entering this state.
	Field enterTransition:Transition
	
	'default update rate for a game is 60hz.
	Field updateRate:Int = 60
	Field fixedTime:fwFixedTime
	
	Field isPaused:Bool
	Field isRunning:Bool
	Field usingVirtualResolution:Bool
	
	'the current game font
'	Field gameFont:fwText
	
	
	Public
	
	'summary: Sets current game font.
'	Method GameFont:Void(f:fwText) Property
'		gameFont = f
'	End
	
	
	'summary: Draws text with the current game font.
'	Method DrawText:Void(text:String, x:Int, y:Int, centered:Bool = False, shadow:Bool = False)
'	
'		PushMatrix()
'		
'		If centered
'			Translate(Self.GetGameWidth(), 0)
'			Local lineWidth:Int = gameFont.charWidth * text.Length
'			x = -lineWidth / 2
'		End
'		
'		If shadow
'			Local colors:Float[] = GetColor()
'			SetColor(0, 0, 0)
'			gameFont.Print(text, x, y + 1)
'			SetColor(colors[0], colors[1], colors[2])
'		End
'		
'		gameFont.Print(text, x, y)
'		
'		PopMatrix()
'	End

	
		
	'summary: Sets the game update rate.	
	Method UpdateRate:Void(rate:Int) Property
		updateRate = rate
	End



	Method OnCreate:Int()
	
		'call user startup code
		Self.Startup()
		
		'set app game update rate to unlimited
		'so fixedtime can do its work and render is called as often as possible as well
		SetUpdateRate(0)
		
		'set fixed timer to wanted update rate
		Self.fixedTime = New fwFixedTime(Self.updateRate)
		
		'enable vsync
		SetSwapInterval(1)
		
		'create graphics window
		
		'do something with autofit
		
		
		'set runtime bools
		isRunning = True
		isPaused = False
		
		Return 0
	End Method
	
	
		
	'Called when the game is suspended.	
	Method OnSuspend:Int()
		isPaused = True
		Return 0
	End
		
	
	'Called when the game is resuming.
	Method OnResume:Int()
		isPaused = False
		Return 0
	End
	
		
	'Called when the game is loading resources.
	Method OnLoading:Int()
		Return 0
	End
	
	
	'Called when the game is shutting down.
	Method Shutdown:Void()
	End
	
	
	'summary: User hook to perform startup code. Called by OnCreate().
	Method Startup:Void()
	End
	
	
	'Enter a gamestate with the specified transitions.
	Method EnterState:Void(id:Int, enter:Transition = Null, leave:Transition = Null)
		If Not enter Then enter = New EmptyTransition
		If Not leave Then leave = New EmptyTransition
		enterTransition = enter
		leaveTransition = leave
		nextState = GetStateByID(id)
		If Not nextState Then Error("Cannot find state with ID: " + id)
		leaveTransition.Init()
	End
	
	
	'summary: Adds a state to this game. First state added becomes the current state.
	Method AddState:Void(s:State, id:Int)
		gameStates.Set(id, s)
		s.Game = Self
		s.Id = id
		If Not currentState Then currentState = s
	End
	
		
	'summary: Returns the ID of the current state.
'	Method GetCurrentStateID:Int()
'		Return currentState.Id
'	End
		
	
	'summary: Returns game state by specified ID.
'	Method GetStateByID:State(id:Int)
'		Return gameStates.Get(id)
'	End
	

	'summary: Sets the game physical screen.
	Method SetPhysicalResolution:Void(width:Int, height:Int, fullscreen:Bool = False, depth:Int = 0)
	
		#If TARGET="glfw"
			'Method SetGlfwWindow:Void( width:Int,height:Int,red:Int,green:Int,blue:Int,alpha:Int,depth:Int,stencil:Int,fullscreen:Bool )		
			'GlfwGame.GetGlfwGame().SetGlfwWindow(1024, 768, 8, 8, 8, 0, 0, 0, False 'Window 1024x768
			GlfwGame.GetGlfwGame().SetGlfwWindow(width, height, 8, 8, 8, 0, depth, 0, fullscreen) 'Window 1024x768
		#End
		
		#if TARGET = "xna"
'			XNAGame.GetXNAGame().SetXNAWindow		
		#end
		
	
	End
	
	
	'summary: Sets the game resolution, not the physical resolution.
	Method SetGameResolution:Void(width:Int, height:Int)
		SetVirtualDisplay(width, height)
		usingVirtualResolution = True
	End
	
	
	'summary: Returns the game horizontal resolution.
	Method GetGameWidth:Int()
		If usingVirtualResolution Then Return VDeviceWidth()
		Return DeviceWidth()
	End
	
	
	'summary: Returns the game vertical resolution.
	Method GetGameHeight:Int()
		If usingVirtualResolution Then Return VDeviceHeight()
		Return DeviceHeight()
	End
	
	
'#Region runtime

	'app main loop
	Method OnUpdate:Int()
		If isRunning = False Then Return 0
'		If Self.closeRequested = True Then Self.Shutdown()
	
		'update at set frequency
		If isPaused = False
			fixedTime.Update()
			While fixedTime.TimeStepNeeded()
				Self.Update()
			End While
		End If
						
		'check for pause
		'note:move pause check to control key
		If KeyHit(KEY_P)
			isPaused = Not isPaused
			If isPaused = False Then fixedTime.Reset()
		End If
		
		Return 0
	End Method
	
	
	'actual update method
	Method Update:Void()
		If leaveTransition
			leaveTransition.Update()
			If leaveTransition.IsComplete()
				currentState.Leave()
				currentState = nextState
				nextState = Null
				leaveTransition = Null
				currentState.Enter()
				If enterTransition Then enterTransition.Init()
			Else
				Return
			EndIf
		EndIf		
		If enterTransition
			enterTransition.Update()
			If enterTransition.IsComplete()
				enterTransition = Null
			Else
				Return
			EndIf
		EndIf
		currentState.Update()
	End Method
	
'#EndRegion 
	

	
	'app render method
	'uses autofit
	Method OnRender:Int()
		If usingVirtualResolution Then UpdateVirtualDisplay()
		Self.Render(fixedTime.GetTweening())
		Return 0
	End Method
	
	
	'actual render method
	Method Render:Void(tween:Float)
	
		'note: render: add entity manager here
			
		currentState.Render()
		If leaveTransition
			leaveTransition.Render()
		ElseIf enterTransition
			enterTransition.Render()
		EndIf

	End Method
	
End
