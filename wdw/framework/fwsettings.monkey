
Strict

Import os

#rem
'summary: a settings class that can be loaded and saved.
'settings are stored as strings.
'settings file is saved in the same folder as the executable.
#end
Class fwSettings

	Private

	Field settings:StringMap<fwSetting> = New StringMap<fwSetting>
	
	Public

	'summary: Adds an int value to settings
	Method AddSetting:Void(name:String, value:Int)
		settings.Insert(name, New fwSetting(String(value)))
	End Method

	'summary: Adds a float value to settings
	Method AddSetting:Void(name:String, value:Float)
		settings.Insert(name, New fwSetting(String(value)))
	End Method
	
	'summary: Adds a string value to settings
	Method AddSetting:Void(name:String, value:String)
		settings.Insert(name, New fwSetting(String(value)))
	End Method
	
	
	
	'summary: Retrieves an int value. Sets and returns the default if setting is not found.
	Method GetSettingInt:Int(name:String, newDefault:Int)
		Local s:fwSetting = settings.Get(name)
		If Not s
			Self.AddSetting(name, newDefault)
			Return newDefault
		Else
			Return Int(settings.Get(name).GetValue())
		End If
	End Method

	
	'summary: Retrieves a float value. Sets and returns the default if setting is not found.
	Method GetSettingFloat:Float(name:String, newDefault:Float)
		Local s:fwSetting = settings.Get(name)
		If Not s
			Self.AddSetting(name, newDefault)
			Return newDefault
		Else
			Return Float(settings.Get(name).GetValue())
		End If
	End Method
	
	
	'summary: Retrieves a string value. Sets and returns the default if setting is not found.
	Method GetSettingString:String(name:String, newDefault:String)
		Local s:fwSetting = settings.Get(name)
		If Not s
			Self.AddSetting(name, newDefault)
			Return newDefault
		Else
			Return String(settings.Get(name).GetValue())
		End If
	End Method
	

	'summary: Saves settings to disk.	
	Method Save:Void(fileName:String = "config.ini")
		Local s:String = Self.CreateSettingsString()
		Local p:String = AppPath()
		p = ExtractDir(p) + "/" + fileName
		SaveString(s, p)
	End Method
	
	
	'summary: Loads settings from disk.
	Method Load:Void(fileName:String = "config.ini")
		settings.Clear()
		
		Local p:String = AppPath()
		p = ExtractDir(p) + "/" + fileName
		
		Local ls:String = LoadString(p)
		Local settingsArray:String[] = ls.Split(",")
		For Local index:Int = 0 Until settingsArray.Length
			Local setting:String = settingsArray[index]
			Local pairs:String[] = setting.Split("=")
			Self.AddSetting(pairs[0], pairs[1])
		End For
	End Method
	

	'used for testing purposes
	Method GetAllSettings:StringMap<fwSetting>()
		Return settings
	End Method
	
	
	Private
	
	Method CreateSettingsString:String()
		Local s:string
		For Local it:= EachIn settings
			s += it.Key + "=" + it.Value.GetValue() + ","
		End For

		'get rid of trailing ,		
		s = s[ .. s.Length() -1]
		Return s
	End Method
		
End Class


Class fwSetting

	Private
	
	Field value:String
		
	Public

	
	Method New(value:String)
		Self.value = value
	End Method
	
	Method GetValue:String()
		Return value
	End Method

		
End Class