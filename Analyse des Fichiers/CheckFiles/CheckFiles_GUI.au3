#include-once
#include <CheckFiles_Global.au3>

; #FUNCTION# ====================================================================================================================
; Name ..........: _CheckFiles_GUI
; Description ...:
; Syntax ........: _CheckFiles_GUI($path, $mode, $fp)
; Parameters ....: $path                - A pointer value.
;                  $mode                - An unknown value.
;                  $fp                  - A boolean value.
; Return values .: None
; Author ........: Jean-Louis FLOQUET
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _CheckFiles_GUI($path,$mode,$fp)
	Local Const $GUI_HEIGHT = 110
	Local Const $GUI_WIDTH  = 500
	;----------------------------------------------------------------------------------------------
	;GUI - Partie 1
	;----------------------------------------------------------------------------------------------
	$hnd_gui_main = GUICreate("JLF CheckFiles - " & FileGetVersion(@AutoItExe),$GUI_WIDTH,$GUI_HEIGHT,-1,-1,$WS_MINIMIZEBOX + $WS_CAPTION)
	GUISetIcon(@ScriptFullPath,-1,$hnd_gui_main)

	;----------------------------------------------------------------------------------------------
	;Chemin
	;----------------------------------------------------------------------------------------------
	GUICtrlCreateLabel("Chemin",10,10, 50,15)
	$hnd_path_txt = GUICtrlCreateInput ("",10,30,$GUI_WIDTH-40,17)
	GUICtrlSetData($hnd_path_txt,$path)

	;----------------------------------------------------------------------------------------------
	;Browse
	;----------------------------------------------------------------------------------------------
	$hnd_path_btn = GUICtrlCreateButton("...",$GUI_WIDTH-25,30, 20,17)
	GUICtrlSetOnEvent($hnd_path_btn,"_CheckFiles_BrowseDir")

	;----------------------------------------------------------------------------------------------
	;Mode de fonctionnement
	;----------------------------------------------------------------------------------------------
	$hnd_mode = GUICtrlCreateCombo("",10,50,270,100) ;Crée une liste vide
	Local $list = $MODE_SW_0 & "|" & $MODE_SW_1 & "|" & $MODE_LISTE & "|" & $MODE_SUPPR & "|" & $MODE_AJOUT & "|" & $MODE_VERIFIE & "|" & $MODE_CLEAR & "|" & $MODE_CHECK_DB
	GUICtrlSetData($hnd_mode,"")    ;Détruit la liste précédente
	GUICtrlSetData($hnd_mode,$list) ;Ajoute les éléments à la liste
	GUICtrlSetOnEvent($hnd_mode,"_CheckFiles_Event_Mode")
	If $mode=-1 Then
		Switch RegRead($REG_PATH,"Mode")
			Case $MODE_LISTE
				GUICtrlSetData($hnd_mode,$MODE_LISTE)
			Case $MODE_SUPPR
				GUICtrlSetData($hnd_mode,$MODE_SUPPR)
			Case $MODE_AJOUT
				GUICtrlSetData($hnd_mode,$MODE_AJOUT)
			Case $MODE_VERIFIE
				GUICtrlSetData($hnd_mode,$MODE_VERIFIE)
			Case $MODE_CLEAR
				GUICtrlSetData($hnd_mode,$MODE_CLEAR)
			Case $MODE_CHECK_DB
				GUICtrlSetData($hnd_mode,$MODE_CHECK_DB)
			Case Else
				GUICtrlSetData($hnd_mode,$MODE_VERIFIE)
		EndSwitch
	Else
		GUICtrlSetData($hnd_mode,$MODE_VERIFIE)
	EndIf
	;----------------------------------------------------------------------------------------------
	;Type d'empreinte
	;----------------------------------------------------------------------------------------------
	$hnd_fp = GUICtrlCreateCombo("",290,50,80,100)
	Local $fp_list
	$fp_list  = $FP_MD2    & "|"
	$fp_list &= $FP_MD4    & "|"
	$fp_list &= $FP_MD5    & "|"
	$fp_list &= $FP_SHA1   & "|"
	$fp_list &= $FP_SHA224 & "|"
	$fp_list &= $FP_SHA256 & "|"
	$fp_list &= $FP_SHA384 & "|"
	$fp_list &= $FP_SHA512

	GUICtrlSetData   ($hnd_fp,""      ) ;Détruit la liste précédente
	GUICtrlSetData   ($hnd_fp,$fp_list) ;Ajoute les éléments à la liste
	GUICtrlSetOnEvent($hnd_fp,"_CheckFiles_Event_Empreinte")

	If $fp<>"" Then
		_CheckFiles_SetEmpreinte(StringUpper($fp))
	Else
		_CheckFiles_SetEmpreinte(RegRead($REG_PATH,"Empreinte"))
	EndIf

	_CheckFiles_SetParameters()
	;----------------------------------------------------------------------------------------------
	;Récursif
	;----------------------------------------------------------------------------------------------
	$hnd_recursif = GUICtrlCreateCheckbox("Récursif",$GUI_WIDTH-70,50,-1,-1,$BS_RIGHTBUTTON)
	GUICtrlSetOnEvent($hnd_recursif,"_CheckFiles_Event_Recursif")
	If RegRead($REG_PATH,"Recursif")=1 Then GUICtrlSetState($hnd_recursif,$GUI_CHECKED)

	;----------------------------------------------------------------------------------------------
	;Start
	;----------------------------------------------------------------------------------------------
	$hnd_start = GUICtrlCreateButton("Start",225,80)
	GUICtrlSetOnEvent($hnd_start,"_CheckFiles_Event_Start")

	;----------------------------------------------------------------------------------------------
	;Exclusions
	;----------------------------------------------------------------------------------------------
	$hnd_exc_btn = GUICtrlCreateButton("Exclusions",100,80)
	GUICtrlSetOnEvent($hnd_exc_btn,"_CheckFiles_Exclusions_Event")

	;----------------------------------------------------------------------------------------------
	;GUI - Partie 2
	;----------------------------------------------------------------------------------------------
	GUISetState(@SW_SHOW,$hnd_gui_main)
	ControlFocus("","",$hnd_start)
	WinActivate($hnd_gui_main)

	Opt("GUIOnEventMode", 1)
	GUISetOnEvent($GUI_EVENT_CLOSE,"_CheckFiles_GUI_Close_Wo_Arg")

	While $hnd_gui_main() <> 0
		Sleep(10)
	WEnd
EndFunc
;###############################################################################################################################################################
;Fermeture d'une interface graphique
;###############################################################################################################################################################
Func _CheckFiles_GUI_Close_Wo_Arg()
	_CheckFiles_GUI_Close_W_Arg(@GUI_WinHandle)
EndFunc

Func _CheckFiles_GUI_Close_W_Arg($hnd)
	Switch $hnd
		Case $hnd_gui_main
			$hnd_gui_main = 0
		Case $hnd_exc_gui
			_CheckFiles_Exclusions_Save()
			$hnd_exc_gui = 0
	EndSwitch
	GUIDelete($hnd)
EndFunc
