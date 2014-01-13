#include-once
#include <CheckFiles_Global.au3>

; #FUNCTION# ====================================================================================================================
; Name ..........: _CheckFiles_AnalyseFiles_Mode_6_Clear
; Description ...: Supprime les fichiers d'empreinte
; Syntax ........: _CheckFiles_AnalyseFiles_Mode_6_Clear($path)
; Parameters ....: $path                - A pointer value.
; Return values .: None
; Author ........: Jean-Louis FLOQUET
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _CheckFiles_AnalyseFiles_Mode_6_Clear($path)
	Local Const $DB_FILENAME = $path & "\" & $DB_LOCAL_NAME
	If FileExists($DB_FILENAME) Then
		 _CheckFiles_Tip_Update("Suppression du fichier : " & $DB_FILENAME)
		FileDelete($DB_FILENAME)
	EndIf
EndFunc
