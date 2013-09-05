#include-once
#include <CheckFiles_Global.au3>

; #FUNCTION# ====================================================================================================================
; Name ..........: _CheckFiles_AnalyseFiles_Mode_4_Ajout
; Description ...: Ajoute l'empreinte des nouveaux fichiers
; Syntax ........: _CheckFiles_AnalyseFiles_Mode_4_Ajout($path)
; Parameters ....: $path                - A pointer value.
; Return values .: None
; Author ........: Jean-Louis FLOQUET
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _CheckFiles_AnalyseFiles_Mode_4_Ajout($path)
	Local $files = _FileListToArrayEx($path,"*",1,0)
	If @error<>0 Then Return ;erreur d'accès à ce dossier (chemin invalide, pas de fichier, pas le droit...)

	;Détermine le fichier de la database
	Local Const $DB_FILENAME = $path & "\" & $DB_LOCAL_NAME

	Local $fp_saved, $fp_comptd
	Local $filename, $result, $error

	;Charge la database
	_CheckFiles_Hash_Load($DB_FILENAME)

	For $i=1 To $files[0]
		If $req_stop Then Return

		;Ignore les fichiers de DataBase (tous les formats supportés)
		If $files[$i]=$DB_LOCAL_NAME_MD2    Then ContinueLoop
		If $files[$i]=$DB_LOCAL_NAME_MD4    Then ContinueLoop
		If $files[$i]=$DB_LOCAL_NAME_MD5    Then ContinueLoop
		If $files[$i]=$DB_LOCAL_NAME_SHA1   Then ContinueLoop
		If $files[$i]=$DB_LOCAL_NAME_SHA224 Then ContinueLoop
		If $files[$i]=$DB_LOCAL_NAME_SHA256 Then ContinueLoop
		If $files[$i]=$DB_LOCAL_NAME_SHA384 Then ContinueLoop
		If $files[$i]=$DB_LOCAL_NAME_SHA512 Then ContinueLoop

		;Construit le nom complet du fichier
		$filename = $path & "\" & $files[$i]

		;Ignore les fichiers vide
		If FileGetSize($filename)=0 Then ContinueLoop

		;Lit l'empreinte stockée
		$fp_saved = _CheckFiles_Hash_GetFromFile($files[$i])

		;Si aucune entrée n'a été trouvée
		If $fp_saved=-1 Then
			 _CheckFiles_Tip_Update("[dossier : " & $DirIndex & "/" & $TotDir[0] & "] [fichier : " & $i & "/" & $files[0] & "] : " & $filename)
			$NbTotFiles += 1

			$result = DllCall($dll_hnd,"int:cdecl",$dll_function,"str",$filename,"str","xxx")                                    ;Appelle la DLL pour calculer l'empreinte
			$error  = @error
			If $error Then
				If $error=3 Then MsgBox($MB_ICONASTERISK,"CheckFiles","DllCall error code=3 (fonction non trouvée dans la DLL)")
				ContinueLoop                                                                                                     ;En cas d'erreur -> passe au fichier suivant
			EndIf
			$fp_comptd = $result[2]                                                                                              ;Extrait l'empreinte du tableau renvoyé
			_CheckFiles_Hash_Write($DB_FILENAME,$files[$i],$fp_comptd)                                                           ;Sauvegarde l'empreinte dans la database
		EndIf
	Next
EndFunc
