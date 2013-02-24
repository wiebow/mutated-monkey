
Strict
Import mojo
Import wdw.framework.fwengine
Import wdw.framework.fwgame


'summary: 2D Framework engine Class.
Class fwEngine Extends App

Public

	#Rem
	summary: Creates a new engine.
	Default update rate is 60 hertz.
	#end
	Method New(g:fwGame, rate:Int = 60)
		currentGame = g
		updateRate = rate
	End Method

	
	'summary: Returns the engine pause mode.
	Method Paused:Bool() Property
		Return isPaused
	End
		
	
	'summary: Sets the engine pause mode.
	Method Paused:Void(value:Bool) Property
		isPaused = value
	End
	
	
	'summary: Returns true if the engine is running.
	Method Running:Bool() Property
		Return isRunning
	End
			
	
	'summary: Sets the engine running value.
	Method Running:Void(value:Bool) Property
		isRunning = value
	End
	
	
	'Sets the current game.	
	Method Game:Void(g:fwGame) Property
		currentGame = g
	End
	
		
	'summary: Sets the engine update rate.	
	Method Rate:Void(rate:Int) Property
		updateRate = rate
	End
		

Private

	Field updateRate:Int = 60
	Field currentGame:fwGame
	Field isPaused:Bool
	Field isRunning:Bool


	Method OnCreate:Int()
		If currentGame = Null Then Error("No Game present!")
		currentGame.Initialize()
		
		SetUpdateRate(updateRate)
		isRunning = True
		isPaused = False
		Return 0
	End Method
	
	
	Method OnUpdate:Int()
		If isRunning = True
			If isPaused = False Then currentGame.Update()
			If currentGame.CloseRequested = True Then Shutdown()
		End
		Return 0
	End Method
		
	
	Method OnRender:int()
		currentGame.Render()
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
		
End
