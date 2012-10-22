
Strict

Import node
Import wdw.tools.rectangle

'summary: An item to place in quadtree nodes.
Class QuadTreeItem
	
	Private
	
	'bounding box, centered on position of object.
	Field boundingBox:Rectangle
	
	'parent quadtreenode of this item.
	Field parentNode:QuadTreeNode
	
	Public
	
	
	#REM
	summary: Constructor.
	Bounding box rectangle is centered on x,y.
	#END
	Method New(x:Float, y:Float, w:Float, h:Float)
		Self.boundingBox = New Rectangle(x, y, w, h, True)
	End Method
	
	
	'summary: Returns bounding box of this item.
	Method BoundingBox:Rectangle() Property
		Return boundingBox
	End Method
	
	
	'summary: Sets the parent node of this item.
	Method Parent:Void(parent:QuadTreeNode) Property
		parentNode = parent
	End Method
	
	
	'summary: Returns the parent node of this item.
	Method Parent:QuadTreeNode() Property
		Return parentNode
	End Method
	
	
	'Centers bounding box position around passed position.
	Method Update:Void(x:float, y:Float)
		Self.boundingBox.SetPosition(x - Self.boundingBox.width / 2, y - Self.boundingBox.height / 2)
	End Method
	
End Class