      *=====================================================================*
      *                                                                     *
      *  Kurzdokumentation :                                                *
      *                                                                     *
      *  Bereich . . . : DSPSRC                                             *
      *  Objekt  . . . : DSPSRCR1                                           *
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
      *  10.01.2003  Th.Raddatz    Removed special character § from source. *
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
      *  Datenstruktur  PGML0100:                                           *
      *                                                                     *
      *   P1PGM  - Program name used                                        *
      *   P1LIB  - Program library name used                                *
      *            *ALL, *ALLUSR, *CURLIB, *LIBL, *USRLIBL                  *
      *   P1MDNM - Bound module name                                        *
      *   P1MDLB - Bound module library name                                *
      *   P1SRCF - Source file name                                         *
      *   P1SRCL - Source library name                                      *
      *   P1SRCM - Source member name                                       *
      *   P1MATR - Module attribute                                         *
      *   P1MCDT - Module creation date and time                            *
      *   P1SUDT - Source updated date and time                             *
      *   P1STNM - Sort sequence table name                                 *
      *   P1STLB - Sort sequence table library name                         *
      *   P1LANG - Language identifier                                      *
      *   P1OPT  - Optimization level                                       *
      *   P1MOPT - Maximum opimization level                                *
      *   P1DBG  - Debug data                                               *
      *   P1CRLS - Release module created on                                *
      *   P1FRLS - Release module created for                               *
      *   P1RES1 - Reserved 1                                               *
      *   P1USRM - User modified                                            *
      *   P1LICP - Licensed program                                         *
      *   P1PTF  - PTF number                                               *
      *   P1APAR - APAR ID                                                  *
      *   P1CDTA - Creation data                                            *
      *   P1CCSI - CCSID                                                    *
      *   P1OCLV - Objekt control level                                     *
      *   P1PFRC - Enable performance collection                            *
      *   P1PDTA - Profiling data                                           *
      *   P1RES2 - Reserved 2                                               *
      *   S1NPRC - Number of Procedures                                     *
      *   S1NPBR - Number of procedures block reordered                     *
      *   S1NPBM - Number of procedures block-order measured                *
      *   P1RES3 - Reserved 3                                               *
      *   P1NSQL - Number of SQL statements                                 *
      *   P1RDB  - Relational database                                      *
      *   P1CMT  - Commitment control                                       *
      *   P1ALWD - Allow copy of date                                       *
      *   P1CLSC - Close SQL cursor                                         *
      *   P1NMCV - Naming convention                                        *
      *   P1DTFM - Date format                                              *
      *   P1DTSP - Date seperator                                           *
      *   P1TMFM - Time format                                              *
      *   P1TMSP - Time seperator                                           *
      *   P1DLYP - Delay PREPARE                                            *
      *   P1ALWB - Allow blocking                                           *
      *   P1DCNM - Default collection name                                  *
      *   P1SPNM - SQL package name                                         *
      *   P1SPLB - SQL package library name                                 *
      *   P1DUSR - Dynamic user profile                                     *
      *   P1SSNM - SQL sort sequence table name                             *
      *   P1SSLB - SQL sort sequence table library name                     *
      *   P1SLID - SQL language identifier                                  *
      *   P1CNMT - Connection method                                        *
      *                                                                     *
      *=====================================================================*
      /COPY QDSPSRC,H_SPEC
      /COPY QDSPSRC,COPYRIGHT
      *===============================================================
      *
      *  Eintragsdaten der *ENTRY-Liste
     D XDATA           DS           512
      *
      *  Felder für List API
     D                 DS
     D  PLQPGM                 1     20
     D  PLPGM                  1     10
     D  PLLIB                 11     20
     D  PLFMT                 21     28
      *
      *  Datenstruktur für der Rückgabewert des List API.
      *  PGML0100 - ILE program module (*MODULE) information.
     D PL0100          DS
     D  P1PGME                 1     10
     D  P1LIB                 11     20
     D  P1MDNM                21     30
     D  P1MDLB                31     40
     D  P1SRCF                41     50
     D  P1SRCL                51     60
     D  P1SRCM                61     70
     D  P1MATR                71     80
     D  P1MCDT                81     93
     D  P1SUDT                94    106
     D  P1STNM               107    116
     D  P1STLB               117    126
     D  P1LANG               127    136
     D  P1OPT                137    140B 0
     D  P1MOPT               141    144B 0
     D  P1DBG                145    154
     D  P1CRLS               155    160
     D  P1FRLS               161    166
     D  P1RES1               167    186
     D  P1USRM               187    187
     D  P1LICP               188    200
     D  P1PTF                201    205
     D  P1APAR               206    211
     D  P1CDTA               212    212
     D  P1CCSI               213    216
     D  P1OCLV               217    224
     D  P1PFRC               225    225
     D  S1PDTA               226    235
     D  P1RES2               236    236
     D  S1NPRC               237    240B 0
     D  S1NPBR               241    244B 0
     D  S1NPBM               245    248B 0
     D  S1RES3               249    324
     D  P1NSQL               325    328
     D  P1RDB                329    346
     D  P1CMT                347    356
     D  P1ALWD               357    366
     D  P1CLSC               367    376
     D  P1NMCV               377    386
     D  P1DTFM               387    396
     D  P1DTSP               397    397
     D  P1TMFM               398    407
     D  P1TMSP               408    408
     D  P1DLYP               409    418
     D  P1ALWB               419    428
     D  P1DCNM               429    438
     D  P1SPNM               439    448
     D  P1SPLB               449    458
     D  P1DUSR               459    468
     D  P1SSNM               469    478
     D  P1SSLB               479    488
     D  P1SLID               489    498
     D  P1CNMT               499    508
      *
      *  Länge der Datenstruktur
     D cDTLN           C                   CONST(%SIZE(PL0100))
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
     C                   CLEAR                   PL0100
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
     C                   MOVEL     'PGML0100'    PLFMT                          format
     C                   MOVEL     XQPGM         PLQPGM                         qualf.pgm name
     C                   Z-ADD     32            ERRPRV                         len provided
      *
     C                   CALL      'QBNLPGMI'
     C                   PARM                    USFNME
     C                   PARM                    PLFMT
     C                   PARM                    PLQPGM
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
     C                   MOVEL(P)  PL0100        XDATA
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
     C                   CLEAR                   PL0100
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
     C                   MOVEL(P)  PL0100        XDATA
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
     C                   CLEAR                   PL0100
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
     C                   PARM                    PL0100
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
     C                   MOVEL(P)  PL0100        XDATA
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
