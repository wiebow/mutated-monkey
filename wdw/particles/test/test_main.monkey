
'unit tests for particles module

Strict

Import wdw.unittest

#REFLECTION_FILTER+="*_test"


Import manager_test


Function Main:Int()
	Local t:= New TestSuite
	t.Run()
	Return 0
End
