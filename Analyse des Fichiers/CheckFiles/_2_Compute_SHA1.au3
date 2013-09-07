#include <checksums.au3>
#include <FileConstants.au3>
Opt("MustDeclareVars",1)

Local $txt, $sha1, $hnd

;Lit le fichier (ouverture + fermeture)
$txt  = FileRead("CheckFiles_Global.au3")

;Calcule l'empreinte de la DLL
$sha1 = _SHA1ForFile("CheckFiles_x86.dll")

;Remplace l'ancienne empreinte par la nouvelle
$txt = StringRegExpReplace($txt,"Global Const \$DLL_SHA1( +)= ""(\w{40})(.*)","Global Const \$DLL_SHA1$1= """ & $sha1 & "$3")

;Met à jour le fichier "CheckFiles_Global.au3"
$hnd = FileOpen("CheckFiles_Global.au3",$FO_OVERWRITE)
FileWrite($hnd,$txt)
FileClose($hnd)
