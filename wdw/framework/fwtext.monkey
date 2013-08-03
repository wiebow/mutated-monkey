
Import mojo

'a bitmapfont class
Class fwText

	Field characterFrames:Image[]
	Field chars:IntMap<fwChar> = New IntMap<fwChar>

	'starts with char 32 (space)
	'http://www.asciitable.com/
	Method New(i:Image[], widths:Int[])
		characterFrames = i
		Local charCode:Int = 32
		Local frameIndex:Int = 0
		For Local index:Int = 0 Until widths.Length
			chars.Set(charCode, New fwChar(frameIndex, widths[index]))
			charCode += 1
			frameIndex += 1
		End For
	End Method
	
	
	Method Print:Void(text:String, x, y)
		Local textChars:Int[] = text.ToChars()
		For Local i:Int = 0 Until textChars.Length
			Local char:fwChar = chars.Get(textChars[i])
			DrawImage(characterFrames[char.imageIndex], x, y)
			x += char.charWidth
		End For
	End Method
	
End Class


Class fwChar
	Field imageIndex:Int
	Field charWidth:Int
	
	Method New(index:Int, width:Int)
		imageIndex = index
		charWidth = width
	End Method

End Class