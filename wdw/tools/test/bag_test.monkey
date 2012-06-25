
'unit tests for wdw.tools.bag

Strict

Import wdw.unittest
Import wdw.tools.bag


Class BagTest Extends Test
	
	Field b:Bag
	
	Method doBefore:Void()
		b = New Bag
	End
	
	
	Method doAfter:Void()
		b = Null
	End
	
	
	Method ConstructorTest:Void()
		assertEquals(0, b.GetSize(), "")
		assertTrue(b.IsEmpty(), "")
		assertEquals(16, b.GetCapacity(), "")
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
		assertEquals(4, b.GetSize(), "")
		
		b.Clear()
		assertTrue(b.IsEmpty(), "not empty")
	End
	
	
	Method RemoveAllFromTest:Void()
		Local b2 := New Bag
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
		Local b2 := New Bag
		Local o1 := New Dummy
		b2.Add(o1)
		Local o2 := New Dummy
		b2.Add(o2)
		
		b.AddAllFrom(b2)
		
		assertTrue(b.Contains(o1), "")
		assertTrue(b.Contains(o2), "")
	End
End



'to insert in bag
Class Dummy
End