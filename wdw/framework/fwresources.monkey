
Strict
Import mojo


#REM
summary: A resource mananger.
This class is not instantiated. You can use its functions from anywhere.
#END
Class fwResources
		
	'summary: Uses Grabimage() to store the image frames.
	'Discards the original image. All frames must be the same size, first frame is 0
	Function StoreImageFrames:Void(imageName:String, img:Image, cellWidth:int, cellHeight:Int)
		Local framesAmount:Int = (img.Width() / cellWidth) * (img.Height() / cellHeight)
		Local newFrames:Image[] = New Image[framesAmount]
		Local x:Int = 0
		Local y:Int = 0
		Local index:Int = 0
		While y < img.Height()
			While x < img.Width()
				newFrames[index] = img.GrabImage(x, y, cellWidth, cellHeight)
				x += cellWidth
				index += 1
			End While
			x = 0
			y += cellHeight
		End While
		frames.Set(imageName, newFrames)
	End Function
	
	
	Function StoreImage:Void(imageName:String, img:Image)
		If img = Null Then Error("no image!")
		images.Set(imageName, img)
	End Function
	
	
	Function GetImageFrames:Image[] (imageName:String)
		Return frames.ValueForKey(imageName)
	End Function
	
	
	Function GetImage:Image(imageName:String)
		Return images.ValueForKey(imageName)
	End Function
	
	
	Function StoreSound:Void(soundName:String, snd:Sound)
		If snd = Null Then Error("No sound!")
		sounds.Set(soundName, snd)
	End Function

	
	Function GetSound:Sound(soundName:String)
		Return sounds.ValueForKey(soundName)
	End Function


	Private
	
	Global images:= New StringMap<Image>
	Global sounds:= New StringMap<Sound>
	Global frames:= New StringMap<Image[] >
End Class