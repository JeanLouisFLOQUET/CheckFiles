#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Version=beta
#AutoIt3Wrapper_UseX64=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include-once
#include <Array.au3>
#include <ButtonConstants.au3>
#include <Constants.au3>
#include <File.au3>
#include <GUIConstantsEx.au3>
#include <GuiEdit.au3>
#include <Math.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <_FileListToArrayEx.au3>

Opt("MustDeclareVars",1)
Opt("TrayMenuMode"   ,1)
Opt("TrayOnEventMode",1)

Global Const $REG_PATH              = "HKEY_CURRENT_USER\Software\JLF\CheckFiles"            ;Endroit de sauvegarde des param�tres
Global Const $DLL_SHA1              = "3286DB14ACF66D53355B48F574905C3DD9F8D209"             ;Code SHA1 de la DLL (calcul� par les API de Windows, moins fiable que PolarSSL)
;============================================================================================;
;Fen�tre principale                                                                          ;
;============================================================================================;
Global Const $GUI_TITLE             = "JLF CheckFiles"                                       ;Titre de l'application
Global       $hnd_gui_main                                                                   ;Handle sur la fen�tre
Global       $hnd_path_txt                                                                   ;Handle sur le chemin (texte)
Global       $hnd_path_btn                                                                   ;Handle sur le bouton 'chemin'
Global       $hnd_fp                                                                         ;Handle sur le bouton 'empreinte'
Global       $hnd_recursif                                                                   ;Handle sur le bouton 'r�cursif'
Global       $hnd_mode                                                                       ;Hnadle sur la liste d�roulante contenant le mode de fonctionnement
Global       $hnd_start                                                                      ;Handle sur le bouton 'start'
                                                                                             ;
Global Const $MODE_SW_0             = "0=suppression du logiciel"                            ;
Global Const $MODE_SW_1             = "1=installation du logiciel"                           ;
Global Const $MODE_LISTE            = "2=liste les fichiers introuvables"                    ;
Global Const $MODE_SUPPR            = "3=supprime les entr�es dont le fichier n'existe plus" ;
Global Const $MODE_AJOUT            = "4=ajoute l'empreinte des nouveaux fichiers"           ;
Global Const $MODE_VERIFIE          = "5=v�rifie l'empreinte des fichiers r�f�renc�s"        ;
Global Const $MODE_CLEAR            = "6=supprime les fichiers d'empreinte"                  ;
Global Const $MODE_CHECK_DB         = "7=v�rifie la structure des fichiers d'empreinte"      ;
Global Const $TITLE                 = "JLF CheckFiles"                                       ;
;============================================================================================;
;Fen�tre de progression                                                                      ;
;============================================================================================;
Global Const $TIP_FONT_SIZE         = 7                                                      ;Taille de la police de caract�res
Global       $tip_gui_height        = 15                                                     ;Hauteur de la fen�tre
Global       $tip_gui_width         = 65                                                     ;Largeur de la fen�tre
Global       $tip_gui_hnd                                                                    ;Handle sur la fen�tre
Global       $tip_lbl_hnd                                                                    ;Handle sur l'�tiquette contenue dans cette fen�tre
;============================================================================================;
;V�rification de la structure de la database                                                 ;
;============================================================================================;
Global       $CheckDB_RemoveAllWrong                                                         ;
;============================================================================================;
;Empreinte                                                                                   ;
;============================================================================================;
Global       $DB_LOCAL_NAME                                                                  ;Nom du fichier de la database pour les empreintes
Global Const $DB_LOCAL_NAME_MD2     = ".md2"                                                 ;Nom du fichier de la database pour les empreintes MD2
Global Const $DB_LOCAL_NAME_MD4     = ".md4"                                                 ;Nom du fichier de la database pour les empreintes MD4
Global Const $DB_LOCAL_NAME_MD5     = ".md5"                                                 ;Nom du fichier de la database pour les empreintes MD5
Global Const $DB_LOCAL_NAME_SHA1    = ".sha1"                                                ;Nom du fichier de la database pour les empreintes SHA-1
Global Const $DB_LOCAL_NAME_SHA224  = ".sha224"                                              ;Nom du fichier de la database pour les empreintes SHA-224
Global Const $DB_LOCAL_NAME_SHA256  = ".sha256"                                              ;Nom du fichier de la database pour les empreintes SHA-256
Global Const $DB_LOCAL_NAME_SHA384  = ".sha384"                                              ;Nom du fichier de la database pour les empreintes SHA-384
Global Const $DB_LOCAL_NAME_SHA512  = ".sha512"                                              ;Nom du fichier de la database pour les empreintes SHA-512

