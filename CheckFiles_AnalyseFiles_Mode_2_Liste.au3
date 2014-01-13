#include-once
#include <CheckFiles_Global.au3>

; #FUNCTION# ====================================================================================================================
; Name ..........: _CheckFiles_AnalyseFiles_Mode_2_Liste
; Description ...: Liste les fichiers introuvables
; Syntax ........: _CheckFiles_AnalyseFiles_Mode_2_Liste($path)
; Parameters ....: $path                - A pointer value.
; Return values .: None
; Author ........: Jean-Louis FLOQUET
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _CheckFiles_AnalyseFiles_Mode_2_Liste($path)
	Local Const $DB_FILENAME = $path & "\" & $DB_LOCAL_NAME
	If FileExists($DB_FILENAME)=0 Then Return

	;Charge la database
	_CheckFiles_Hash_Load($DB_FILENAME)

	Local $filename

	For $i=1 To $hash_list[0]
		If $req_stop Then Return
		$filename = $path & "\" & _CheckFiles_Hash_FromIndex_GetFileName($i)
		If FileExists($filename)=0 Then
			_CheckFiles_LogWrite($log,_CheckFiles_Heure() & " - not found : " & $filename)
			_CheckFiles_Tip_Update("Non trouvé : " & $filename)
			$NbFilesKO += 1
		EndIf
	Next
EndFunc
