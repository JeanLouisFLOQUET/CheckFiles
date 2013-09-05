#include-once
#include <CheckFiles_Global.au3>

; #FUNCTION# ====================================================================================================================
; Name ..........: _CheckFiles_TimeFormat
; Description ...: Time Format
; Syntax ........: _CheckFiles_TimeFormat($millisecondes)
; Parameters ....: $millisecondes       - An unknown value.
; Return values .: None
; Author ........: Jean-Louis FLOQUET
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _CheckFiles_TimeFormat($millisecondes)
	Local $secondes, $minutes, $heures, $jours
	Local $result

	$secondes  = Int($millisecondes / 1000)

	$jours     = Int($secondes / 86400)
	$secondes -=     $jours    * 86400

	$heures    = Int($secondes /  3600)
	$secondes -=     $heures   *  3600

	$minutes   = Int($secondes /    60)
	$secondes -=     $minutes  *    60

	If $jours<>0 Then
		$result = StringFormat("%d jours %d heures %d minutes %d secondes",$jours,$heures,$minutes,$secondes)
	ElseIf $heures<>0 Then
		$result = StringFormat("%d heures %d minutes %d secondes",$heures,$minutes,$secondes)
	ElseIf $minutes<>0 Then
		$result = StringFormat("%d minutes %d secondes",$minutes,$secondes)
	Else
		$result = StringFormat("%d.%03d secondes",$secondes,$millisecondes)
	EndIf
	Return $result
EndFunc
