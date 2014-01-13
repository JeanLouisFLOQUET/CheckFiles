#include-once
#include <CheckFiles_Global.au3>

; #FUNCTION# ====================================================================================================================
; Name ..........: _CheckFiles_Tip_Create
; Description ...: Tooltip
; Syntax ........: _CheckFiles_Tip_Create()
; Parameters ....:
; Return values .: None
; Author ........: Jean-Louis FLOQUET
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _CheckFiles_Tip_Create()
	$tip_gui_hnd = GUICreate("JLF CheckFiles Tooltip",$tip_gui_width,$tip_gui_height,0,0, $WS_POPUP, BitOR($WS_EX_TOOLWINDOW, $WS_EX_TOPMOST))
	$tip_lbl_hnd = GUICtrlCreateLabel("",0,0, $tip_gui_width, $tip_gui_height, BitOR($SS_LEFT, $SS_LEFTNOWORDWRAP), $GUI_WS_EX_PARENTDRAG)
	GUISetState(@SW_SHOW, $tip_gui_hnd)
EndFunc

