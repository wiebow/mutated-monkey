
Strict

Import mojo
Import wdw.tools.vector2d


Class fwDigitalTouchStick
	Field held:Bool
	Field radius:Int
	Field directionRadius:Int
	Field touchID:Int
	Field origin:Vector2D
	Field vector:Vector2D
	Field leftLocation:Vector2D
	Field rightLocation:Vector2D
	Field upLocation:Vector2D
	Field downLocation:Vector2D
	Field up:Bool
	Field down:Bool
	Field left:Bool
	Field right:Bool
	
	
	Method New(stickRadius:Int)
		radius = stickRadius
		directionRadius = radius * 0.7
		origin = New Vector2D
		vector = New Vector2D
		leftLocation = New Vector2D
		rightLocation = New Vector2D
		upLocation = New Vector2D
		downLocation = New Vector2D
	End Method
	
	
	Method Update:Void()
		If Not held
			Start()
		Else
			If TouchDown(touchID)
				vector.Set(TouchX(touchID), TouchY(touchID))
				If vector.Distance(leftLocation) < directionRadius
					left = True; right = False
					up = False; down = False
				ElseIf vector.Distance(rightLocation) < directionRadius
					left = False; right = True
					up = False; down = False
				ElseIf vector.Distance(upLocation) < directionRadius
					left = False; right = False
					up = True; down = False
				ElseIf vector.Distance(downLocation) < directionRadius
					left = False; right = False
					up = False; down = True
				Else
					left = False; right = False
					up = False; down = False
				EndIf
				
				vector.Subtract(origin)
				If vector.Length() > radius
					Local move:= vector.Clone()
					move.Normalize()
					move.Multiply(vector.Length() -radius)
					origin.Add(move.x, move.y)
					leftLocation.Add(move.x, move.y)
					rightLocation.Add(move.x, move.y)
					upLocation.Add(move.x, move.y)
					downLocation.Add(move.x, move.y)
				End If
			Else
				Stop()
			EndIf
		EndIf
	End Method
	
	
	Method Render:Void()
		If Not held Return
		PushMatrix()
		SetAlpha 0.5
		Scale(1, 1)
		Rotate(0)
		SetColor 255, 255, 255

		If left = True Then SetAlpha 0.75
		DrawCircle(leftLocation.x, leftLocation.y, directionRadius)

		SetAlpha 0.5
		If right = True Then SetAlpha 0.75
		DrawCircle(rightLocation.x, rightLocation.y, directionRadius)

		SetAlpha 0.5
		If up = True Then SetAlpha 0.75
		DrawCircle(upLocation.x, upLocation.y, directionRadius)

		SetAlpha 0.5
		If down = True Then SetAlpha 0.75
		DrawCircle(downLocation.x, downLocation.y, directionRadius)

		SetColor 255, 255, 255
		DrawText("left:" + int(left) + " right:" + int(right) + " up:" + int(up) + " down:" + int(down), 0, 30)
		
		PopMatrix()
	End Method
	
	
	Method Start:Void()
		For Local i:= 0 To 32
			If TouchDown(i)
				held = True
				touchID = i
				origin.Set(TouchX(i), TouchY(i))
				leftLocation.Copy(origin)
				leftLocation.x -= radius
				rightLocation.Copy(origin)
				rightLocation.x += radius
				upLocation.Copy(origin)
				upLocation.y -= radius
				downLocation.Copy(origin)
				downLocation.y += radius
				Return
			End If
		End For
	End Method
	
	
	Method Stop:Void()
		held = False
		vector.Set(0, 0)
		left = False; right = False
		up = False; down = False
	End Method
	
End Class