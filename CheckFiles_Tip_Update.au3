#include-once
#include <CheckFiles_Global.au3>
; #FUNCTION# ====================================================================================================================
; Name ..........: _CheckFiles_Tip_Update
; Description ...:
; Syntax ........: _CheckFiles_Tip_Update($str)
; Parameters ....: $str                 - A string value.
; Return values .: None
; Author ........: Your Name
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _CheckFiles_Tip_Update($str)
	Local $length = StringLen($str) * (($TIP_FONT_SIZE / 4) * 3.2)
	WinMove($tip_gui_hnd, "", Default, Default, $length)
	ControlSetText($tip_gui_hnd, "", $tip_lbl_hnd, " " & $str & " ")
EndFunc
