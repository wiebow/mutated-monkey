
Strict

Import wdw.unittest
#REFLECTION_FILTER+="*_test"

Import wdw.framework.fwsettings



Function Main:Int()
	Local t:= New TestSuite
	t.Run()
	Return 0
End


Class SettingsTest Extends Test
	
	Field s:fwSettings
	
		
	Method doBefore:Void() 
		s = New fwSettings
	End
	
	Method doAfter:Void()
		s = Null
	End
	
	Method CreateTest:Void()
		assertNotNull(s.GetAllSettings(), "settings map not created")
	End Method
	
	
	Method AddSettingIntTest:Void()
		s.AddSetting("int", 10)
		assertEquals(10, s.GetSettingInt("int", 0), "setting value not 10")
	End Method
	
	Method GetNotSetIntTest:Void()		
		assertEquals(20, s.GetSettingInt("int", 20), "default of 20 not set")
	End Method

	
	Method AddSettingFloatTest:Void()
		s.AddSetting("float", 10.10)
		assertEquals(10.10, s.GetSettingFloat("float", 1.0), "setting value not 10.10")
	End Method

	Method GetNotSetFloatTest:Void()
		assertEquals(20.50, s.GetSettingFloat("float", 20.50), "default of 20.50 not set")
	End Method
	
	
	Method AddSettingStringTest:Void()
		s.AddSetting("string", "yo")
		assertEquals("yo", s.GetSettingString("string", "yoyo"), "setting value not 'yo'")
	End Method
	
	Method GetNotSetStringTest:Void()
		assertEquals("tteesst", s.GetSettingString("int", "tteesst"), "default of 'tteesst' not set")
	End Method
	
		
	
	Method SaveAndLoadTest:Void()
		s.AddSetting("Name", 10)
		s.AddSetting("OtherName", 10.20)
		s.AddSetting("YetName", "yaya")
		s.Save()
				
		s.Load()
		assertEquals(10, s.GetSettingInt("Name", 0), "int setting not loaded or wrong")
		assertEquals(10.20, s.GetSettingFloat("OtherName", 0.0), "float setting not loaded or wrong")
		assertEquals("yaya", s.GetSettingString("YetName", "yoyo"), "string setting not loaded or wrong")
	End Method
	

End Class

