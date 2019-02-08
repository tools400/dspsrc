      *=====================================================================*
      *                                                                     *
      *  Kurzdokumentation :                                                *
      *                                                                     *
      *  Bereich . . . : DSPSRC                                             *
      *  Objekt  . . . : DSPSRCR2                                           *
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
      *  01.03.2007  Th.Raddatz    Wrong option in module selection subfile *
      *                            was not correctly processed. Added       *
      *                            'DSPATR(PC)' to SFPAU.                   *
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
      /COPY QDSPSRC,H_SPEC
      /COPY QDSPSRC,COPYRIGHT
      *===============================================================*
     FDSPSRCD   CF   E             WORKSTN USROPN
     F                                     INFDS(WORKST)
     F                                     SFILE(PBSFL:RECNO)
     F                                     INFSR(*PSSR)
      *
     D WORKST          DS
     D  WORKST_KEY           369    369
      *
     D  cENTER         C                   const(X'F1')
     D  cHELP          C                   const(X'F3')
     D  cPGD           C                   const(X'F4')
     D  cPGU           C                   const(X'F5')
     D  cPRNT          C                   const(X'F6')
     D  cF1            C                   const(X'31')
     D  cF2            C                   const(X'32')
     D  cF3            C                   const(X'33')
     D  cF4            C                   const(X'34')
     D  cF5            C                   const(X'35')
     D  cF6            C                   const(X'36')
     D  cF7            C                   const(X'37')
     D  cF8            C                   const(X'38')
     D  cF9            C                   const(X'39')
     D  cF10           C                   const(X'3A')
     D  cF11           C                   const(X'3B')
     D  cF12           C                   const(X'3C')
     D  cF13           C                   const(X'B1')
     D  cF14           C                   const(X'B2')
     D  cF15           C                   const(X'B3')
     D  cF16           C                   const(X'B4')
     D  cF17           C                   const(X'B5')
     D  cF18           C                   const(X'B6')
     D  cF19           C                   const(X'B7')
     D  cF20           C                   const(X'B8')
     D  cF21           C                   const(X'B9')
     D  cF22           C                   const(X'BA')
     D  cF23           C                   const(X'BB')
     D  cF24           C                   const(X'BC')
     D  cCLEAR         C                   const(X'BD')
      *
      *  Datenstruktur für List API
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
     D  P1RES2               226    324
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
     D cTRUE           C                   CONST('1')
     D cFALSE          C                   CONST('0')
      *
      *  Parameter für DSPSRCR1 und DSPSRCR2
     D YDATA           DS           512
      *
      ********************************************************************
      *           H A U P T S T E U E R L E I S T E                      *
      ********************************************************************
      *
     C     *ENTRY        PLIST
     C                   PARM                    XQPGM            20
     C                   PARM                    XOBJTP           10
     C                   PARM                    XDSPM             1
     C                   PARM                    XQSRC            20
     C                   PARM                    XSRCM            10
     C                   PARM                    XRCD             10
      *
     C     P#MDL         PLIST
     C                   PARM                    YQPGM            20
     C                   PARM                    YCTRL             1
     C                   PARM                    YCNT             10 0
     C                   PARM                    YDATA
      *
      *---------------------------------------------------*
      *
     C                   EXSR      FIRST
      *
     C                   DO        *HIVAL
      *
     C                   WRITE     PBBOT
      *
      *  Wenn keine Einträge vorhanden sind,
     C     *IN80         IFEQ      '0'
      *  ... dann Leermeldung ausgeben
     C                   WRITE     PBLEER
     C                   ENDIF
      *
     C                   EXFMT     PBCTL
      *
     C                   SELECT
     C     WORKST_KEY    WHENEQ    cF3
     C                   MOVEL(P)  '*CANCEL'     XRCD
     C                   LEAVE
     C     WORKST_KEY    WHENEQ    cF5
     C                   EXSR      VREFR
     C                   ITER
     C     WORKST_KEY    WHENEQ    cF12
     C                   MOVEL(P)  '*CANCEL'     XRCD
     C                   LEAVE
     C     WORKST_KEY    WHENEQ    cENTER
     C                   EXSR      VSFL
     C     ISFND         IFEQ      cTRUE
     C                   LEAVE
     C                   ELSE
     C                   ITER
     C                   ENDIF
     C                   OTHER
     C                   ITER
     C                   ENDSL
      *
     C                   ENDDO
      *
      *---------------------------------------------------*
      *  Programmende
     C                   CLOSE     DSPSRCD
      *
     C     ENDE          TAG
      *
     C                   EXSR      DELLST
      *
     C                   RETURN
      *
      *====================================================*
      *  VREFR  --  Aktualisieren Bildschirm               *
      *====================================================*
      *
     C     VREFR         BEGSR
      *
     C                   EXSR      CRTLST
      *
     C                   EXSR      PBCLR
     C                   EXSR      PBFL
      *
     C                   ENDSR
      *
      *====================================================*
      *  VSFL   --  Lesen der Subfileeingaben              *
      *====================================================*
      *
     C     VSFL          BEGSR
      *
      *  "Not found"
     C                   MOVEL     cFALSE        ISFND
      *
     C     *IN80         IFEQ      '0'
      *  Keine Einträge vorhanden ...
     C                   ELSE
      *
     C     *IN11         DOUEQ     '1'
     C                   READC     PBSFL                                  11
      *  "Is found"
     C     *IN11         IFEQ      '0'
     C                   SELECT
     C     SFPAU         WHENEQ    ''
     C                   MOVEL(P)  '0'           *IN83                          SFLNXTCHG
     C                   MOVEL(P)  '0'           *IN84                          DSPATR(PC)
     C                   UPDATE    PBSFL
     C     SFPAU         WHENEQ    '1'
     C                   MOVEL(P)  *BLANKS       SFPAU
     C                   MOVEL(P)  '0'           *IN83                          SFLNXTCHG
     C                   MOVEL(P)  '0'           *IN84                          DSPATR(PC)
     C                   UPDATE    PBSFL
     C                   EXSR      FILLEL
     C                   MOVEL     cTRUE         ISFND
     C                   OTHER
     C                   MOVEL(P)  '1'           *IN83                          SFLNXTCHG
     C                   MOVEL(P)  '1'           *IN84                          DSPATR(PC)
     C                   UPDATE    PBSFL
     C                   LEAVE
     C                   ENDSL
     C                   ENDIF
      *
     C                   ENDDO
      *
     C                   ENDIF
      *
     C                   ENDSR
      *
      *====================================================*
      *  FILLEL --  Füllen der Rückgabefelder der *ENTRY   *
      *             Liste                                  *
      *====================================================*
      *
     C     FILLEL        BEGSR
      *
     C     $$SRCF        CAT(P)    $$SRCL        XQSRC
     C                   MOVEL(P)  $$SRCM        XSRCM
      *
     C                   ENDSR
      *
      *====================================================*
      *  CRTLST --  erstellen Liste                        *
      *====================================================*
      *
     C     CRTLST        BEGSR
      *
     C                   MOVEL(P)  XQPGM         YQPGM
     C                   MOVEL(P)  '1'           YCTRL
     C                   Z-ADD     *ZEROS        YCNT
     C                   MOVEL(P)  *BLANKS       YDATA
      *
     C     XOBJTP        IFEQ      '*PGM'
     C                   CALLB     'DSPSRCR1'    P#MDL
     C                   ELSE
     C                   CALLB     'DSPSRCR3'    P#MDL
     C                   ENDIF
      *
     C                   ENDSR
      *
      *====================================================*
      *  DELLST --  Löschen Liste                          *
      *====================================================*
      *
     C     DELLST        BEGSR
      *
     C                   MOVEL(P)  '4'           YCTRL
      *
     C     XOBJTP        IFEQ      '*PGM'
     C                   CALLB     'DSPSRCR1'    P#MDL
     C                   ELSE
     C                   CALLB     'DSPSRCR3'    P#MDL
     C                   ENDIF
      *
     C                   ENDSR
      *
      *====================================================*
      *  REDLST --  Lesen nächsten Eintrag                 *
      *====================================================*
      *
     C     REDLST        BEGSR
      *
     C                   MOVEL(P)  '5'           YCTRL
      *
     C     XOBJTP        IFEQ      '*PGM'
     C                   CALLB     'DSPSRCR1'    P#MDL
     C                   ELSE
     C                   CALLB     'DSPSRCR3'    P#MDL
     C                   ENDIF
      *
     C                   MOVEL(P)  YDATA         PL0100
      *
     C                   ENDSR
      *
      *====================================================*
      *  PBCLR  --  Löschen der Subfile                    *
      *====================================================*
      *
     C     PBCLR         BEGSR
      *
     C                   MOVEL(P)  '0'           *IN80                          SFLDSP/SFLCLR
     C                   MOVEL(P)  '0'           *IN82                          SFLDSPCTL
     C                   WRITE     PBCTL
     C                   MOVEL(P)  '1'           *IN82                          SFLDSPCTL
      *
     C                   MOVEL(P)  '1'           *IN81                          SFLEND
      *
      *  Satzzähler
     C                   Z-ADD     *ZEROS        RECNO
      *  Position der Subfile in der Anzeige
     C                   Z-ADD     1             SFSANR
      *
     C                   ENDSR
      *
      *====================================================*
      *  PBFL   --  Lesen der Einträge und füllen der      *
      *             Subfile                                *
      *====================================================*
      *
     C     PBFL          BEGSR
      *
     C     YCNT          DOWGT     *ZEROS
      *
     C                   ADD       1             RECNO
     C                   EXSR      REDLST
     C                   EXSR      FILLSF
      *
      *  Wenn nur ein Eintrag in der Liste ist,
     C     YCNT          IFEQ      1
     C     RECNO         ANDEQ     1
      *  ... dann diesen Eintrag autom. mit
      *      Datenfreigabe auswählen
     C                   MOVEL(P)  '1'           *IN83                          SFLNXTCHG
     C                   MOVEL(P)  '1'           SFPAU
     C                   ELSE
      *  ... alle anderen Einträge müssen
      *      gezielt ausgewählt werden
     C                   MOVEL(P)  '0'           *IN83                          SFLNXTCHG
     C                   MOVEL(P)  *BLANKS       SFPAU
     C                   ENDIF
      *
     C                   MOVEL(P)  '0'           *IN84                          DSPATR(PC)
      *
     C                   WRITE     PBSFL
     C                   MOVEL(P)  '1'           *IN80                          SFLDSP/SFLCLR
     C                   ENDDO
      *
     C                   ENDSR
      *
      *====================================================*
      *  FILLSF --  Füllen der Subfilefelder               *
      *====================================================*
      *
     C     FILLSF        BEGSR
      *
     C                   MOVEL(P)  *BLANKS       SFPAU
     C                   MOVEL(P)  P1MDNM        $$MDNM
     C                   MOVEL(P)  P1MDLB        $$MDLB
     C                   MOVEL(P)  P1SRCF        $$SRCF
     C                   MOVEL(P)  P1SRCL        $$SRCL
     C                   MOVEL(P)  P1SRCM        $$SRCM
      *
     C                   ENDSR
      *
      *====================================================*
      *  FIRST  --  Initialisierung bei jedem Aufruf       *
      *====================================================*
      *
     C     FIRST         BEGSR
      *
      *  Satzzähler
     C                   Z-ADD     *ZEROS        RECNO             5 0
      *  Satzzähler
     C                   Z-ADD     *ZEROS        RECNO             5 0
      *  "Not found"
     C                   MOVEL(P)  cFALSE        ISFND             1
      *
     C                   MOVEL(P)  *BLANKS       XRCD
     C                   MOVEL(P)  *BLANKS       XQSRC
     C                   MOVEL(P)  *BLANKS       XSRCM
      *
     C                   EXSR      CRTLST
      *
     C                   SELECT
      *  Keine Einträge vorhanden ...
     C     YCNT          WHENLE    *ZEROS
     C                   GOTO      ENDE
      *  Nur ein Eintrag vorhanden ...
     C     YCNT          WHENEQ    1
     C     XDSPM         ANDEQ     cFALSE
     C                   EXSR      REDLST
     C                   EXSR      FILLSF
     C                   EXSR      FILLEL
     C                   GOTO      ENDE
     C                   OTHER
      *  Mehr als 1 Eintrag vorhanden ...
      *  Auswahl auf Bildschirm bringen,
      *  hierzu Bildschirmdatei öffnen
     C                   OPEN      DSPSRCD
     C                   EXSR      VREFR
     C                   ENDSL
      *
     C                   ENDSR
      *
      *====================================================*
      *  *INZSR --  Einamlige Initialisierung              *
      *====================================================*
      *
     C     *INZSR        BEGSR
      *
      *
     C                   ENDSR
      *
      *====================================================*
      *  *PSSR  --  Fehlerbehandlung                       *
      *====================================================*
      *
     C     *PSSR         BEGSR
      *
      *
     C                   ENDSR     '*CANCL'
      *
