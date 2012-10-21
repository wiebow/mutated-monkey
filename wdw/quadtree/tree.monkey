

Strict

Import node


Const DEFAULT_MAX_ITEMS:int = 50

Class QuadTree

	Private
	
	'root node
	Field head:QuadTreeNode
	
	'max items in a node before partioning
	Field maxItems:Int
	
	'total world size
	Field area:Rectangle
	
	Public
	
	
	'summary: Constructor.
	Method New(x:Int, y:Int, w:Int, h:Int)
		Self.area = New Rectangle(x, y, w, h)
	End Method
	
	
	'summary: Sets max items for a node in this tree.
	Method MaxItems:Void(i:Int) Property
		maxItems = i
	End Method
		
	
	'summary: Returns the max items for a node in this tree.
	Method MaxItems:Int() Property
		Return maxItems
	End Method
	
	
	'summary: Inserts an item in the tree.
	Method InsertItem:Void(i:QuadTreeItem)
		If Not area.ContainsRectangle(i.BoundingBox)
			Resize(i.BoundingBox)
		End If
		
		'add item
		head.InsertItem(i)
	End Method
	
	
	'resizes the world until passed rectangle fits inside.
	Method Resize:Void(r:Rectangle)
		While Not area.ContainsRectangle(r)
			area.x *= 2
			area.y *= 2
			area.width *= 2
			area.height *= 2
		End While
		
		'done. get all items in the tree.
		Local l:= New List<QuadTreeItem>
		head.GetAllItems(l)
		
		'cut down tree.
		head.Free()
		head = Null
		
		'create new root.
		head = New QuadTreeNode(area.x, area.y, area.width, area.height, Self, maxItems, Null)
		
		're-insert items.
		For Local i:QuadTreeItem = EachIn l
			head.InsertItem(i)
		End For
	
	End Method
	
	
	'summary: Returns a list of all items in the tree that are overlapped by passed rectangle.	
	Method GetItems:List(r:Rectangle)
		Local l:= New List<QuadTreeItem>
		head.GetItems(l, r)
		Return l
	End Method
	
	
	'summary: Returns a list of all the items in the tree.
	Method GetAllItems:List()
		Local l:= New List<QuadTreeItem>
		head.GetAllItems()
		Return l
	End Method
	
End Class