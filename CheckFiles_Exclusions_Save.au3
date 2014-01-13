#include-once
#include <CheckFiles_Global.au3>

; #FUNCTION# ====================================================================================================================
; Name ..........: _CheckFiles_Exclusions_Save
; Description ...: Exclusions / Sauvegarde la liste
; Syntax ........: _CheckFiles_Exclusions_Save()
; Parameters ....:
; Return values .: None
; Author ........: Jean-Louis FLOQUET
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _CheckFiles_Exclusions_Save()
	Local $liste  ;Liste des exclusions

	$liste = GUICtrlRead($hnd_exc_lst)     ;Récupère la chaîne
	$liste = StringSplit($liste,@CRLF,1+2) ;La transforme en tableau sans renvoyer le nombre d'éléments dans le tableau

	;Nettoyage du tableau
	For $i=UBound($liste)-1 To 0 Step -1
		;Supprime les entrées vides
		If StringRegExp($liste[$i],"\A\s*\z") Then
			_ArrayDelete($liste,$i)
		;Supprime les caractères vides en début & fin de chaîne
		Else
			$liste[$i] = StringStripWS($liste[$i],1+2) ;1 = strip leading white space / 2 = strip trailing white space
		EndIf
	Next

	;Supprime les doublons dans la tableau (à faire après avoir nettoyé le tableau)
	$liste = _ArrayUnique($liste)          ;Cette opération renvoie en ligne 0 le nombre d'éléments dans le tableau
	_ArrayDelete($liste,0)
	_ArraySort($liste)

	;Supprime la liste précédente
	IniDelete($INI_FILE,"Exclusions")

	;Ajoute la liste des inclusions
	For $i=0 To UBound($liste)-1
		If StringLeft($liste[$i],1)<>"!" Then
			IniWrite($INI_FILE,"Exclusions",StringFormat("exclude_%03d",$i),$liste[$i])
		EndIf
	Next

EndFunc
