
'Strict ' Optional here. AutoFit itself is now Strict though...

Import mojo

' Needed for autofit to work...

Import autofit

' -----------------------------------------------------------------------------
' Demo...
' -----------------------------------------------------------------------------

' All drawing can be hard-coded for a given size (1440 x 900 in this demo),
' but will automatically scale as required to the current device size (which
' is 640 x 480 in this demo). Nice!

' -----------------------------------------------------------------------------
' Tips!
' -----------------------------------------------------------------------------

' RESIZING DEVICES: HTML5

' To see example of game adapting to device size changes in realtime, build
' for HTML5 target, open project/project.build/html5/main.js and change:

#rem
				var RESIZEABLE_CANVAS=false;
		
						... to:
				
				var RESIZEABLE_CANVAS=true;
		
#end

' ... then launch game in your web browser and try resizing its window.

' RESIZING DEVICES: ANDROID

' To adapt game to rotation of Android device (can be simulated with Ctrl-F11 in
' Android SDK emulator), open project/project.build/android/CONFIG.TXT and change:

#rem
				SCREEN_ORIENTATION=portrait
		
						... to:
				
				SCREEN_ORIENTATION=sensor
		
#end

Class Game Extends App

	' Variables for demo...
	
	Field touching:Int
	Field touchedx:Float
	Field trackx:Float
	
	Method OnCreate:Int ()

		' Set VIRTUAL display size...

		SetVirtualDisplay 1440, 900

		SetUpdateRate 60

		Return 0

	End

	Method OnUpdate:Int ()

		' -----------------------------------------------------------------
		' Drag to zoom, tap to reset zoom level...
		' -----------------------------------------------------------------
		
		' Not sure of the logic here, but seems to work! Uses REAL touch
		' positions rather than VIRTUAL positions to retrieve input...
		
		If TouchDown (0)
			trackx = TouchX (0)
			If Not touching
				touching = True
				touchedx = trackx
			Endif
		Else
			If touching
				touching = False
				If Abs (trackx - touchedx) < 4
					SetVirtualZoom 1.0 ' Reset zoom...
				Endif
			Endif
		Endif

		If touching
			AdjustVirtualZoom (TouchX (0) - touchedx) * 0.0001
		Endif
		
		' (SetVirtualZoom sets to given zoom; AdjustVirtualZoom
		' modifies the current zoom by the amount specified.)
		
		Return 0

	End

	Method OnRender:Int ()

		' -----------------------------------------------------------------
		' Called at start of OnRender...
		' -----------------------------------------------------------------
		
		UpdateVirtualDisplay
		
		Cls 32, 32, 32

		' -----------------------------------------------------------------
		' Draw a load of junk...
		' -----------------------------------------------------------------
		
		' Corners. Note use of VDeviceWidth/VDeviceHeight instead of
		' DeviceWidth/DeviceHeight...
		
		SetColor 255, 0, 0
		DrawRect 0, 0, 32, 32

		SetColor 0, 255, 0
		DrawRect (VDeviceWidth () - 1) - 32, 0, 32, 32

		SetColor 0, 0, 255
		DrawRect 0, (VDeviceHeight () - 1) - 32, 32, 32

		SetColor 255, 0, 0
		DrawRect (VDeviceWidth () - 1) - 32, (VDeviceHeight () - 1) - 32, 32, 32
		
		' Borders...
		
		SetColor 255, 0, 0
		DrawLine 0, 0, VDeviceWidth () - 1, 0
		SetColor 0, 255, 0
		DrawLine 0, VDeviceHeight () - 1, VDeviceWidth () - 1, VDeviceHeight () - 1
		SetColor 0, 0, 255
		DrawLine 0, 0, 0, VDeviceHeight () - 1
		SetColor 255, 255, 0
		DrawLine VDeviceWidth () - 1, 0, VDeviceWidth () - 1, VDeviceHeight () - 1

		' Centre/center...
		
		SetColor 32, 64, 128
		DrawRect (VDeviceWidth () / 2.0) - 18, (VDeviceHeight () / 2.0) - 18, 36, 36

		' Mouse (using VMouseX/VMouseY instead of MouseX/MouseY)...
		
		SetColor 255, 255, 255
		DrawRect VMouseX () - 16, VMouseY () - 16, 32, 32
'		DrawRect VTouchX () - 16, VTouchY () - 16, 32, 32 ' Alternative to above line

		' -----------------------------------------------------------------
		' Text info...
		' -----------------------------------------------------------------
		
		Scale 2, 2
		
		' Note that positions are all multiplied by the scale factor above - had
		' to do this to make things readable!
		
		DrawText "<- DRAG -> to ZOOM or [TAP] to RESET", 20, 20
		DrawText "Zoom: " + GetVirtualZoom (), 20, 40

		DrawText "Real device size: " + DeviceWidth () + " x " + DeviceHeight (), 20, 160
		DrawText "Virtual device size: " + VDeviceWidth () + " x " + VDeviceHeight (), 20, 180
		DrawText "Virtual mouse co-ords: " + Int (VMouseX ()) + " x " + Int (VMouseY ()), 20, 200
		
		Return 0

	End
	
End

Function Main:Int ()
	New Game
	Return 0
End
