#include-once
#include <CheckFiles_Global.au3>

; #FUNCTION# ====================================================================================================================
; Name ..........: _CheckFiles_Event_Install
; Description ...: Requête d'installation
; Syntax ........: _CheckFiles_Event_Install()
; Parameters ....:
; Return values .: None
; Author ........: Jean-Louis FLOQUET
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _CheckFiles_Event_Install()
	If Not(@Compiled) Then
		MsgBox($MB_ICONHAND,$TITLE,"Impossible d'installer le logiciel à partir du fichier AU3." & @CRLF & "Recommencer à partir de la version compilée !!")
		Return
	EndIf

	RegWrite("HKEY_CLASSES_ROOT\Directory\shell\CheckFiles"        ,"","REG_SZ","CheckFiles")
	RegWrite("HKEY_CLASSES_ROOT\Directory\shell\CheckFiles\command","","REG_SZ","""" & @ScriptFullPath & """ ""%1""")
	RegWrite("HKEY_CLASSES_ROOT\Drive\shell\CheckFiles"            ,"","REG_SZ","CheckFiles")
	RegWrite("HKEY_CLASSES_ROOT\Drive\shell\CheckFiles\command"    ,"","REG_SZ","""" & @ScriptFullPath & """ ""%1""")

	RegWrite("HKEY_CLASSES_ROOT\.md2\shell\open\command"           ,"","REG_SZ","""" & @ScriptFullPath & """ ""%1""")
	RegWrite("HKEY_CLASSES_ROOT\.md4\shell\open\command"           ,"","REG_SZ","""" & @ScriptFullPath & """ ""%1""")
	RegWrite("HKEY_CLASSES_ROOT\.md5\shell\open\command"           ,"","REG_SZ","""" & @ScriptFullPath & """ ""%1""")
	RegWrite("HKEY_CLASSES_ROOT\.sha1\shell\open\command"          ,"","REG_SZ","""" & @ScriptFullPath & """ ""%1""")
	RegWrite("HKEY_CLASSES_ROOT\.sha224\shell\open\command"        ,"","REG_SZ","""" & @ScriptFullPath & """ ""%1""")
	RegWrite("HKEY_CLASSES_ROOT\.sha256\shell\open\command"        ,"","REG_SZ","""" & @ScriptFullPath & """ ""%1""")
	RegWrite("HKEY_CLASSES_ROOT\.sha384\shell\open\command"        ,"","REG_SZ","""" & @ScriptFullPath & """ ""%1""")
	RegWrite("HKEY_CLASSES_ROOT\.sha512\shell\open\command"        ,"","REG_SZ","""" & @ScriptFullPath & """ ""%1""")

	RegWrite("HKEY_CLASSES_ROOT\.md2\defaulticon"                  ,"","REG_SZ","""" & @ScriptFullPath & """"  & "," & 0)
	RegWrite("HKEY_CLASSES_ROOT\.md4\defaulticon"                  ,"","REG_SZ","""" & @ScriptFullPath & """"  & "," & 0)
	RegWrite("HKEY_CLASSES_ROOT\.md5\defaulticon"                  ,"","REG_SZ","""" & @ScriptFullPath & """"  & "," & 0)
	RegWrite("HKEY_CLASSES_ROOT\.sha1\defaulticon"                 ,"","REG_SZ","""" & @ScriptFullPath & """"  & "," & 0)
	RegWrite("HKEY_CLASSES_ROOT\.sha224\defaulticon"               ,"","REG_SZ","""" & @ScriptFullPath & """"  & "," & 0)
	RegWrite("HKEY_CLASSES_ROOT\.sha256\defaulticon"               ,"","REG_SZ","""" & @ScriptFullPath & """"  & "," & 0)
	RegWrite("HKEY_CLASSES_ROOT\.sha384\defaulticon"               ,"","REG_SZ","""" & @ScriptFullPath & """"  & "," & 0)
	RegWrite("HKEY_CLASSES_ROOT\.sha512\defaulticon"               ,"","REG_SZ","""" & @ScriptFullPath & """"  & "," & 0)

	RegWrite("HKEY_CURRENT_USER\Software\Classes\Applications\CheckFiles.exe\shell\open\command","","REG_SZ","""" & @ScriptFullPath & """ ""%1""")

	MsgBox($MB_ICONASTERISK,$TITLE,"Installation réussie")
EndFunc
