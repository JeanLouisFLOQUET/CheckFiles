#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Version=beta
#AutoIt3Wrapper_Icon=shell32 145.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseX64=n
#AutoIt3Wrapper_Res_Description=JLF CheckFiles
#AutoIt3Wrapper_Res_Fileversion=3.3.2.71
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=p
#AutoIt3Wrapper_Res_LegalCopyright=Jean-Louis FLOQUET
#AutoIt3Wrapper_Res_Language=1036
#AutoIt3Wrapper_Run_Before=_1_makefile_DLL_MinGW.bat
#AutoIt3Wrapper_Run_Before=_2_Compute_SHA1.au3
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
;#######################################################################################################################
; Auteur      : Jean-Louis FLOQUET
; Titre       : JLF CheckFiles
; Fichier     : CheckFiles.au3
; Création    : 14 avril 2013
; Mise à jour : 2013/09/11 10:08
; Dépendance  : Aucune
;#######################################################################################################################
; Description  #
;###############
; CheckFiles est un outil de vérification de l'intégrité de fichiers par leur empreinte.
;
;================================================================================
;Empreintes : MD2, MD4, MD5, SHA-1, SHA-224, SHA-256, SHA-384, SHA-512
;================================================================================
; Le calcul des signatures est entièrement basé sur les codes sources du projet Polar SSL (https://polarssl.org/).
; La fonction 'md2_file'    a été adaptée pour retourner une chaîne hexadécimale 128 bits ( 32 caractères)
; La fonction 'md4_file'    a été adaptée pour retourner une chaîne hexadécimale 128 bits ( 32 caractères)
; La fonction 'md5_file'    a été adaptée pour retourner une chaîne hexadécimale 128 bits ( 32 caractères)
; La fonction 'sha1_file'   a été adaptée pour retourner une chaîne hexadécimale 160 bits ( 40 caractères)
; La fonction 'sha224_file' a été adaptée pour retourner une chaîne hexadécimale 224 bits ( 56 caractères)
; La fonction 'sha256_file' a été adaptée pour retourner une chaîne hexadécimale 256 bits ( 64 caractères)
; La fonction 'sha384_file' a été adaptée pour retourner une chaîne hexadécimale 384 bits ( 96 caractères)
; La fonction 'sha512_file' a été adaptée pour retourner une chaîne hexadécimale 512 bits (128 caractères)
; Version du projet PolarSSL : 1.2.7
; Les codes sources ont ensuite été compilés avec MinGW
; Script de compilation : _makefile_DLL_MinGW.bat
;
;================================================================================
;Compilation
;================================================================================
; Codes source AU3 :
;    * CheckFiles.au3         : ce code source
;    * _FileListToArrayEx.au3 : voir ce fichier pour ses auteurs et sa licence
;
;================================================================================
;Base de registre
;================================================================================
; Ajout au menu contextuel => les clés suivantes sont ajoutées :
;      * HKEY_CLASSES_ROOT\Directory\shell\CheckFiles
;      * HKEY_CLASSES_ROOT\Drive\shell\CheckFiles
;      * HKEY_CURRENT_USER\Software\Classes\Applications\CheckFiles.exe
;
; Paramètres : les paramètres de l'application sont sauvegardés sous
;      * HKEY_CURRENT_USER\Software\JLF\CheckFiles
;
;#######################################################################################################################
; Suivi de version              #
;################################
;   Rev.   |    Date    | Description
;  3.03.02 | 2013/09/08 | 1) New : Vérification de l'empreinte de la DLL
;          |            | 2) Fix : Vérification que l'exécutable est bien 32bits (mode x64 non supporté)
;          |            |
;  3.02.03 | 2013/08/20 | 1) New : Messages après installation/désinstallation
;          |            | 2) Fix : Journalalisation des fichiers non trouvés
;          | 2013/08/25 | 3) Fix : Affichage de la durée
;          |            |
;  3.01.03 | 2013/07/02 | 1) New : Liste d'exclusions
;          |            | 2) Enh : Optimisation du parcours des dossiers
;          | 2013/07/26 | 3) Fix : Les fichiers du dossier "racine" n'étaient pas analysés
;-----------------------------------------------------------------------------------------------------------------------
;  2.02.03 | 2013/06/10 | 1) Enh : Le fichiers de database sont ignorés dans le calcul des empreintes
;          |            | 2) New : Ajout de la durée d'exécution en fin de tâche
;          | 2013/06/24 | 3) Enh : Affiche les empreintes attendues/calculées en cas de différence
;          |            |
;  2.01.03 | 2013/05/03 | 1) New : Codes MD2, MD4, SHA-1, SHA-224, SHA-256, SHA-384, SHA-512
;          |            | 2) Fix : Extraction de la DLL dans le dossier de CheckFiles.exe
;          |            | 3) Chg : Le nom du journal est horodaté au lieu d'être aléatoire
;-----------------------------------------------------------------------------------------------------------------------
;  1.01.08 | 2013/04/15 | 1) Enh : Mode vérification sélectionné automatiquement à l'ouverture d'un fichier ".md5"
;          |            | 2) Enh : Bouton 'Start' possède le focus au démarrage
;          |            | 3) Enh : Horodatage dans le journal
;          |            | 4) Fix : Chemin lors de l'ouverture d'un ".md5"
;          |            | 5) Enh : Rapport final (Nb de fichiers, et éventuellement le Nb d'erreurs)
;          |            | 6) New : Vérification de la structure de la database
;          |            | 7) Enh : Intègre le fichier 'md5_x86.dll'
;          |            | 8) New : Propose d'afficher le journal
;  1.00.00 | 2013/04/14 | Version initiale
;          |            |
;-----------------------------------------------------------------------------------------------------------------------
;#######################################################################################################################
#include <CheckFiles_Global.au3>

