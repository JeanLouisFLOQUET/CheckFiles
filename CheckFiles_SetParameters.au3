#include-once
#include <CheckFiles_Global.au3>

; #FUNCTION# ====================================================================================================================
; Name ..........: _CheckFiles_SetParameters
; Description ...: Défini les paramètres pour l'empreinte choisie
; Syntax ........: _CheckFiles_SetParameters()
; Parameters ....:
; Return values .: None
; Author ........: Jean-Louis FLOQUET
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _CheckFiles_SetParameters()
	Switch GUICtrlRead($hnd_fp)
		Case $FP_MD2
			$dll_function  = "md2_file"
			$FP_LENGTH     = $FP_LENGTH_MD2
			$DB_LOCAL_NAME = $DB_LOCAL_NAME_MD2
			$Empreinte     = $FP_MD2

		Case $FP_MD4
			$dll_function  = "md4_file"
			$FP_LENGTH     = $FP_LENGTH_MD4
			$DB_LOCAL_NAME = $DB_LOCAL_NAME_MD4
			$Empreinte     = $FP_MD4

		Case $FP_MD5
			$dll_function  = "md5_file"
			$FP_LENGTH     = $FP_LENGTH_MD5
			$DB_LOCAL_NAME = $DB_LOCAL_NAME_MD5
			$Empreinte     = $FP_MD5

		Case $FP_SHA1
			$dll_function  = "sha1_file"
			$FP_LENGTH     = $FP_LENGTH_SHA1
			$DB_LOCAL_NAME = $DB_LOCAL_NAME_SHA1
			$Empreinte     = $FP_SHA1

		Case $FP_SHA224
			$dll_function  = "sha224_file"
			$FP_LENGTH     = $FP_LENGTH_SHA224
			$DB_LOCAL_NAME = $DB_LOCAL_NAME_SHA224
			$Empreinte     = $FP_SHA224

		Case $FP_SHA256
			$dll_function  = "sha256_file"
			$FP_LENGTH     = $FP_LENGTH_SHA256
			$DB_LOCAL_NAME = $DB_LOCAL_NAME_SHA256
			$Empreinte     = $FP_SHA256

		Case $FP_SHA384
			$dll_function  = "sha384_file"
			$FP_LENGTH     = $FP_LENGTH_SHA384
			$DB_LOCAL_NAME = $DB_LOCAL_NAME_SHA384
			$Empreinte     = $FP_SHA384

		Case $FP_SHA512
			$dll_function  = "sha512_file"
			$FP_LENGTH     = $FP_LENGTH_SHA512
			$DB_LOCAL_NAME = $DB_LOCAL_NAME_SHA512
			$Empreinte     = $FP_SHA512

		Case Else
			$Empreinte     = ""
	EndSwitch

	$FP_LENGTH_P3 = $FP_LENGTH + 3
EndFunc
