
' simple resource manager

Strict

Import mojo


#rem
summary: A simple resource mananger.
This class is not instantiated. You can use its functions from anywhere.
#END
Class Resources

	Private
	
	Global _images:= New StringMap<Image>
	Global _sounds:= New StringMap<Sound>
	
	Public
	
	
	Function StoreImage:Void(imageName:String, img:Image)
		If img = Null Then Error("no pic!")
		_images.Set(imageName, img)
	End
	
	
	Function GetImage:Image(imageName:String)
		Return _images.ValueForKey(imageName)
	End
	
	
	Method StoreSound:Void(soundName:String, snd:Sound)
		If snd = Null Then Error("No sound!")
		_sounds.Set(soundName, snd)
	End Method

	
	Method GetSound:Sound(soundName)
		Return _sounds.ValueForKey(soundName)
	End Method

End