If StringInStr(@AutoItExe,"x64") Then
	MsgBox($MB_ICONHAND,$GUI_TITLE,"Application non compatible x64 !")
	Exit
EndIf

If _SHA1ForFile(@ScriptDir & "\CheckFiles_x86.dll")<>$DLL_SHA1 Then
	MsgBox($MB_ICONEXCLAMATION,$GUI_TITLE,"Installation de la DLL...",10)
	FileInstall("CheckFiles_x86.dll",@ScriptDir & "\CheckFiles_x86.dll",1) ;1=écrase le fichier
EndIf

$hash_list[0]=0

$tray_item_hnd = TrayCreateItem    ("Abort")
TrayItemSetOnEvent($tray_item_hnd,"_CheckFiles_Event_Stop")

$dll_hnd = DllOpen($DLL_FILENAME)

;Appelé par le double-clic sur un fichier d'empreinte
If $CmdLine[0]=1 And $CmdLine[1]<>"" Then
	Local $MyDir = $CmdLine[1]
	Local $szDrive, $szDir, $szFName, $szExt

	;Vérifie que ce soit bien un dossier
	If StringInStr(FileGetAttrib($MyDir),"D")=0 Then ; <-- pas de "D" <=> ce n'est pas un dossier mais un fichier
		;Récupère le dossier
		_PathSplit($CmdLine[1], $szDrive, $szDir, $szFName, $szExt)
		$szExt = StringTrimLeft($szExt,1)

		;Supprime le dernier "\" à droite
		$MyDir = $szDrive & $szDir
		If StringRight($MyDir,1)="\" Then $MyDir = StringTrimRight($MyDir,1)
	EndIf

	;Lance l'interface graphique sur le dossier
	_CheckFiles_GUI($MyDir,$MODE_VERIFIE,$szExt)
;Appelé directement par le .EXE
Else
	_CheckFiles_GUI(RegRead($REG_PATH,"Dir"),-1,"")
EndIf
;###############################################################################################################
;###############################################################################################################
;###############################################################################################################
;###############################################################################################################
