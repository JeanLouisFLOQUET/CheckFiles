#include-once
#include <CheckFiles_Global.au3>

; #FUNCTION# ====================================================================================================================
; Name ..........: _CheckFiles_Event_Recursif
; Description ...: Sauvegarde le choix de récursivité
; Syntax ........: _CheckFiles_Event_Recursif()
; Parameters ....:
; Return values .: None
; Author ........: Jean-Louis FLOQUET
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _CheckFiles_Event_Recursif()
	If BitAND(GUICtrlRead($hnd_recursif),$GUI_CHECKED)=$GUI_CHECKED Then
		RegWrite($REG_PATH,"Recursif","REG_DWORD",1)
	Else
		RegWrite($REG_PATH,"Recursif","REG_DWORD",0)
	EndIf
EndFunc
