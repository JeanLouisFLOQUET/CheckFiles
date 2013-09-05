#include-once
#include <CheckFiles_Global.au3>

; #FUNCTION# ====================================================================================================================
; Name ..........: _CheckFiles_AnalyseFiles_Mode_3_Suppr
; Description ...: Supprime les entrées dont le fichier n'existe plus
; Syntax ........: _CheckFiles_AnalyseFiles_Mode_3_Suppr($path)
; Parameters ....: $path                - A pointer value.
; Return values .: None
; Author ........: Jean-Louis FLOQUET
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _CheckFiles_AnalyseFiles_Mode_3_Suppr($path)
	Local Const $DB_FILENAME = $path & "\" & $DB_LOCAL_NAME
	If FileExists($DB_FILENAME)=0 Then Return

	;Charge la database
	_CheckFiles_Hash_Load($DB_FILENAME)

	Local $filename, $empreinte

	For $i=$hash_list[0] To 1 Step -1
		If $req_stop Then Return
		$filename = $path & "\" & _CheckFiles_Hash_FromIndex_GetFileName($i)
		If FileExists($filename)=0 Then
			;Message
			_CheckFiles_Tip_Update("Suppression de l'entrée : " & $filename)

			;Journalise cet évènement
			$empreinte = _CheckFiles_Hash_FromIndex_GetEmpreinte($i)
			FileWriteLine($log,_CheckFiles_Heure() & " - file not found : (" & $empreinte & ") -> " & $filename)
			$NbFilesKO += 1

			;Supprime l'entrée de la database
			_ArrayDelete($hash_list,$i)
			$hash_list[0] -= 1


			;Sauvegarde la database (que si elle a été modifiée)
			_CheckFiles_Hash_Save($DB_FILENAME)
		EndIf
	Next
EndFunc
