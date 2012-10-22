
Strict

Import wdw.tools.rectangle
Import tree
Import item


'summary: Quad Tree Node.
Class QuadTreeNode
	
	Private
	
	'the node covers this area.
	Field area:Rectangle

	'node items if not partinioned.
	Field items:List<QuadTreeItem>
	
	'child nodes will go here.
	'0 = topleft, 1 = topright, 2 = bottomleft, 3 = bottomright.
	'if this node contains nodes, then it cannot contain items
	'and is a branch node.
	Field nodes:QuadTreeNode[4]
	
	Field partitioned:Bool
	
	'max amount of items before subdivide.
	Field maxItems:Int
	
	'reference to this node's parent node.
	Field parentNode:QuadTreeNode
	
	'reference to this node tree.
	Field parentTree:QuadTree
			
	Public
	
	
	'summary: Constructor.
	Method New(x:Int, y:Int, w:Int, h:Int, tree:QuadTree, maxI:Int = DEFAULT_MAX_ITEMS, node:QuadTreeNode = Null)
		Self.items = New List<QuadTreeItem>
		Self.area = New Rectangle(x, y, w, h, False)
		Self.partitioned = False
		Self.MaxItems = maxI
		Self.ParentNode = node
		Self.ParentTree = tree
	End Method
	
	
	Method ParentNode:Void(node:QuadTreeNode) Property
		parentNode = node
	End Method
	
	
	Method ParentNode:QuadTreeNode() Property
		Return parentNode
	End Method
	
	
	Method ParentTree:Void(node:QuadTree) Property
		parentTree = node
	End Method
	
	
	Method ParentTree:QuadTree() Property
		Return parentTree
	End Method
	
	
	Method MaxItems:Void(i:int) Property
		maxItems = i
	End Method
	
	
	Method MaxItems:Int() Property
		Return maxItems
	End Method
	
	
	'frees node content	
	Method Free:Void()
		items.Clear()
		items = Null
		area = Null
		
		If partitioned
			For Local n:Int = 0 To 3
				nodes[n].Free()
			End For
		End If
	End Method
	
	
	'summary: Sets Node area.
	Method SetArea:Void(x:Int, y:Int, w:Int, h:Int)
		area.SetPosition(x, y)
		area.SetDimension(w, h)
	End Method
	
	
	'partitions this node and pushes items into new nodes
	Method Partition:Void()
		If Not partitioned
			Local childWidth:Int = area.width / 2
			Local childHeight:Int = area.height / 2
			
			'topleft
			nodes[0] = New QuadTreeNode(area.x, area.y, childWidth, childHeight, parentTree, maxItems, Self)
			'topright
			nodes[1] = New QuadTreeNode(area.x + childWidth, area.y, childWidth, childHeight, parentTree, maxItems, Self)
			'bottomwleft
			nodes[2] = New QuadTreeNode(area.x, area.y + childHeight, childWidth, childHeight, parentTree, maxItems, Self)
			'bottomright
			nodes[3] = New QuadTreeNode(area.x + childWidth, area.y + childHeight, childWidth, childHeight, parentTree, maxItems, Self)
			
			partitioned = True
			
			'move items in this node to new child nodes
			For Local i:= EachIn items
				PushItemDown(i)
			End For
		End If
	End Method
	
	
	'summary: adds all items in this and child nodes to passed list.
	Method GetAllItems:Void(l:List<QuadTreeItem>)
	
		'add all items in this node to the passed list
		For Local i:= EachIn items
			l.AddLast(i)
		End For
		
		If partitioned
			For Local n:Int = 0 To 3
				nodes[n].GetAllItems(l)
			End For
		End If
	End Method
	
	
	'summary:Adds all items that are overlapped by passed rectangle to passed list.	
	Method GetItems:Void(l:List, r:Rectangle)
	
		If area.IntersectsRectangle(r)
			
			'find all items in this node that overlap passed rect
			For Local i:QuadTreeItem = EachIn items
				If r.IntersectsRectangle(i.BoundingBox) Then l.AddLast(i)
			End For
		End If
		
		If partitioned
			For Local n:Int = 0 To 3
				nodes[n].GetItems(l, r)
			End For
		End If
		
	End Method
	
	
	'summary: Inserts an item into this node.
	'Partitions this node when needed.	
	Method InsertItem:Void(i:QuadTreeItem)
		If Not InsertInChild(i)
			'not added to child node: add to this node
			'but only once
			If items.Contains(i) Then Return
			items.AddLast(i)
			i.Parent = Self
			
			If Not partitioned And items.Count() >= maxItems
				Partition()
			End If
		End If
	End Method
	
	
	Method InsertInChild:Bool(i:QuadTreeItem)
	
		'cannot add to this node if not partitioned
		If Not partitioned Then Return False
		
		'add to one of the child nodes
		'this only succeeds of item bounding box fits INSIDE node area rectangle
		For Local n:Int = 0 To 3
			If nodes[n].RectInNode(i.BoundingBox)
				nodes[n].InsertItem(i)
				Return True
			End If
		End For
		Return False
	End Method
	
	
	Method PushItemDown:Bool(i:QuadTreeItem)
		If InsertInChild(i)
			items.Remove(i)
			Return True
		End If
		Return False
	End Method
	
	
	Method PushItemUp:Void(i:QuadTreeItem)
		items.Remove(i)
		parentNode.InsertItem(i)
	End Method
	
	
	'summary: Moves item in tree. Used after an object has changed position.
	Method MoveItem:Void(i:QuadTreeItem)
		If Not PushItemDown(i)
			'no child node accepts this item,
			'push to parent instead
			If parentNode
				PushItemUp(i)
			ElseIf Not area.ContainsRectangle(i.BoundingBox)
				'we're in root node and item does not fit
				'we need to resize the world				
				parentTree.Resize(i.BoundingBox)
			End If
		End If
	End Method
	
	
	'returns true of specified rect fits in this node.
	Method RectInNode:Bool(r:Rectangle)
		Return area.ContainsRectangle(r)
	End Method
		
	
	Method Area:Rectangle() Property
		Return area
	End
	
	
	Method Nodes:QuadTreeNode[]() Property
		Return nodes
	End
	
	
	Method Items:List<QuadTreeItem>() Property
		Return items
	End
	
End Class