
Strict
Import mojo
Import wdw.tools.bag
Import state
Import state.transition.emptytransition
Import autofit


'summary: A state based game, with transitions.
Class fwGame extends App

	Private
	
	'The title of this game.
	Field title:String = "Powered by wdw.framework."
	
	'Engine uses this to determine if the game should shut down.	
	Field closeRequested:Bool
	
	'Collection of game states, by index.
	Field gameStates:= New Bag<State>
		
	'The current game state.
	Field currentState:State
	
	'The state we will be going to.
	Field nextState:State
	
	'The transtion to play when leaving this state.
	Field leaveTransition:Transition
	
	'The transition to play when entering this state.
	Field enterTransition:Transition

	'Game update rate	
	Field updateRate:Int = 60
	
	Field isPaused:Bool
	Field isRunning:Bool
'	Field usingVirtualResolution:Bool
	
	
	Public

	'virtual game resolution, not physical resolution
'	Field gameWidth:Int
'	Field gameHeight:Int



	#Rem
	summary: Creates a new engine.
	Default update rate is 60 hertz.
	#end
	Method New(rate:Int = 60)
		updateRate = rate
	End Method

	
	'summary: Returns the game pause mode.
	Method Paused:Bool() Property
		Return isPaused
	End
		
	
	'summary: Sets the game pause mode.
	Method Paused:Void(value:Bool) Property
		isPaused = value
	End
	
	
	'summary: Returns true if the game is running.
	Method Running:Bool() Property
		Return isRunning
	End
			
	
	'summary: Sets the game running value.
	Method Running:Void(value:Bool) Property
		isRunning = value
	End
	
		
	'summary: Sets the game update rate.	
	Method Rate:Void(rate:Int) Property
		updateRate = rate
	End



	Method OnCreate:Int()
		Self.Initialize()
		SetUpdateRate(updateRate)
		isRunning = True
		isPaused = False
		Return 0
	End Method
	
	
	Method OnUpdate:Int()
		If isRunning = True
			If isPaused = False Then Self.Update()
			If Self.CloseRequested = True Then Self.Shutdown()
		End
		Return 0
	End Method
		
	
	Method OnRender:int()
		Self.Render()
		Return 0	
	End Method
	
		
	'Called when the engine is suspended.	
	Method OnSuspend:Int()
		isPaused = True
		Return 0
	End
		
	
	'Called when the engine is resuming.
	Method OnResume:Int()
		isPaused = False
		Return 0
	End
	
		
	'Called when the app is loading resources.
	Method OnLoading:Int()
		Return 0
	End
	
	
	
	Method Shutdown:Void()
		
	End
	
	
	Method GetUpdateRate:Int()
		Return updateRate
	End Method

	
	#rem
	summary: User hook to perform game startup logic.
	Called when the game is started.
	#end
	Method Initialize:Void()
	End
	
	
	'summary: Returns the game title.		
	Method Title:String() Property
		Return title
	End
	
	
	'summary: Sets the game title.
	Method Title:Void(newTitle:String) Property
		title = newTitle
	End
	
	
	'summary: Sets the close requested flag.
	Method CloseRequested:Void(b:Bool) Property
		closeRequested = b
	End
	
	
	'summary: Returns true if the game needs to be closed.
	Method CloseRequested:Bool() Property
		Return closeRequested
	End
	
	
	Method Update:Void()
		currentState.Update()
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
	End
		
	
	'renders the current game state.
	Method Render:Void()
'		If usingVirtualResolution Then UpdateVirtualDisplay()
		
		currentState.Render()
		If leaveTransition
			leaveTransition.Render()
		ElseIf enterTransition
			enterTransition.Render()
		EndIf
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
	Method GetCurrentStateID:Int()
		Return currentState.Id
	End
		
	
	'summary: Returns game state by specified ID.
	Method GetStateByID:State(id:Int)
		Return gameStates.Get(id)
	End
	
	
	Method SetGameResolution:Void(width:Int, height:Int)
'		SetVirtualDisplay(width, height)
'		usingVirtualResolution = True
	End Method
	
End
