#include-once
#include <CheckFiles_Global.au3>

; #FUNCTION# ====================================================================================================================
; Name ..........: _CheckFiles_Event_Uninstall
; Description ...: Requête de désinstallation
; Syntax ........: _CheckFiles_Event_Uninstall()
; Parameters ....:
; Return values .: None
; Author ........: Jean-Louis FLOQUET
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _CheckFiles_Event_Uninstall()
	RegDelete("HKEY_CLASSES_ROOT\Directory\shell\CheckFiles")
	RegDelete("HKEY_CLASSES_ROOT\Drive\shell\CheckFiles")
	RegDelete("HKEY_CURRENT_USER\Software\Classes\Applications\CheckFiles.exe")
	MsgBox($MB_ICONASTERISK,$TITLE,"Désinstallation réussie")
EndFunc
