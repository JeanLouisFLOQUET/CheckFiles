#include-once
#include <CheckFiles_Global.au3>

; #FUNCTION# ====================================================================================================================
; Name ..........: _CheckFiles_Heure
; Description ...: Renvoie l'horodatage
; Syntax ........: _CheckFiles_Heure()
; Parameters ....:
; Return values .: None
; Author ........: Jean-Louis FLOQUET
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _CheckFiles_Heure()
	Return @YEAR & "/" & @MON & "/" & @YDAY & " " & @HOUR & ":" & @MIN & ":" & @SEC
EndFunc
