#include-once
#include <CheckFiles_Global.au3>

; #FUNCTION# ====================================================================================================================
; Name ..........: _CheckFiles_BrowseDir
; Description ...: Ouvre une fenêtre pour sélectionner un dossier
; Syntax ........: _CheckFiles_BrowseDir()
; Parameters ....:
; Return values .: None
; Author ........: Jean-Louis FLOQUET
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _CheckFiles_BrowseDir()
	Local $path = GUICtrlRead($hnd_path_txt)
	$path = FileSelectFolder("Choisir un dossier","",2,$path)
	GUICtrlSetData($hnd_path_txt,$path)
	RegWrite($REG_PATH,"Dir","REG_SZ",$path)
EndFunc
