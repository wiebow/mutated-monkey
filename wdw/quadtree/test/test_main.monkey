
'unit tests for quadtree module

Strict

Import wdw.unittest

#REFLECTION_FILTER+="*_test"

Import item_test
Import node_test
Import tree_test

Function Main:Int()
	Local t:= New TestSuite
	t.Run()
	Return 0
End
