#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Version=Beta
#AutoIt3Wrapper_UseX64=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include-once
#include <CheckFiles_Global.au3>
; #FUNCTION# ====================================================================================================================
; Name ..........: _CheckFiles_LogWrite
; Description ...:
; Syntax ........: _CheckFiles_LogWrite($file, $str)
; Parameters ....: $file   : nom complet du fichier de journalisation
;                  $str    : ligne à écrire (au format Unicode)
; Return values .: None
; Author ........: Jean-Louis FLOQUET
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _CheckFiles_LogWrite($file,$str)
	Local $hnd
	$hnd = FileOpen($file,$FO_APPEND+$FO_UTF16_LE)
	FileWriteLine($hnd,$str)
	FileClose($hnd)
EndFunc
