
' This sample shows how to create a simple state based game.

Strict

Import wdw.framework


Const STATE_TITLESTATE:Int = 0
Const STATE_PLAYSTATE:Int = 1
Const STATE_ENDSTATE:Int = 2


Function Main:Int()
	Local g:MyGame = New MyGame
	g.Title = "State Test"
	g.AddGameState(New TitleState, STATE_TITLESTATE)
	g.AddGameState(New PlayState, STATE_PLAYSTATE)
	g.AddGameState(New EndState, STATE_ENDSTATE)
	
	Local e:Engine = New Engine(g, 60)
	Return 0
End


Class MyGame Extends Game

	Method Init:Void()		
		Resources.StoreImage("mypic", LoadImage("objects.png", 7))
	End
End



Class TitleState Extends State

	Method Render:Void()
		Cls(255, 255, 255)
		SetColor(0, 255, 0)
		SetAlpha(1.0)
		DrawText("This is the title screen", 0, 0)
		DrawText("Press SPACE to start", 0, 20)
		
		DrawImage(Resources.GetImage("mypic"), 100, 100, 0)
		
	End Method
	
	
	
	Method Update:Void()
		If TouchHit()
			Game.EnterState(STATE_PLAYSTATE, New FadeInTransition, New FadeOutTransition)
		End If
	End Method
	
	
	
	Method Enter:Void()
	
		
	End Method

	Method Leave:Void()
	End Method
End


Class PlayState Extends State

	Field xpos:Int = 100
	Field ypos:Int = 100
	


	Method Render:Void()
		Cls(255, 255, 255)
		
		SetColor(0, 255, 0)
		SetAlpha(1.0)
		DrawText("This is the game screen", 0, 0)
		DrawText("Use ARROWS to move, SPACE to end", 0, 20)
		
		SetColor 255, 0, 0
		DrawRect(xpos - 10, ypos - 10, 20, 20)		
	End Method
	
	
	
	Method Update:Void()
		If TouchHit()
			Game.EnterState(STATE_ENDSTATE, New FadeInTransition, New FadeOutTransition)
		End If
		
		If KeyDown(KEY_UP) Then ypos -= 2
		If KeyDown(KEY_DOWN) Then ypos += 2
		If KeyDown(KEY_LEFT) Then xpos -= 2
		If KeyDown(KEY_RIGHT) Then xpos += 2		
		
	End Method
	
	

	Method Enter:Void()
	End Method
	
	Method Leave:Void()
	End Method
End


Class EndState Extends State

	Method Render:Void()
		Cls(255, 255, 255)
		SetColor(0, 255, 0)
		SetAlpha(1.0)
		DrawText("This is the last screen", 0, 0)
	End Method
		
	
	Method Update:Void()
		If TouchHit() Then Game.CloseRequested = True
	End Method
		
	
	Method Enter:Void()
	End Method
	
	
	Method Leave:Void()
	End Method
	
End