
Strict
Import wdw.framework.fwgame


'summary: A game state template.
Class State Abstract
	
	Private
	
	'Game holding this state.
	Field game:fwGame
	
	'ID of this State.
	Field id:Int
	
	Public
	
	
	#rem
	summary: User hook to perform state startup logic.
	This method is called when the state is entered, before the fadein.
	#END	
	Method Enter:Void() Abstract

	#rem
	summary: User hook to perform state teardown logic.
	This method is called when the state is left, after the fadeout.
	#END
	Method Leave:Void() Abstract
	
	
	'summary: User hook to perform state update logic.	
	Method Update:Void() Abstract

	'summary: User hook to perform state render code.	
	Method Render:Void() Abstract
	

	Method Id:Void(newId:Int) Property
		id = newId
	End
	
	
	'summary: Returns the ID of this state.
	Method Id:Int() Property
		Return id
	End
	

	Method Game:Void(g:fwGame) Property
		game = g
	End
	
	
	'summary: Returns the game owning this state.
	Method Game:fwGame() Property
		Return game
	End

End