#include-once
#include <CheckFiles_Global.au3>

; #FUNCTION# ====================================================================================================================
; Name ..........: _CheckFiles_AnalyseFiles_Mode_7_Check_DB
; Description ...: Vérifie la structure de la database
; Syntax ........: _CheckFiles_AnalyseFiles_Mode_7_Check_DB($path)
; Parameters ....: $path                - A pointer value.
; Return values .: None
; Author ........: Jean-Louis FLOQUET
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _CheckFiles_AnalyseFiles_Mode_7_Check_DB($path)
	Local Const $DB_FILENAME = $path & "\" & $DB_LOCAL_NAME
	If FileExists($DB_FILENAME)=0 Then Return 0

	_CheckFiles_Hash_Load($DB_FILENAME)
;	_ArrayDisplay($hash_list)

	For $i=$hash_list[0] To 1 Step -1
		;La ligne contient une 2ème "*", ce qui ressemble à deux lignes concaténées en 1
		If StringRegExp($hash_list[$i],"\A([0-9a-fA-F]){" & $FP_LENGTH & "} \*([^*])+\z")=0 Then
			_CheckFiles_LogWrite($log,_CheckFiles_Heure() & " - wrong DB  : " & $DB_FILENAME & " (ligne " & $i & "). Was '" & $hash_list[$i] & "'")
			_ArrayDelete($hash_list,$i)
			_CheckFiles_Hash_Save($DB_FILENAME)
			$NbFilesKO += 1
		EndIf
	Next
EndFunc
