#include-once
#include <CheckFiles_Global.au3>

; #FUNCTION# ====================================================================================================================
; Name ..........: _CheckFiles_Hash_Write
; Description ...: Ajoute une entr�e au fichier
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
	Local $hnd, $char, $size

	;R�cup�re la taille du fichier
	$size = FileGetSize($db_file)

	;Ouvre le fichier en lecture/�criture (append)
	_CheckFiles_Hash_ConvertUnicode($db_file)
	$hnd = FileOpen($db_file,$FO_APPEND+$FO_UTF16_LE)

	;Se d�place � l'avant-dernier caract�re du fichier
	FileSetPos($hnd,-2,$FILE_END)

	;V�rifie que le fichier se termine bien par @CRLF
	$char = FileRead($hnd,1)
	$char = Asc($char)
	If $char<>10 And $size>0 Then
		FileWrite($hnd,@CRLF)
	EndIf

	;Ajoute l'entr�e fournie en param�tres
	FileWrite($hnd,$value & " *" & $file & @CRLF)

	;Ferme le fichier
	FileClose($hnd)
EndFunc

; #FUNCTION# ====================================================================================================================
; Name ..........: _CheckFiles_Hash_Load
; Description ...: Charge la liste des fichiers r�f�renc�s avec leur empreinte
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
	$hash_list[0] = 0 ;Valeur par d�faut en cas de fichier $db_file non trouv�
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
	_CheckFiles_Hash_ConvertUnicode($db_file)
	Local $hnd = FileOpen($db_file,$FO_OVERWRITE+$FO_UTF16_LE)
	Local $txt = _ArrayToString($hash_list,@CRLF,1)
	FileWrite($hnd,$txt)
	FileClose($hnd)
EndFunc

; #FUNCTION# ====================================================================================================================
; Name ..........: _CheckFiles_Hash_GetFromFile
; Description ...: R�cup�re l'empreinte d'un fichier dans la database qui a �t� charg�e
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
; Description ...: R�cup�re l'empreinte d'un �l�ment de la database
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
; Description ...: R�cup�re le nom du fichier d'un �l�ment de la database
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


; #FUNCTION# ====================================================================================================================
; Name ..........: _CheckFiles_Hash_ConvertUnicode
; Description ...:
; Syntax ........: _CheckFiles_Hash_ConvertUnicode($file)
; Parameters ....: $file                - Convertit un fichier au format Unicode
; Return values .: None
; Author ........: Your Name
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _CheckFiles_Hash_ConvertUnicode($file)
	Local $encoding = FileGetEncoding($file)
	If $encoding<>32 Then
		Local $hnd = FileOpen($file,$encoding)
		Local $txt = FileRead($hnd)
		FileClose($hnd)
		FileOpen($file,$FO_OVERWRITE+$FO_UTF16_LE)
		FileWrite($hnd,$txt)
		FileClose($hnd)
	EndIf
EndFunc
