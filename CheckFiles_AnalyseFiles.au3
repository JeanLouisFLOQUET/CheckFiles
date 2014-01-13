#include-once
#include <CheckFiles_Global.au3>

; #FUNCTION# ====================================================================================================================
; Name ..........: _CheckFiles_AnalyseFiles
; Description ...: Traitement des fichiers
; Syntax ........: _CheckFiles_AnalyseFiles($path, $ModeAnalyse)
; Parameters ....: $path                - A pointer value.
;                  $ModeAnalyse         - An unknown value.
; Return values .: None
; Author ........: Jean-Louis FLOQUET
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _CheckFiles_AnalyseFiles($path,$ModeAnalyse)
	Switch $ModeAnalyse
		Case $MODE_LISTE
			_CheckFiles_AnalyseFiles_Mode_2_Liste($path)
		Case $MODE_SUPPR
			_CheckFiles_AnalyseFiles_Mode_3_Suppr($path)
		Case $MODE_AJOUT
			_CheckFiles_AnalyseFiles_Mode_4_Ajout($path)
		Case $MODE_VERIFIE
			_CheckFiles_AnalyseFiles_Mode_5_Verifie($path)
		Case $MODE_CLEAR
			_CheckFiles_AnalyseFiles_Mode_6_Clear($path)
		Case $MODE_CHECK_DB
			_CheckFiles_AnalyseFiles_Mode_7_Check_DB($path)
	EndSwitch
EndFunc
