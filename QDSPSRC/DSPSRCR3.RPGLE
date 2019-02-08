      *=====================================================================*
      *                                                                     *
      *  Kurzdokumentation :                                                *
      *                                                                     *
      *  Bereich . . . : DSPSRC                                             *
      *  Objekt  . . . : DSPSRCR3                                           *
      *  Beschreibung  : Tool: DSPSRC     (Display Source Code)             *
      *  Author  . . . : Thomas Raddatz   <thomas.raddatz@tools400.de>      *
      *  Datum . . . . : 25.07.2001                                         *
      *                                                                     *
      *=====================================================================*
      *                                                                     *
      *  This software is free software, you can redistribute it and/or     *
      *  modify it under the terms of the GNU General Public License (GPL)  *
      *  as published by the Free Software Foundation.                      *
      *                                                                     *
      *  See GNU General Public License for details.                        *
      *          http://www.opensource.org                                  *
      *          http://www.opensource.org/licenses/gpl-license.html        *
      *                                                                     *
      *=====================================================================*
      *  History:                                                           *
      *                                                                     *
      *  Datum       Name          Änderung                                 *
      *  ----------  ------------  ---------------------------------------  *
      *                                                                     *
      *=====================================================================*
      * >>PRE-COMPILER<<                                                    *
      *   >>CRTCMD<< CRTRPGMOD    MODULE(&LI/&OB) +                         *
      *                           SRCFILE(&SL/&SF) +                        *
      *                           SRCMBR(&SM);                              *
      *   >>COMPILE<<                                                       *
      *     >>PARM<< TRUNCNBR(*NO);                                         *
      *     >>PARM<< DBGVIEW(*LIST);                                        *
      *   >>END-COMPILE<<                                                   *
      *   >>EXECUTE<<                                                       *
      * >>END-PRE-COMPILER<<                                                *
      *=====================================================================*
      *                                                                     *
      *  INPUT-Parameter:                                                   *
      *  ================                                                   *
      *                                                                     *
      *  XQPGM   - Qualifizierte Programmname                               *
      *             1 - 10:  pgm                                            *
      *            11 - 20:  library                                        *
      *                        *ALL        Alle Bibliotheken auf dem System *
      *                        *ALLUSR     Alle nicht-IBM Bibliotheken      *
      *                        *CURLIB     Aktuelle Bibliothek des Jobs     *
      *                        *LIBL       kompl. Bibliotheksliste          *
      *                        *USRLIBL    Benutzerteil der Bibl.Liste      *
      *                                                                     *
      *  XCTRL   - Funktionscode                                            *
      *              1 - erstellen Liste                   CREATE           *
      *              5 - lesen nächsten Eintrag            READ             *
      *              4 - löschen Liste                     DELETE           *
      *                                                                     *
      *  OUTPUT-Parameter:                                                  *
      *  =================                                                  *
      *                                                                     *
      *  XCNT    - Anzahl noch verfügbarer Einträge                         *
      *  XDATA   - Eintragsdaten                                            *
      *                                                                     *
      *=====================================================================*
      *                                                                     *
      *  Typische Aufrufreihenfolge                                         *
      *                                                                     *
      *        A_PGM   - Funktion (1)    erstellen Liste                    *
      *                                                                     *
      *  XCNT  DOWGT *ZEROS                                                 *
      *        A_PGM   - Funktion (5)    lesen nächsten Eintrag             *
      *        ENDDO                                                        *
      *                                                                     *
      *        A_PGM   - Funktion (4)    löschen Liste                      *
      *                                                                     *
      *=====================================================================*
      *                                                                     *
      *  Datenstruktur  SPGL0100:                                           *
      *                                                                     *
      *   S1PGM  - Service program name                                     *
      *   S1LIB  - Service program library name                             *
      *            *ALL, *ALLUSR, *CURLIB, *LIBL, *USRLIBL                  *
      *   S1MDNM - Bound module name                                        *
      *   S1MDLB - Bound module library name                                *
      *   S1SRCF - Source file name                                         *
      *   S1SRCL - Source library name                                      *
      *   S1SRCM - Source member name                                       *
      *   S1MATR - Module attribute                                         *
      *   S1MCDT - Module creation date and time                            *
      *   S1SUDT - Source updated date and time                             *
      *   S1STNM - Sort sequence table name                                 *
      *   S1STLB - Sort sequence table library name                         *
      *   S1LANG - Language identifier                                      *
      *   S1OPT  - Optimization level                                       *
      *   S1MOPT - Maximum opimization level                                *
      *   S1DBG  - Debug data                                               *
      *   S1CRLS - Release module created on                                *
      *   S1FRLS - Release module created for                               *
      *   S1RES1 - Reserved 1                                               *
      *   S1USRM - User modified                                            *
      *   S1LICP - Licensed program                                         *
      *   S1PTF  - PTF number                                               *
      *   S1APAR - APAR ID                                                  *
      *   S1CDTA - Creation data                                            *
      *   S1CCSI - Module CCSID                                             *
      *   S1OCLV - Objekt control level                                     *
      *   S1PFRC - Enable performance collection                            *
      *   S1PDTA - Profiling data                                           *
      *   S1RES2 - Reserved 2                                               *
      *   S1NPRC - Number of Procedures                                     *
      *   S1NPBR - Number of procedures block reordered                     *
      *   S1NPBM - Number of procedures block-order measured                *
      *   S1RES3 - Reserved 3                                               *
      *   S1NSQL - Number of SQL statements                                 *
      *   S1RDB  - Relational database                                      *
      *   S1CMT  - Commitment control                                       *
      *   S1ALWD - Allow copy of date                                       *
      *   S1CLSC - Close SQL cursor                                         *
      *   S1NMCV - Naming convention                                        *
      *   S1DTFM - Date format                                              *
      *   S1DTSP - Date separator                                           *
      *   S1TMFM - Time format                                              *
      *   S1TMSP - Time separator                                           *
      *   S1DLYP - Delay PREPARE                                            *
      *   S1ALWB - Allow blocking                                           *
      *   S1DCNM - Default collection name                                  *
      *   S1SPNM - SQL package name                                         *
      *   S1SPLB - SQL package library name                                 *
      *   S1DUSR - Dynamic user profile                                     *
      *   S1SSNM - SQL sort sequence table name                             *
      *   S1SSLB - SQL sort sequence table library name                     *
      *   S1SLID - SQL language identifier                                  *
      *   S1CNMT - Connection method                                        *
      *                                                                     *
      *=====================================================================*
      /COPY QDSPSRC,H_SPEC
      /COPY QDSPSRC,COPYRIGHT
      *=====================================================================*
      *
      *  Eintragsdaten der *ENTRY-Liste
     D XDATA           DS           512
      *
      *  Felder für List API
     D                 DS
     D  SLQPGM                 1     20
     D  SLPGM                  1     10
     D  SLLIB                 11     20
     D  SLFMT                 21     28
      *
      *  Datenstruktur für der Rückgabewert des List API.
      *  SPGL0100 - Service program module (*MODULE) information.
     D SL0100          DS
     D  S1PGME                 1     10
     D  S1LIB                 11     20
     D  S1MDNM                21     30
     D  S1MDLB                31     40
     D  S1SRCF                41     50
     D  S1SRCL                51     60
     D  S1SRCM                61     70
     D  S1MATR                71     80
     D  S1MCDT                81     93
     D  S1SUDT                94    106
     D  S1STNM               107    116
     D  S1STLB               117    126
     D  S1LANG               127    136
     D  S1OPT                137    140B 0
     D  S1MOPT               141    144B 0
     D  S1DBG                145    154
     D  S1CRLS               155    160
     D  S1FRLS               161    166
     D  S1RES1               167    186
     D  S1USRM               187    187
     D  S1LICP               188    200
     D  S1PTF                201    205
     D  S1APAR               206    211
     D  S1CDTA               212    212
     D  S1CCSI               213    216
     D  S1OCLV               217    224
     D  S1PFRC               225    225
     D  S1PDTA               226    235
     D  S1RES2               236    236
     D  S1NPRC               237    240B 0
     D  S1NPBR               241    244B 0
     D  S1NPBM               245    248B 0
     D  S1RES3               249    324
     D  S1NSQL               325    328
     D  S1RDB                329    346
     D  S1CMT                347    356
     D  S1ALWD               357    366
     D  S1CLSC               367    376
     D  S1NMCV               377    386
     D  S1DTFM               387    396
     D  S1DTSP               397    397
     D  S1TMFM               398    407
     D  S1TMSP               408    408
     D  S1DLYP               409    418
     D  S1ALWB               419    428
     D  S1DCNM               429    438
     D  S1SPNM               439    448
     D  S1SPLB               449    458
     D  S1DUSR               459    468
     D  S1SSNM               469    478
     D  S1SSLB               479    488
     D  S1SLID               489    498
     D  S1CNMT               499    508
      *  Länge der Datenstruktur
     D cDTLN           C                   CONST(%SIZE(SL0100))
      *
      *===============================================================*
      *  Erforderliche Änderungen für anderes List API                *
      *    - *NONE                                                    *
      *===============================================================*
      *
      *  API Fehlerdatenstruktur
     D ERRCOD          DS
     D  ERRPRV                 1      4B 0 INZ
     D  ERRAVL                 5      8B 0 INZ
     D  ERRID                  9     15    INZ
     D  ERRRSV                16     16    INZ
     D  ERRDTA                17     32    INZ
      *
      *  Felder für QUSRTVUS
     D                 DS
     D  USDTLN                 1      4B 0 INZ
     D  USSPOS                 5      8B 0 INZ
      *
      *  Felder für QUSCRTUS
     D                 DS
     D  USFNME                 1     20
     D  USNAME                 1     10    INZ
     D  USLIB                 11     20    INZ
     D  USATTR                21     30    INZ
     D  USSIZE                31     34B 0 INZ
     D  USINIT                35     35    INZ
     D  USAUTH                36     45    INZ
     D  USDESC                46     95    INZ
      *
      *  Felder für Generic List Header
     D US#OFS          DS
     D  OFFSET                 1      4B 0 INZ
     D  RECRDS                 9     12B 0 INZ
     D  RSIZE                 13     16B 0 INZ
      *
      ********************************************************************
      *           Hauptsteuerung                                         *
      *------------------------------------------------------------------*
      *  Erforderliche Änderungen für anderes List API                   *
      *    - *ENTRY liste: Länge XDATA                                   *
      ********************************************************************
      *
     C     *ENTRY        PLIST
     C                   PARM                    XQPGM            20
     C                   PARM                    XCTRL             1
      *
     C                   PARM                    XCNT             10 0
     C                   PARM                    XDATA                          Length 512
      *
      *---------------------------------------------------*
      *
     C                   SELECT
      *  erstellen Liste
     C     XCTRL         WHENEQ    '1'
     C                   EXSR      CREATE
      *  löschen Liste
     C     XCTRL         WHENEQ    '4'
     C                   EXSR      DELETE
      *  lesen nächsten Eintrag
     C     XCTRL         WHENEQ    '5'
     C                   EXSR      READ
     C                   ENDSL
      *
      *---------------------------------------------------*
      *  Programmende
      *
     C     ENDE          TAG
      *
     C                   RETURN
      *
      *====================================================*
      *  CREATE --  Erstellen USRSPC und Liste             *
      *----------------------------------------------------*
      *  Erforderliche Änderungen für anderes List API     *
      *    - evtl. Initialgröße des USRSPC                 *
      *    - API Aufruf für Liste                          *
      *====================================================*
      *
     C     CREATE        BEGSR
      *
     C                   Z-ADD     *ZEROS        RECRDS
     C                   CLEAR                   SL0100
      *
     C                   EXSR      CHKOBJ
      *
      *  erstellen USRSPC
     C     *IN99         IFEQ      '1'
     C                   CALL      'QUSCRTUS'
     C                   PARM                    USFNME
     C                   PARM      'TEMP'        USATTR
     C                   PARM      2048          USSIZE
     C                   PARM      ' '           USINIT
     C                   PARM      '*ALL'        USAUTH
     C                   PARM      ' '           USDESC
     C                   ENDIF
      *
      *  erstellen Liste
     C                   MOVEL     'SPGL0100'    SLFMT                          format
     C                   MOVEL     XQPGM         SLQPGM                         qualf.pgm name
     C                   Z-ADD     32            ERRPRV                         len provided
      *
     C                   CALL      'QBNLSPGM'
     C                   PARM                    USFNME
     C                   PARM                    SLFMT
     C                   PARM                    SLQPGM
     C                   PARM                    ERRCOD
      *
     C     ERRAVL        IFNE      *ZEROS
      *  Fehler aufgetreten!
     C                   Z-ADD     *ZEROS        RECRDS
     C                   ELSE
      *  ermitteln Offset zu den Eintragsdaten
     C                   Z-ADD     125           USDTLN
     C                   Z-ADD     16            USSPOS
      *
     C                   CALL      'QUSRTVUS'
     C                   PARM                    USFNME
     C                   PARM                    USDTLN
     C                   PARM                    USSPOS
     C                   PARM                    US#OFS
      *
     C                   ADD       1             OFFSET
     C                   ENDIF
      *
     C                   Z-ADD     RECRDS        XCNT
     C                   MOVEL(P)  SL0100        XDATA
      *
     C                   ENDSR
      *
      *====================================================*
      *  DELETE --  Löschen USRSPC                         *
      *----------------------------------------------------*
      *  Erforderliche Änderungen für anderes List API     *
      *    - *NONE                                         *
      *====================================================*
      *
     C     DELETE        BEGSR
      *
     C                   Z-ADD     *ZEROS        RECRDS
     C                   CLEAR                   SL0100
      *
     C                   EXSR      CHKOBJ
      *
     C     *IN99         IFEQ      '0'
      *
     C                   MOVEL(P)  'DLTUSR'      YCMD
     C                   CAT       'SPC':0       YCMD
     C                   CAT       'USR':1       YCMD
     C                   CAT       'SPC(':0      YCMD
     C                   CAT       USLIB:0       YCMD
     C                   CAT       '/':0         YCMD
     C                   CAT       USNAME:0      YCMD
     C                   CAT       ')':0         YCMD
      *
     C                   CALL      'QCMDEXC'                            99
     C                   PARM                    YCMD
     C                   PARM      256           YCMDL
      *
     C                   ENDIF
      *
     C                   Z-ADD     RECRDS        XCNT
     C                   MOVEL(P)  SL0100        XDATA
      *
     C                   ENDSR
      *
      *====================================================*
      *  READ   --  Lesen nächsten Eintrag                 *
      *----------------------------------------------------*
      *  Erforderliche Änderungen für anderes List API     *
      *    - *NONE                                         *
      *====================================================*
      *
     C     READ          BEGSR
      *
     C                   CLEAR                   SL0100
      *
     C     RECRDS        IFLE      *ZEROS
     C                   Z-ADD     *ZEROS        RECRDS
     C                   ELSE
      *
     C                   Z-ADD     cDTLN         USDTLN
     C                   Z-ADD     OFFSET        USSPOS
      *
     C                   CALL      'QUSRTVUS'                           99
     C                   PARM                    USFNME
     C                   PARM                    USSPOS
     C                   PARM                    USDTLN
     C                   PARM                    SL0100
      *
     C     *IN99         IFEQ      '0'
     C                   SUB       1             RECRDS
     C                   ADD       RSIZE         OFFSET
     C                   ELSE
     C                   Z-ADD     *ZEROS        RECRDS
     C                   ENDIF
      *
     C                   ENDIF
      *
     C                   Z-ADD     RECRDS        XCNT
     C                   MOVEL(P)  SL0100        XDATA
      *
     C                   ENDSR
      *
      *====================================================*
      *  CHKOBJ --  Prüfen USRSPC                          *
      *----------------------------------------------------*
      *  Erforderliche Änderungen für anderes List API     *
      *    - *NONE                                         *
      *====================================================*
      *
     C     CHKOBJ        BEGSR
      *
     C                   MOVEL(P)  'CHKOBJ'      YCMD
     C                   CAT       'OBJ(':1      YCMD
     C                   CAT       USLIB:0       YCMD
     C                   CAT       '/':0         YCMD
     C                   CAT       USNAME:0      YCMD
     C                   CAT       ')':0         YCMD
     C                   CAT       'OBJ':1       YCMD
     C                   CAT       'TYPE(':0     YCMD
     C                   CAT       '*USR':0      YCMD
     C                   CAT       'SPC':0       YCMD
     C                   CAT       ')':0         YCMD
      *
     C                   CALL      'QCMDEXC'                            99
     C                   PARM                    YCMD            256
     C                   PARM      256           YCMDL            15 5
      *
     C                   ENDSR
      *
      *====================================================*
      *  *INZSR --  Initialize program                     *
      *----------------------------------------------------*
      *  Erforderliche Änderungen für anderes List API     *
      *    - Name des USRSPC                               *
      *====================================================*
      *
     C     *INZSR        BEGSR
      *
     C                   MOVEL(P)  'QTEMP'       USLIB
     C                   MOVEL(P)  'BNLPGMI'     USNAME
      *
     C                   Z-ADD     *ZEROS        RECRDS
      *
     C                   ENDSR
      *
