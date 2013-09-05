#include-once
#include <CheckFiles_Global.au3>

; #FUNCTION# ====================================================================================================================
; Name ..........: _CheckFiles_AnalyseFiles_Mode_5_Verifie
; Description ...: Vérifie l'empreinte des fichiers référencés
; Syntax ........: _CheckFiles_AnalyseFiles_Mode_5_Verifie($path)
; Parameters ....: $path                - A pointer value.
; Return values .: None
; Author ........: Jean-Louis FLOQUET
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _CheckFiles_AnalyseFiles_Mode_5_Verifie($path)
	Local Const $DB_FILENAME = $path & "\" & $DB_LOCAL_NAME
	If FileExists($DB_FILENAME)=0 Then Return

	;Charge la database
	_CheckFiles_Hash_Load($DB_FILENAME)

	Local $fp_saved, $fp_comptd
	Local $filename, $result

	;Parcourt la database
	For $i=1 To $hash_list[0]
		If $req_stop Then Return

		;Récupère le nom du fichier référencé
		$filename = $path & "\" & _CheckFiles_Hash_FromIndex_GetFileName($i)
		 _CheckFiles_Tip_Update($filename)

		;Le fichier référencé n'existe pas
		If FileExists($filename)=0 Then
			FileWriteLine($log,_CheckFiles_Heure() & " - not found : " & $filename)
			$NbFilesKO += 1
			ContinueLoop
		EndIf

		$NbTotFiles += 1

		;Récupère l'empreinte de référence
		$fp_saved = _CheckFiles_Hash_FromIndex_GetEmpreinte($i)

		;Calcule l'empreinte du fichier actuel
		$result = DllCall($dll_hnd,"int:cdecl",$dll_function,"str",$filename,"str","xxx") ;Appelle la DLL pour calculer l'empreinte
		If @error Then
			FileWriteLine($log,_CheckFiles_Heure() & " - access KO : " & $filename)
			$NbFilesKO += 1
		Else
			;Extrait l'empreinte du tableau renvoyé
			$fp_comptd = $result[2]

			;Compare
			If $fp_saved<>$fp_comptd Then
				FileWriteLine($log,StringFormat("%s - wrong %s (exp=%s,got=%s) : %s",_CheckFiles_Heure(),$Empreinte,$fp_saved,$fp_comptd,$filename))
;				FileWriteLine($log,_Heure() & " - wrong " & $Empreinte & " : " & $filename)
				$NbFilesKO += 1
			EndIf
		EndIf
	Next
EndFunc
