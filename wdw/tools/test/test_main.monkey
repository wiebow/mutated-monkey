
'unit tests for tools module

Strict

Import wdw.unittest

#REFLECTION_FILTER+="*_test"


Import vector2d_test
'Import color_test
'Import bag_test
Import rectangle_test


Function Main:Int()
	Local t:= New TestSuite
	t.Run()
	Return 0
End
