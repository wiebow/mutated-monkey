
' This sample shows how to create a simple state based game.

Strict
Import wdw.framework
Import wdw.framework.autofit


Const STATE_TITLESTATE:Int = 0
Const STATE_PLAYSTATE:Int = 1
Const STATE_ENDSTATE:Int = 2


Function Main:Int()
	Local e:= New fwEngine(New MyGame, 60)
	Return 0
End


Class MyGame Extends fwGame

	Method Initialize:Void()
		Title = "Simple Game"
		
		'load resources
		Image.DefaultFlags = Image.MidHandle
		fwResources.StoreImageFrames("mypic", LoadImage("monkey://data/mannetje.png"), 32, 32)
'		frResources.StoreImageFrames("tiles", LoadImage("monkey://data/tiles.png"), 32, 32)
		
		'create states
		AddGameState(New TitleState, STATE_TITLESTATE)
		AddGameState(New PlayState, STATE_PLAYSTATE)
		AddGameState(New EndState, STATE_ENDSTATE)
		
		'set game resolution
	'	SetGameResolution(320, 240)
	End Method
End Class



Class TitleState Extends State

	Field frames:Image[]
	Field currentFrame:Int
	
	
	Method New()
		frames = fwResources.GetImageFrames("mypic")
	End Method
	
	
	Method Enter:Void()
		currentFrame = 0
	End Method


	Method Render:Void()
		Cls(255, 255, 255)
		SetColor(0, 255, 0)
		SetAlpha(1.0)
		DrawText("This is the title screen", 0, 0)
		DrawText("Press SPACE to start", 0, 20)
		
		SetColor 255, 255, 255
		Scale 2, 2
		DrawImage(frames[currentFrame], 100, 100)
	End Method
	
	
	Method Update:Void()
		If TouchHit()
			Game.EnterState(STATE_PLAYSTATE, New FadeInTransition, New FadeOutTransition)
		End If
		
		If KeyHit(KEY_RIGHT) Then currentFrame += 1
		If currentFrame = 8 Then currentFrame = 0
	End Method


	Method Leave:Void()
	End Method
End Class


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
'		DrawRect(VMouseX() -10, VMouseY() -10, 20, 20)
		
'		DrawRect(xpos - 10, ypos - 10, 20, 20)
	End Method
		
	
	Method Update:Void()
		If TouchHit()
			Game.EnterState(STATE_ENDSTATE, New FadeInTransition, New FadeOutTransition)
		End If
		
		If KeyDown(KEY_UP) Then ypos -= 4
		If KeyDown(KEY_DOWN) Then ypos += 4
		If KeyDown(KEY_LEFT) Then xpos -= 4
		If KeyDown(KEY_RIGHT) Then xpos += 4
		
	End Method
		

	Method Enter:Void()
	End Method
	
	
	Method Leave:Void()
	End Method
End Class


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
	
End Class