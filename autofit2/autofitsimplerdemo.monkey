
' A stripped-down demo that shows how you can treat a virtual resolution as
' if it's a fixed display size and simply hard-code your positions for that
' display size if you want to. It'll still be scaled to fit any size of
' device correctly.

Import mojo
Import autofit

Class Game Extends App

	Method OnCreate ()
		SetUpdateRate 60
		SetVirtualDisplay 800, 480
	End
	
	Method OnUpdate ()
	End
	
	Method OnRender ()
		
		UpdateVirtualDisplay
		
		Cls 32, 64, 96
		
		' All positions hard-coded for 800 x 480, so screen-centre is 400, 240...
		
		SetColor 255, 0, 0
		DrawLine 400, 240 - 5, 400, 240 + 5
		DrawLine 400 - 5, 240, 400 + 5, 240
		
		SetColor 255, 255, 255
		DrawRect 400 - 1, 240 - 1, 2, 2
		
		' Hard-coded text will be positioned correctly on any device,
		' regardless of its 'real' resolution...
		
		DrawText "This is an 800 x 480 display!", 590, 460

	End
	
End

Function Main ()
	New Game
End
