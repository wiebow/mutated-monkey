
Strict


'summary: Unsorted, fast collection of objects.
Class Bag<T>

	Private
	
	Field _arr:T[16]
	
	
	#rem
	summary:Number of active elements in the array.
	Points to the next empty slot.
	#end
	Field _currentSlot:Int = 0
	
	Public
		

	'summary: Creates and empty bag with specified capacity.	
	Method New(capacity:Int)
		_arr = New T[capacity]
	End
		
		
	'summary: Returns the number of element slots in the bag.
	Method Capacity:Int() Property
		Return _arr.Length()
	End
	
		
	'summary: Returns the number of elements in the bag.
	Method Size:Int() Property
		Return _currentSlot
	End
		
	
	'summary: Returns true if the bag contains no elements.
	Method IsEmpty:Bool()
		Return _currentSlot = 0
	End
		
	
	'summary: Expands the bag capacity.
	Method Grow:Void(newSize:Int = 0)
		If newSize = 0 Then newSize = (_arr.Length() * 3) / 2 + 1
		_arr = _arr.Resize(newSize)
	End
		
	
	'summary: Adds specified object to end of this bag.
	Method Add:Void(o:T)
	
		'need to grow?
		If _currentSlot = _arr.Length() Then Grow()
		
		_arr[_currentSlot] = o
		_currentSlot += 1
	End
    
        
	'summary: Set element at specified index in the bag.
	Method Set:Void(index:Int, o:T)
		If index >= _arr.Length()
			Grow(index *2)
			_currentSlot = index + 1
		ElseIf index >= _currentSlot
			_currentSlot = index+1				
		End If
		_arr[index] = o
	End Method
	
		
	'summary: Returns true if specified object is in the bag.
	Method Contains:Bool(o:T)
		For Local i := 0 to _currentSlot - 1
			If _arr[i] = o Then Return True
		Next
		Return False
	End

		
	'summary: Returns item at specified index.
	Method Get:T(index:Int)
		If index < 0 or index > _arr.Length() Then Return Null
		Return _arr[index]
	End
		
	
	'summary: Removes object from bag by index.
	Method RemoveByIndex:T(index:Int)
		Local o:T = _arr[index]
		
		_arr[index] = _arr[_currentSlot - 1]
		_arr[_currentSlot - 1] = Null
		_currentSlot -= 1
		Return o
	End
		
	
	'summary: Removes and returns the last item in the bag.
	Method RemoveLast:T()
		If _currentSlot > 0
			_currentSlot -= 1
			Local o:T = _arr[_currentSlot]
			_arr[_currentSlot] = Null
			Return o
		End
		Return Null
	End
		
	
	'summary: Removes the first occurance of the specified element.
	Method Remove:Bool(o:T)
		For Local i:Int = 0 to _currentSlot - 1
			If _arr[i] = o
				RemoveByIndex(i)
				Return True
			End
		End
		Return False
	End
		
	
	'summary: Removes from this bag all of its elements that are contained in the specified bag.
	Method RemoveAllFrom:Bool(b2:Bag)
		Local modified:Bool = False
		
		For Local index2:Int = 0 To b2.Size() -1
			For Local index:Int = 0 To Self.Size() -1
				If b2._arr[index2] = _arr[index]
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
		For Local i:Int = 0 to _arr.Length() - 1
			_arr[i] = Null
		End
		_currentSlot = 0
	End
		
	
	'summary: Add all items from specified bag to this bag.
	Method AddAllFrom:Void(b2:Bag)
		For Local i:Int = 0 To b2.Size() -1
			Self.Add(b2.Get(i))
		End		
	End
	
End