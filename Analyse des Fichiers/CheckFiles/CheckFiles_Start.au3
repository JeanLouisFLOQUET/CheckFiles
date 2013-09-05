#include-once
#include <CheckFiles_Global.au3>

; #FUNCTION# ====================================================================================================================
; Name ..........: _CheckFiles_Start
; Description ...: Principal
; Syntax ........: _CheckFiles_Start($path, $ModeAnalyse)
; Parameters ....: $path                - A pointer value.
;                  $ModeAnalyse         - An unknown value.
; Return values .: None
; Author ........: Jean-Louis FLOQUET
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _CheckFiles_Start($path,$ModeAnalyse)
	Local $MyPath = $path

	;Sauvegarde les options
	_CheckFiles_Event_Recursif()
	RegWrite($REG_PATH,"Dir","REG_SZ",$path)

	If $ModeAnalyse=$MODE_CLEAR Then
		Local $answer = MsgBox($MB_ICONHAND + $MB_YESNO,"Confirmation","Voulez-vous vraiment supprimer tous les fichiers d'empreinte ??")
		If $answer=$IDNO Then Return
	EndIf

	;Affiche la fenêtre de sortie
	_CheckFiles_Tip_Create()
	_CheckFiles_Tip_Update("Analyse de l'arborescence...")

	;Transforme "C:\" en "C:"
	If StringRegExp($MyPath,"\A[[:alpha:]]:\\\z") Then $MyPath = StringRegExpReplace($MyPath,"\\","")

	;-----------------------------------------------------------------------------------------------------------
	;Compte le nombre de dossiers et sous-dossiers
	;-----------------------------------------------------------------------------------------------------------
	Local $recursif = GUICtrlRead($hnd_recursif)
	$TotDir = _FileListToArrayEx($MyPath,"*",2,$recursif) ;Compte seulement les dossiers (3ème arg) et sous-dossiers si récursif (4ème arg)
	If @error Then
		$TotDir = StringSplit($TotDir,"doesn't_matter",2)
		$TotDir[0] = 0
	Else
		;Crée les chemins complets
		For $i=1 To $TotDir[0]
			$TotDir[$i] = $MyPath & "\" & $TotDir[$i]
		Next

		;Elimine les dossiers exclus (les RegExp ont été corrigées pour exclure aussi les sous-dossiers si nécessaire)
		For $i=$TotDir[0] To 1 Step -1
			For $x=1 To $exc_arr[0]
				If StringRegExp($TotDir[$i],"\A" & $exc_arr[$x] & "\z") Then
					_ArrayDelete($TotDir,$i)
					$TotDir[0] -= 1
					ExitLoop
				EndIf
			Next
		Next
	EndIf

	;Ajoute le chemin $MyPath au tableau (on a tous ses sous-dossiers, mais pas lui-même)
	_ArrayAdd($TotDir,$MyPath)
	$TotDir[0] += 1

	$DirIndex   = 1
	$NbTotFiles = 0

	;-----------------------------------------------------------------------------------------------------------
	;Crée un fichier temporaire pour le journal
	;-----------------------------------------------------------------------------------------------------------
	$log = @TempDir & "\CheckFiles_LOG_" & @YEAR & @MON & @YDAY & "_" & @HOUR & @MIN & @SEC & ".txt"

	;-----------------------------------------------------------------------------------------------------------
	;Lance l'analyse
	;-----------------------------------------------------------------------------------------------------------
	For $i=1 To $TotDir[0]
		If $req_stop Then Return
		_CheckFiles_Tip_Update("[dossier : " & $DirIndex & "/" & $TotDir[0] & "] : " & $TotDir[$i])
		$DirIndex = _Min($DirIndex+1,$TotDir[0])
		_CheckFiles_AnalyseFiles($TotDir[$i],$ModeAnalyse)
	Next

	;-----------------------------------------------------------------------------------------------------------
	;Bilan de l'analyse
	;-----------------------------------------------------------------------------------------------------------
	Switch $ModeAnalyse
		Case $MODE_LISTE
			If $NbFilesKO=0 Then
				_CheckFiles_Tip_Update("Aucune erreur détectée")
				MsgBox($MB_ICONASTERISK,"Rapport","Aucune erreur détectée")
			Else
				If $NbFilesKO=1 Then
					_CheckFiles_Tip_Update("1 erreur détectée")
				Else
					_CheckFiles_Tip_Update($NbFilesKO & " erreurs détectées")
				EndIf
				MsgBox($MB_ICONHAND,"Rapport","Erreurs détectées : " & $NbFilesKO)
			EndIf

		Case $MODE_AJOUT
			_CheckFiles_Tip_Update("Terminé")
			MsgBox($MB_ICONASTERISK,"Rapport","Fichiers analysés : " & $NbTotFiles & @CRLF & "Durée : " & _CheckFiles_TimeFormat(TimerDiff($timer)))

		Case $MODE_VERIFIE
			If $NbFilesKO=0 Then
				_CheckFiles_Tip_Update("Aucune erreur détectée")
				MsgBox($MB_ICONASTERISK,"Rapport",                       _
				       "Aucune erreur détectée"               & @CRLF &  _
				       "Fichiers analysés : "   & $NbTotFiles & @CRLF &  _
					   "Durée : " & _CheckFiles_TimeFormat(TimerDiff($timer))       _
				       )
			Else
				If $NbFilesKO=1 Then
					 _CheckFiles_Tip_Update("1 erreur détectée")
				Else
					 _CheckFiles_Tip_Update($NbFilesKO & " erreurs détectées")
				EndIf
				MsgBox($MB_ICONHAND,"Rapport",                        _
					   "Erreurs détectées : " & $NbFilesKO  & @CRLF & _
				       "Fichiers analysés : " & $NbTotFiles & @CRLF & _
					   "Durée : " & _CheckFiles_TimeFormat(TimerDiff($timer))    _
					   )
			EndIf

		Case $MODE_CHECK_DB
			If $NbFilesKO=0 Then
				_CheckFiles_Tip_Update("Aucune erreur détectée")
				MsgBox($MB_ICONASTERISK,"Rapport","Aucune erreur détectée")
			Else
				If $NbFilesKO=1 Then
					_CheckFiles_Tip_Update("1 erreur détectée")
				Else
					_CheckFiles_Tip_Update($NbFilesKO & " erreurs détectées")
				EndIf
				MsgBox($MB_ICONHAND,"Rapport",                       _
				       "Erreurs détectées : " & $NbFilesKO & @CRLF & _
					   "Durée : " & _CheckFiles_TimeFormat(TimerDiff($timer))   _
					   )
			EndIf
	EndSwitch

	If $NbFilesKO Then
		Local $answer = MsgBox($MB_ICONASTERISK+$MB_YESNO,"Rapport","Voulez-vous afficher le journal ?")
		If $answer=$IDYES Then
			ShellExecute(@WindowsDir & "\notepad.exe",$log)
		EndIf
	EndIf

	Sleep(1500)
	GUIDelete($tip_gui_hnd)
EndFunc
