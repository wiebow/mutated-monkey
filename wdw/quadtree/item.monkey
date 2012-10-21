
Strict

Import node
Import wdw.tools.rectangle

'summary: An item to place in quadtree nodes.
Class QuadTreeItem
	
	Private
	
	'world coordinates of this item.
	Field position:Vector2D
	
	'bounding box, centered on position.
	Field box:Rectangle
	
	'parent quadtreenode of this item.
	Field parentNode:QuadTreeNode
	
	'game object belonging to this quadtree item.
	Field obj:Object
	
	Public
	
	
	#REM
	summary: Constructor.
	Bounding box rectangle is centered on x,y.
	#END
	Method New(x:Float, y:Float, w:Float, h:Float)
		Self.position = New Vector2D(x, y)
		Self.box = New Rectangle(x, y, w, h, True)
	End Method
	
	
	'summary: Returns the world position of this item.
	Method Position:Vector2D() Property
		Return position
	End Method
	
	
	'summary: Returns bounding box of this item.
	Method BoundingBox:Rectangle() Property
		Return box
	End Method
	
	
	'summary: Sets the parent node of this item.
	Method Parent:Void(parent:QuadTreeNode) Property
		parentNode = parent
	End Method
	
	
	'summary: Returns the parent node of this item.
	Method Parent:QuadTreeNode() Property
		Return parentNode
	End Method
	
	
	'updates this item according to passed position.
	Method Update:Void(newPosition:Vector2D)
		Self.position.Copy(newPosition)
		Self.box.SetPosition(newPosition.x - Self.box.width / 2, newPosition.y, -Self.box.height / 2)
	End Method
	
End Class