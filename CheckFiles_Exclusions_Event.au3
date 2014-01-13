#include-once
#include <CheckFiles_Global.au3>

; #FUNCTION# ====================================================================================================================
; Name ..........: _CheckFiles_Exclusions_Event
; Description ...: Liste d'exclusions
; Syntax ........: _CheckFiles_Exclusions_Event()
; Parameters ....:
; Return values .: None
; Author ........: Jean-Louis FLOQUET
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _CheckFiles_Exclusions_Event()
	;Si la fenêtre est déjà ouverte, remet-la au premier plan
	If $hnd_exc_gui<>0 Then
		WinActivate($hnd_exc_gui)
		Return 0
	EndIf

	$hnd_exc_gui = GUICreate("Liste d'exclusions",600,400)
	GUISetIcon(@ScriptFullPath,-1,$hnd_exc_gui)

	$hnd_exc_lbl = GUICtrlCreateLabel("Entrer les filtres sous la forme d'expression régulière",10,7)
	$hnd_exc_lst = GUICtrlCreateEdit ("",10,30,575,360,$ES_WANTRETURN+$WS_VSCROLL)

	_CheckFiles_Exclusions_Load()
	Local $temp_str
	For $i=1 To $exc_arr[0]
		$temp_str &= $exc_arr[$i] & @CRLF
	Next
	GUICtrlSetData($hnd_exc_lst,$temp_str)

	ControlFocus($hnd_exc_gui,"",$hnd_exc_lbl) ;Retire le focus au contrôle "edit" pour éviter que le texte soit en surbrillance / sélectionné

	;Affiche l'interface graphique
	GUISetState(@SW_SHOW,$hnd_exc_gui)
	WinActivate($hnd_exc_gui)

	Opt("GUIOnEventMode", 1)  ; Change to OnEvent mode
	GUISetOnEvent($GUI_EVENT_CLOSE, "_CheckFiles_GUI_Close_Wo_Arg")
EndFunc