Global       $Empreinte                                                                      ;Nom de l'empreinte choisie
Global Const $FP_MD2                = "MD2"                                                  ;
Global Const $FP_MD4                = "MD4"                                                  ;
Global Const $FP_MD5                = "MD5"                                                  ;
Global Const $FP_SHA1               = "SHA-1"                                                ;
Global Const $FP_SHA224             = "SHA-224"                                              ;
Global Const $FP_SHA256             = "SHA-256"                                              ;
Global Const $FP_SHA384             = "SHA-384"                                              ;
Global Const $FP_SHA512             = "SHA-512"                                              ;
                                                                                             ;
Global Const $FP_LENGTH_MD2         =  32                                                    ;
Global Const $FP_LENGTH_MD4         =  32                                                    ;
Global Const $FP_LENGTH_MD5         =  32                                                    ;
Global Const $FP_LENGTH_SHA1        =  40                                                    ;
Global Const $FP_LENGTH_SHA224      =  56                                                    ;
Global Const $FP_LENGTH_SHA256      =  64                                                    ;
Global Const $FP_LENGTH_SHA384      =  96                                                    ;
Global Const $FP_LENGTH_SHA512      = 128                                                    ;
Global       $FP_LENGTH                                                                      ;Longueur de l'empreinte
Global       $FP_LENGTH_P3                                                                   ;Longueur de l'empreinte + 3
                                                                                             ;
Global       $dll_function                                                                   ;Nom de la fonction � appeler dans la DLL
;============================================================================================;
;Exclusions                                                                                  ;
;============================================================================================;
Global       $hnd_exc_btn                                                                    ;Handle pour les exclusions / boutons
Global       $hnd_exc_gui                                                                    ;Handle pour les exclusions / GUI
Global       $hnd_exc_lst                                                                    ;Handle pour les exclusions / Liste
Global       $hnd_exc_lbl                                                                    ;Handle pour les exclusions / Etiquette
Global       $exc_arr[1]                                                                     ;Tableau 1D contenant la liste des exclusions
;============================================================================================;
;Divers                                                                                      ;
;============================================================================================;
Global Const $INI_FILE              = @ScriptDir & "\CheckFiles.ini"                         ;Fichier de param�tres
Global       $DisplayReport                                                                  ;Affiche le rapport final
Global       $NbFilesKO                                                                      ;Nombre total de fichiers en erreur
Global       $tray_item_hnd                                                                  ;
Global       $TotDir                = 0                                                      ;Liste des dossiers � analyser
Global       $NbTotFiles            = 0                                                      ;Nombre total de fichiers analys�s
Global       $DirIndex                                                                       ;Num�ro du dossier en cours d'analyse
Global Const $DLL_FILENAME          = @ScriptDir & "\CheckFiles_x86.dll"                     ;Nom de la DLL
Global       $dll_hnd                                                                        ;Handle sur la DLL de calcul du code MD5
Global       $log                                                                            ;Journal de sortie
Global       $req_stop              = 0                                                      ;Requ�te d'arr�t par l'interface graphique
Global       $hash_list[1]                                                                   ;
Global       $timer

#include <checksums.au3>
#include <CheckFiles_AnalyseFiles.au3>
#include <CheckFiles_AnalyseFiles_Mode_2_Liste.au3>
#include <CheckFiles_AnalyseFiles_Mode_3_Suppr.au3>
#include <CheckFiles_AnalyseFiles_Mode_4_Ajout.au3>
#include <CheckFiles_AnalyseFiles_Mode_5_Verifie.au3>
#include <CheckFiles_AnalyseFiles_Mode_6_Clear.au3>
#include <CheckFiles_AnalyseFiles_Mode_7_Check_DB.au3>
#include <CheckFiles_BrowseDir.au3>
#include <CheckFiles_Event_Empreinte.au3>
#include <CheckFiles_Event_Install.au3>
#include <CheckFiles_Event_Mode.au3>
#include <CheckFiles_Event_Recursif.au3>
#include <CheckFiles_Event_Start.au3>
#include <CheckFiles_Event_Stop.au3>
#include <CheckFiles_Event_Uninstall.au3>
#include <CheckFiles_Exclusions_Event.au3>
#include <CheckFiles_Exclusions_Fix.au3>
#include <CheckFiles_Exclusions_Load.au3>
#include <CheckFiles_Exclusions_Save.au3>
#include <CheckFiles_Global.au3>
#include <CheckFiles_GUI.au3>
#include <CheckFiles_Hash.au3>
#include <CheckFiles_Heure.au3>
#include <CheckFiles_SetEmpreinte.au3>
#include <CheckFiles_SetParameters.au3>
#include <CheckFiles_Start.au3>
#include <CheckFiles_TimeFormat.au3>
#include <CheckFiles_Tip_Create.au3>
#include <CheckFiles_Tip_Update.au3>
#include <CheckFiles_LogWrite.au3>
