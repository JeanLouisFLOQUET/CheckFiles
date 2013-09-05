#include-once
#include <CheckFiles_Global.au3>

; #FUNCTION# ====================================================================================================================
; Name ..........: _CheckFiles_Event_Empreinte
; Description ...: Sauvegarde le type d'empreinte
; Syntax ........: _CheckFiles_Event_Empreinte()
; Parameters ....:
; Return values .: None
; Author ........: Jean-Louis FLOQUET
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _CheckFiles_Event_Empreinte()
	Switch GUICtrlRead($hnd_fp)
		Case $FP_MD2
			RegWrite($REG_PATH,"Empreinte","REG_SZ",$FP_MD2   )
		Case $FP_MD4
			RegWrite($REG_PATH,"Empreinte","REG_SZ",$FP_MD4   )
		Case $FP_MD5
			RegWrite($REG_PATH,"Empreinte","REG_SZ",$FP_MD5   )
		Case $FP_SHA1
			RegWrite($REG_PATH,"Empreinte","REG_SZ",$FP_SHA1  )
		Case $FP_SHA224
			RegWrite($REG_PATH,"Empreinte","REG_SZ",$FP_SHA224)
		Case $FP_SHA256
			RegWrite($REG_PATH,"Empreinte","REG_SZ",$FP_SHA256)
		Case $FP_SHA384
			RegWrite($REG_PATH,"Empreinte","REG_SZ",$FP_SHA384)
		Case $FP_SHA512
			RegWrite($REG_PATH,"Empreinte","REG_SZ",$FP_SHA512)
		Case Else
			RegWrite($REG_PATH,"Empreinte","REG_SZ",""        )
	EndSwitch

	_CheckFiles_SetParameters()
EndFunc