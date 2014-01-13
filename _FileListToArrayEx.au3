#include-once

; #FUNCTION# ====================================================================================================================
; Name...........: _FileListToArrayEx
; Description ...: Lists files and\or folders in a specified path (Similar to using Dir with the /B Switch)
; Syntax.........: _FileListToArrayEx($sPath[, $sFilter = "*"[, $iFlag = 0 [, $sSDir = 0]]])
; Parameters ....: $sPath   - Path to generate filelist for.
;                  $sFilter - Optional the filter to use, default is *. (Multiple filter groups such as "*.png|*.jpg|*.bmp") Search the Autoit3 helpfile for the word "WildCards" For details.
;                  $iFlag   - Optional: specifies whether to return files folders or both
;                  |$iFlag=0(Default) Return both files and folders
;                  |$iFlag=1 Return files only
;                  |$iFlag=2 Return Folders only
;                  $sSDir   - Optional: specifies whether to return files folders or both
;                  |$sSDir=1 Search subdirectory
;                  |$sSDir=2 Search subdirectory & Return Full Path
; Return values .: @Error - 1 = Path not found or invalid
;                  |2 = Invalid $sFilter
;                  |3 = Invalid $iFlag
;                  |4 = No File(s) Found
; Author ........: SolidSnake <metalgx91 at="" gmail="" dot="" com="">
; Modified.......:
; Remarks .......: The array returned is one-dimensional and is made up as follows:
;                                $array[0] = Number of Files\Folders returned
;                                $array[1] = 1st File\Folder
;                                $array[2] = 2nd File\Folder
;                                $array[3] = 3rd File\Folder
;                                $array[n] = nth File\Folder
; Related .......:
; Link ..........: http://www.autoitscript.com/forum/topic/131277-filelisttoarrayex
; Example .......: Yes
; Note ..........: Special Thanks to Helge and Layer for help with the $iFlag update speed optimization by code65536, pdaughe
;                  Update By DXRW4E
; ===============================================================================================================================
Func _FileListToArrayEx($sPath, $sFilter = "*", $iFlag = 0, $sSDir = 0)
	Local $hSearch, $sFile, $sFileList, $sDelim = "|", $sSDirFTMP = $sFilter
	$sPath = StringRegExpReplace($sPath, "[\\/]+\z", "") & "\" ; ensure single trailing backslash
	If Not FileExists($sPath) Then Return SetError(1, 1, "")
	If StringRegExp($sFilter, "[\\/:><]|(?s)\A\s*\z") Then Return SetError(2, 2, "")
	If Not ($iFlag = 0 Or $iFlag = 1 Or $iFlag = 2) Then Return SetError(3, 3, "")
	$hSearch = FileFindFirstFile($sPath & "*")
	If @error Then Return SetError(4, 4, "")
	Local $hWSearch = $hSearch, $hWSTMP = $hSearch, $SearchWD, $FPath = StringRegExpReplace(StringRegExpReplace($sSDir, '[^2]+', ""), "2+", StringRegExpReplace($sPath, '\\', "\\\\")), $sSDirF[3] = [0, StringReplace($sSDirFTMP, "*", ""), "(?i)(" & StringRegExpReplace(StringRegExpReplace(StringRegExpReplace(StringRegExpReplace(StringRegExpReplace(StringRegExpReplace("|" & $sSDirFTMP & "|", '\|\h*\|[\|\h]*', "\|"), '[\^\$\(\)\+\[\]\{\}\,\.\=]', "\\$0"), "\|([^\*])", "\|^$1"), "([^\*])\|", "$1\$\|"), '\*', ".*"), '^\||\|$', "") & ")"]
	While 1
		$sFile = FileFindNextFile($hWSearch)
		If @error Then
			If $hWSearch = $hSearch Then ExitLoop
			FileClose($hWSearch)
			$hWSearch -= 1
			$SearchWD = StringLeft($SearchWD, StringInStr(StringTrimRight($SearchWD, 1), "\", 1, -1))
		ElseIf $sSDir Then
			$sSDirF[0] = @extended
			If ($iFlag + $sSDirF[0] <> 2) Then
				If $sSDirF[1] Then
					If StringRegExp($sFile, $sSDirF[2]) Then $sFileList &= $sDelim & $FPath & $SearchWD & $sFile
				Else
					$sFileList &= $sDelim & $FPath & $SearchWD & $sFile
				EndIf
			EndIf
			If Not $sSDirF[0] Then ContinueLoop
			$hWSTMP = FileFindFirstFile($sPath & $SearchWD & $sFile & "\*")
			If $hWSTMP = -1 Then ContinueLoop
			$hWSearch = $hWSTMP
			$SearchWD &= $sFile & "\"
		Else
			If ($iFlag + @extended = 2) Or StringRegExp($sFile, $sSDirF[2]) = 0 Then ContinueLoop
			$sFileList &= $sDelim & $sFile
		EndIf
	WEnd
	FileClose($hSearch)
	If Not $sFileList Then Return SetError(4, 4, "")
	Return StringSplit(StringTrimLeft($sFileList, 1), "|")
EndFunc   ;==>_FileListToArrayEx
