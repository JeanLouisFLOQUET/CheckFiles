#include-once
#include <CheckFiles_Global.au3>

; #FUNCTION# ====================================================================================================================
; Name ..........: _CheckFiles_SetEmpreinte
; Description ...: Défini l'empreinte
; Syntax ........: _CheckFiles_SetEmpreinte($fp)
; Parameters ....: $fp                  - A boolean value.
; Return values .: None
; Author ........: Jean-Louis FLOQUET
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _CheckFiles_SetEmpreinte($fp)
	Local $MyFp = StringRegExpReplace($fp,"SHA(\d)","SHA-$1")

	Switch $MyFp
		Case $FP_MD2
			GUICtrlSetData($hnd_fp,$FP_MD2   )
		Case $FP_MD4
			GUICtrlSetData($hnd_fp,$FP_MD4   )
		Case $FP_MD5
			GUICtrlSetData($hnd_fp,$FP_MD5   )
		Case $FP_SHA1
			GUICtrlSetData($hnd_fp,$FP_SHA1  )
		Case $FP_SHA224
			GUICtrlSetData($hnd_fp,$FP_SHA224)
		Case $FP_SHA256
			GUICtrlSetData($hnd_fp,$FP_SHA256)
		Case $FP_SHA384
			GUICtrlSetData($hnd_fp,$FP_SHA384)
		Case $FP_SHA512
			GUICtrlSetData($hnd_fp,$FP_SHA512)
		Case Else
			GUICtrlSetData($hnd_fp,$FP_MD5   )
	EndSwitch
EndFunc
