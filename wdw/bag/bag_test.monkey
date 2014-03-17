
'unit tests for wdw.bag

Strict

Import wdw.unittest
#REFLECTION_FILTER+="*_test"

Import wdw.bag


Function Main:Int()
	Local t:= New TestSuite
	t.Run()
	Return 0
End


Class BagTest Extends Test
	
	Field b:Bag<Dummy>
	
	
	Method doBefore:Void()
		b = New Bag<Dummy>
	End
	
	
	Method doAfter:Void()
		b = Null
	End
	
	
	Method ConstructorTest:Void()
		assertEquals(0, b.Size(), "size of new bag is not zero")
		assertTrue(b.IsEmpty(), "new bag is not empty")
		assertEquals(16, b.Capacity(), "default capacity is not 16")
	End
	
	
	Method AddAndContainsTest:Void()
		Local o := New Dummy
		assertFalse(b.Contains(o), "")
		
		b.Add(o)
		assertTrue(b.Contains(o), "o")
		
		Local o2 := New Dummy
		b.Add(o2)
		assertTrue(b.Contains(o2), "o2")
	End
	
	
	Method GetTest:Void()
		'add at index 0
		Local o := New Dummy
		b.Add(o)
		Local o2 := b.Get(0)
		assertSame(o, o2, "index 0")
		
		'add at index 1		
		Local o3 := New Dummy
		b.Add(o3)
		Local o4 := b.Get(1)
		assertSame(o4, o3, "index 1")
	End
	
	
	Method RemoveTest:Void()
		'add at index 0
		Local o := New Dummy
		b.Add(o)
		assertTrue(b.Contains(o), "contains")
				
		b.Remove(o)
		assertFalse(b.Contains(o), "not contains")
	End
	
	
	Method RemoveAllTest:Void()
		Local o := New Dummy
		b.Add(o)
		b.Add(o)
		b.Add(o)
		b.Add(o)
		assertEquals(4, b.Size(), "")
		
		b.Clear()
		assertTrue(b.IsEmpty(), "not empty")
	End
	
	
	Method RemoveAllFromTest:Void()
		Local b2 := New Bag<Dummy>
		Local o1 := New Dummy
		Local o2 := New Dummy
		b.Add(o1)
		b.Add(o2)
		b2.Add(o1)
		assertTrue(b.Contains(o1), "contains o1")
		assertTrue(b.Contains(o2), "contains o2 1")
		
		b.RemoveAllFrom(b2)
		assertFalse(b.Contains(o1), "not contains o1")
		assertTrue(b.Contains(o2), "contains o2 2")
	End
	
	
	Method AddAllFromTest:Void()
		Local b2 := New Bag<Dummy>
		Local o1 := New Dummy
		b2.Add(o1)
		Local o2 := New Dummy
		b2.Add(o2)
		
		b.AddAllFrom(b2)
		
		assertTrue(b.Contains(o1), "")
		assertTrue(b.Contains(o2), "")
	End
	
	Method GrowZeroTest:Void()
		b.Grow()
		assertEquals(25, b.Capacity, "grow zero")
	End Method
	
	
	Method GrowTest:Void()
		b.Grow(100)
		assertEquals(100, b.Capacity, "grow")		
	End Method
	
	
End



'to insert in bag
Class Dummy
End