#include-once
#include <CheckFiles_Global.au3>

; #FUNCTION# ====================================================================================================================
; Name ..........: _CheckFiles_Event_Start
; Description ...: Démarre l'analyse
; Syntax ........: _CheckFiles_Event_Start()
; Parameters ....:
; Return values .: None
; Author ........: Jean-Louis FLOQUET
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _CheckFiles_Event_Start()
	$NbFilesKO = 0
	$req_stop  = 0

	_CheckFiles_Exclusions_Load()
	_CheckFiles_Exclusions_Fix ()

	Local $path = GUICtrlRead($hnd_path_txt)
	Local $mode
	Local $code
	Switch GUICtrlRead($hnd_mode)
		Case $MODE_SW_0
			_CheckFiles_Event_Uninstall()
			Return
		Case $MODE_SW_1
			_CheckFiles_Event_Install()
			Return
		Case $MODE_LISTE
			$mode = $MODE_LISTE
		Case $MODE_SUPPR
			$mode = $MODE_SUPPR
		Case $MODE_AJOUT
			$mode = $MODE_AJOUT
		Case $MODE_VERIFIE
			$mode = $MODE_VERIFIE
		Case $MODE_CLEAR
			$mode = $MODE_CLEAR
		Case $MODE_CHECK_DB
			$mode = $MODE_CHECK_DB
		Case Else
			Return
	EndSwitch

	If $Empreinte<>"" Then
		$timer = TimerInit()
		_CheckFiles_Start($path,$mode)
	EndIf
EndFunc
