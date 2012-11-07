

Import particle

Import wdw.tools.vector2d
Import wdw.tools.bag

'summary: Particle emitter.
Class Emitter

	Field position:Vector2D
	Field previousPosition:Vector2D
	
	Field particles:Bag<Particle>
	
	
	Method Update:Void()
	
		For Local i:Int = 0 To particles.Size() -1
			Local done:bool = particles.Get(i).Update()
			If done
								
			End If
			
			
		End For
	
	End Method
	

End Class