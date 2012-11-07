
Strict

Import mojo
Import wdw.tools.bag
Import state
Import state.transition.emptytransition
Import resources
Import wdw.particles


'summary: A state based game, with transitions.
Class Game

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
		
	Public
	
	
	#rem
	summary: User hook to perform game startup logic.
	Called when the game is started.
	#end
	Method Init:Void()
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
	
	
	'Updates the game.
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
			End
		End
		
		If enterTransition
			enterTransition.Update()
			If enterTransition.IsComplete()
				enterTransition = Null
			Else
				Return
			End
		End
		currentState.Update()
	End
		
	
	'renders the current game state.
	Method Render:Void()	
		currentState.Render()
				
		If leaveTransition
			leaveTransition.Render()
		ElseIf enterTransition
			enterTransition.Render()
		End
	End
	
		
	'Enter a gamestate with the specified transitions.
	Method EnterState:Void(id:Int, enter:Transition = Null, leave:Transition = Null)
		If Not enter Then enter = New EmptyTransition
		If Not leave Then leave = New EmptyTransition
		
		enterTransition = enter
		leaveTransition = leave
		
		nextState = GetStateByID(id)
		If Not _nextState Then Error("Cannot find state with ID: " + id)
		
		leaveTransition.Init()
	End
		
	
	'summary: Adds a state to this game. First state added becomes the current state.
	Method AddGameState:Void(s:State, id:Int)
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
	
End
