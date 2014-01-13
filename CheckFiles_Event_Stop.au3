#include-once
#include <CheckFiles_Global.au3>

; #FUNCTION# ====================================================================================================================
; Name ..........: _CheckFiles_Event_Stop
; Description ...: Requête d'arrêt
; Syntax ........: _CheckFiles_Event_Stop()
; Parameters ....:
; Return values .: None
; Author ........: Jean-Louis FLOQUET
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _CheckFiles_Event_Stop()
	TrayItemSetState($tray_item_hnd, $TRAY_UNCHECKED)
	$req_stop = 1
EndFunc
