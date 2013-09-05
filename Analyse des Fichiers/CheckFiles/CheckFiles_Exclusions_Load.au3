#include-once
#include <CheckFiles_Global.au3>

; #FUNCTION# ====================================================================================================================
; Name ..........: _CheckFiles_Exclusions_Load
; Description ...: Exclusions / Charge la liste
; Syntax ........: _CheckFiles_Exclusions_Load()
; Parameters ....:
; Return values .: None
; Author ........: Jean-Louis FLOQUET
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _CheckFiles_Exclusions_Load()
	Local $liste_arr = IniReadSection($INI_FILE,"Exclusions")
	If @error Then Return 0
	Local $liste_txt

	ReDim $exc_arr[$liste_arr[0][0]+1]

	$exc_arr[0] = $liste_arr[0][0]

	;Récupère la liste des expressions régulières
	For $i=1 To $liste_arr[0][0]
		$exc_arr[$i] = $liste_arr[$i][1]
	Next
EndFunc
