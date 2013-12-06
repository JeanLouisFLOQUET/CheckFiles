#include-once
#include <CheckFiles_Global.au3>

; #FUNCTION# ====================================================================================================================
; Name ..........: _CheckFiles_Exclusions_Fix
; Description ...: Exclusions / Corrige les RegExp
; Syntax ........: _CheckFiles_Exclusions_Fix()
; Parameters ....:
; Return values .: None
; Author ........: Jean-Louis FLOQUET
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _CheckFiles_Exclusions_Fix()
	;Remplace le "*" par sa RegExp
	For $i=1 To $exc_arr[0]
		$exc_arr[$i] = StringReplace($exc_arr[$i],"*",".*")
	Next

	;Si une RegExp pointe sur un dossier, ajoute le morceau ad-hoc pour les sous-dossiers
	For $i=1 To $exc_arr[0]
		If StringInStr($exc_arr[$i],"\") Then
			$exc_arr[$i]  = StringReplace($exc_arr[$i],"\","\\")
			$exc_arr[$i] &= "(\\.*)*"
		EndIf
	Next
EndFunc
