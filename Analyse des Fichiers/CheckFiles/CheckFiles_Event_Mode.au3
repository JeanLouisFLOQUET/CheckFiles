#include-once
#include <CheckFiles_Global.au3>

; #FUNCTION# ====================================================================================================================
; Name ..........: _CheckFiles_Event_Mode
; Description ...: Sauvegarde le mode de fonctionnement
; Syntax ........: _CheckFiles_Event_Mode()
; Parameters ....:
; Return values .: None
; Author ........: Jean-Louis FLOQUET
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _CheckFiles_Event_Mode()
	Switch GUICtrlRead($hnd_mode)
		Case $MODE_LISTE
			RegWrite($REG_PATH,"Mode","REG_SZ",$MODE_LISTE)
		Case $MODE_SUPPR
			RegWrite($REG_PATH,"Mode","REG_SZ",$MODE_SUPPR)
		Case $MODE_AJOUT
			RegWrite($REG_PATH,"Mode","REG_SZ",$MODE_AJOUT)
		Case $MODE_VERIFIE
			RegWrite($REG_PATH,"Mode","REG_SZ",$MODE_VERIFIE)
		Case $MODE_CLEAR
			RegWrite($REG_PATH,"Mode","REG_SZ",$MODE_CLEAR)
		Case $MODE_CHECK_DB
			RegWrite($REG_PATH,"Mode","REG_SZ",$MODE_CHECK_DB)
		Case Else
			RegWrite($REG_PATH,"Mode","REG_SZ","")
	EndSwitch
EndFunc
