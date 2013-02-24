
Strict


'summary: Unsorted, fast collection of objects.
Class Bag<T>

	Private
	
	Field arr:T[16]
	
	
	#rem
	summary:Number of active elements in the array.
	Also points to the next empty slot.
	#end
	Field currentSlot:Int = 0
	
	Public
		

	'summary: Creates and empty bag with specified capacity.	
	Method New(capacity:Int)
		arr = New T[capacity]
	End
		
		
	'summary: Returns the number of element slots in the bag.
	Method Capacity:Int() Property
		Return arr.Length()
	End
	
		
	'summary: Returns the number of elements in the bag.
	Method Size:Int() Property
		Return currentSlot
	End
		
	
	'summary: Returns true if the bag contains no elements.
	Method IsEmpty:Bool()
		Return currentSlot = 0
	End
		
	
	'summary: Expands the bag capacity.
	Method Grow:Void(newSize:Int = 0)
		If newSize = 0 Then newSize = (arr.Length() * 3) / 2 + 1
		arr = arr.Resize(newSize)
	End
		
	
	'summary: Adds specified object to end of this bag.
	Method Add:Void(o:T)
		If currentSlot = arr.Length() Then Grow()
		arr[currentSlot] = o
		currentSlot += 1
	End
    
        
	'summary: Set element at specified index in the bag.
	Method Set:Void(index:Int, o:T)
		If index >= arr.Length()
			Grow(index *2)
			currentSlot = index + 1
		ElseIf index >= currentSlot
			currentSlot = index + 1
		End If
		arr[index] = o
	End Method
	
		
	'summary: Returns true if specified object is in the bag.
	Method Contains:Bool(o:T)
		For Local i:= 0 Until currentSlot
			If arr[i] = o Then Return True
		Next
		Return False
	End

		
	'summary: Returns item at specified index.
	Method Get:T(index:Int)
		If index < 0 or index > arr.Length() Then Return Null
		Return arr[index]
	End
		
	
	'summary: Removes object from bag by index. Puts last item in the bag into that spot.
	Method RemoveByIndex:T(index:Int)
		Local o:T = arr[index]
		arr[index] = arr[currentSlot - 1]
		arr[currentSlot - 1] = Null
		currentSlot -= 1
		Return o
	End
		
	
	'summary: Removes and returns the last item in the bag.
	Method RemoveLast:T()
		If currentSlot > 0
			currentSlot -= 1
			Local o:T = arr[currentSlot]
			arr[currentSlot] = Null
			Return o
		End
		Return Null
	End
		
	
	'summary: Removes the first occurance of the specified element. Puts last item in the bag into that spot.
	Method Remove:Bool(o:T)
		For Local i:Int = 0 Until currentSlot
			If arr[i] = o
				RemoveByIndex(i)
				Return True
			End
		End
		Return False
	End
		
	
	'summary: Removes from this bag all of its elements that are contained in the specified bag.
	Method RemoveAllFrom:Bool(b2:Bag)
		Local modified:Bool = False
		For Local index2:Int = 0 Until b2.Size()
			For Local index:Int = 0 Until Self.Size()
				If b2.arr[index2] = arr[index]
					RemoveByIndex(index)
					modified = True
					index -= 1
					Continue
				End
			End
		Next
		Return modified
	End
		
	
	'summary: Removes all elements from this bag.
	Method Clear:Void()
		For Local i:Int = 0 Until arr.Length()
			arr[i] = Null
		End
		currentSlot = 0
	End
		
	
	'summary: Add all items from specified bag to this bag.
	Method AddAllFrom:Void(b2:Bag)
		For Local i:Int = 0 Until b2.Size()
			Self.Add(b2.Get(i))
		End		
	End
	
End