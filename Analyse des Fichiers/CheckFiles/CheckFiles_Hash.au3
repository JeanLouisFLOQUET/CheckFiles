#include-once
#include <CheckFiles_Global.au3>

; #FUNCTION# ====================================================================================================================
; Name ..........: _CheckFiles_Hash_Write
; Description ...: Ajoute une entrée au fichier
; Syntax ........: _CheckFiles_Hash_Write($db_file, $file, $value)
; Parameters ....: $db_file             - An unknown value.
;                  $file                - A boolean value.
;                  $value               - A variant value.
; Return values .: None
; Author ........: Jean-Louis FLOQUET
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _CheckFiles_Hash_Write($db_file,$file,$value)
	FileWriteLine($db_file,$value & " *" & $file)
EndFunc

; #FUNCTION# ====================================================================================================================
; Name ..........: _CheckFiles_Hash_Load
; Description ...: Charge la liste des fichiers référencés avec leur empreinte
; Syntax ........: _CheckFiles_Hash_Load($db_file)
; Parameters ....: $db_file             - An unknown value.
; Return values .: None
; Author ........: Jean-Louis FLOQUET
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _CheckFiles_Hash_Load($db_file)
	$hash_list[0] = 0 ;Valeur par défaut en cas de fichier $db_file non trouvé
	_FileReadToArray($db_file,$hash_list)
EndFunc

; #FUNCTION# ====================================================================================================================
; Name ..........: _CheckFiles_Hash_Save
; Description ...: Sauvegarde la database
; Syntax ........: _CheckFiles_Hash_Save($db_file)
; Parameters ....: $db_file             - An unknown value.
; Return values .: None
; Author ........: Jean-Louis FLOQUET
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _CheckFiles_Hash_Save($db_file)
	Local $hnd = FileOpen($db_file,2)
	Local $txt = _ArrayToString($hash_list,@CRLF,1)
	FileWrite($hnd,$txt)
	FileClose($hnd)
EndFunc

; #FUNCTION# ====================================================================================================================
; Name ..........: _CheckFiles_Hash_GetFromFile
; Description ...: Récupère l'empreinte d'un fichier dans la database qui a été chargée
; Syntax ........: _CheckFiles_Hash_GetFromFile($file)
; Parameters ....: $file                - A boolean value.
; Return values .: None
; Author ........: Jean-Louis FLOQUET
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _CheckFiles_Hash_GetFromFile($file)
	For $i=1 To $hash_list[0]
		If StringMid($hash_list[$i],$FP_LENGTH_P3)=$file Then
			Return StringLeft($hash_list[$i],$FP_LENGTH)
		EndIf
	Next
	Return -1
EndFunc

; #FUNCTION# ====================================================================================================================
; Name ..........: _CheckFiles_Hash_GetFromIndex
; Description ...: Récupère l'empreinte d'un élément de la database
; Syntax ........: _CheckFiles_Hash_GetFromIndex($i)
; Parameters ....: $i                   - An integer value.
; Return values .: None
; Author ........: Jean-Louis FLOQUET
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _CheckFiles_Hash_FromIndex_GetEmpreinte($i)
	Return StringLeft($hash_list[$i],$FP_LENGTH)
EndFunc

; #FUNCTION# ====================================================================================================================
; Name ..........: _CheckFiles_Hash_GetFileNameFromIndex
; Description ...: Récupère le nom du fichier d'un élément de la database
; Syntax ........: _CheckFiles_Hash_GetFileNameFromIndex($i)
; Parameters ....: $i                   - An integer value.
; Return values .: None
; Author ........: Jean-Louis FLOQUET
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _CheckFiles_Hash_FromIndex_GetFileName($i)
	Return StringMid($hash_list[$i],$FP_LENGTH_P3)
EndFunc
