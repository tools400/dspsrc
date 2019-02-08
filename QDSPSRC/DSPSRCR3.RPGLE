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
      *  08.02.2019  Th.Raddatz    Converted to /free.                      *
      *                                                                     *
      *=====================================================================*
      * >>PRE-COMPILER<<                                                    *
      *   >>CRTCMD<< CRTRPGMOD    MODULE(&LI/&OB) +                         *
      *                           SRCFILE(&SL/&SF) +                        *
      *                           SRCMBR(&SM);                              *
      *   >>IMPORTANT<<                                                     *
      *     >>PARM<< TRUNCNBR(*NO);                                         *
      *     >>PARM<< DBGVIEW(*LIST);                                        *
      *     >>PARM<< OPTION(*EVENTF);                                       *
      *   >>END-IMPORTANT<<                                                 *
      *   >>EXECUTE<<                                                       *
      * >>END-PRE-COMPILER<<                                                *
      *=====================================================================*
      *                                                                     *
      *  INPUT-Parameter:                                                   *
      *  ================                                                   *
      *                                                                     *
      *  i_qSrvPgm Qualifizierte Programmname                               *
      *             1 - 10:  pgm                                            *
      *            11 - 20:  library                                        *
      *                        *ALL        Alle Bibliotheken auf dem System *
      *                        *ALLUSR     Alle nicht-IBM Bibliotheken      *
      *                        *CURLIB     Aktuelle Bibliothek des Jobs     *
      *                        *LIBL       kompl. Bibliotheksliste          *
      *                        *USRLIBL    Benutzerteil der Bibl.Liste      *
      *                                                                     *
      *  i_option  Funktionscode                                            *
      *              1 - erstellen Liste                   CREATE           *
      *              5 - lesen nächsten Eintrag            READ             *
      *              4 - löschen Liste                     DELETE           *
      *                                                                     *
      *  OUTPUT-Parameter:                                                  *
      *  =================                                                  *
      *                                                                     *
      *  o_count   Anzahl noch verfügbarer Einträge                         *
      *  o_module  Eintragsdaten                                            *
      *                                                                     *
      *=====================================================================*
     H NOMAIN
      /COPY QDSPSRC,H_SPEC
      /COPY QDSPSRC,COPYRIGHT
      *
     D lstHdr          DS                  likeds(genLstHdr_t) based(pLstHdr)
     D spgl0100        DS                  likeds(SPGL0100_t) based(pSpgl0100)
     D errCode         DS                  likeds(errCode_t)
      *
      /copy qdspsrc,types_h
      /copy qdspsrc,qusrspc
      /copy qdspsrc,genlsthdr
      /copy qdspsrc,fderrcode
      /copy qdspsrc,qbnlspgm
      /copy qdspsrc,qcmdexc
      *
     D qUsrSpc         DS                  likeds(qObj_t)
     D numRecords      S             10I 0
     D clCmd           S            512A   varying
      *
     D existUserSpace...
     D                 PR              n   extproc('existUserSpace')
     D  i_qUsrSpc                          const likeds(qObj_t)
      *
      ********************************************************************
      *  Program entry point                                             *
      ********************************************************************
      *
     P DSPSRCR3...
     P                 B                   export
     D                 PI
     D  i_qSrvPgm                          const likeds(qObj_t)
     D  i_option                      1A   const
     D  o_count                      10P 0
     D  o_module                    512A
      *
      *---------------------------------------------------*
      *
     C                   EVAL      qUsrSpc.name = 'DSPSRC'
     C                   EVAL      qUsrSpc.lib = 'QTEMP'
      *
     C                   SELECT
      *  Create module list
     C     i_option      WHENEQ    '1'
     C                   EXSR      CREATE
      *  Delete list
     C     i_option      WHENEQ    '4'
     C                   EXSR      DELETE
      *  Get next entry
     C     i_option      WHENEQ    '5'
     C                   EXSR      READ
     C                   ENDSL
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
     C                   IF        (not existUserSpace(qUsrSpc))
     C                   CALLP     QUSCRTUS(
     C                                 qUsrSpc: 'TEMP': 2048: '': '*ALL': '')
     C                   ENDIF
      *
     C                   CLEAR                   errCode
     C                   EVAL      errCode.bytPrv = %size(errCode)
      *
     C                   CALLP     QBNLSPGM(
     C                                qUsrSpc: 'SPGL0100': i_qSrvPgm: errCode)
      *
     C                   IF        (errCode.bytAvl > 0)
      *  Fehler aufgetreten!
     C                   EVAL      numRecords = 0
     C                   ELSE
      *  ermitteln Offset zu den Eintragsdaten
     C                   CALLP     QUSPTRUS(qUsrSpc: pLstHdr)
      *
     C                   EVAL      numRecords = lstHdr.numE
     C                   ENDIF
      *
     C                   EVAL      o_count = numRecords
     C                   EVAL      o_module = ''
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
     C                   IF        (existUserSpace(qUsrSpc))
     C                   EVAL      clCmd = 'DLTUSRSPC +
     C                                      USRSPC(' + %trim(qUsrSpc.lib) + '/'
     C                                               + %trim(qUsrSpc.name) + ')'
     C                   CALLP(e)  QCMDEXC(clCmd: %len(clCmd))
     C                   ENDIF
      *
     C                   EVAL      o_count = 0
     C                   EVAL      o_module = ''
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
     C                   EVAL      o_count = -1
     C                   EVAL      o_module  = ''
      *
     C                   IF        (numRecords > 0)
      *
     C                   EVAL      pSpgl0100 = pLstHdr + lstHdr.ofsLstSct +
     C                                ((lstHdr.numE - numRecords) *
     C                                lstHdr.sizeE)
     C                   EVAL      numRecords = numRecords - 1
      *
     C                   EVAL      o_count = numRecords
     C                   EVAL      o_module = spgl0100
      *
     C                   ENDIF
      *
     C                   ENDSR
      *
     P                 E
      *
      *====================================================*
      *  Check user space existance                        *
      *====================================================*
     P existUserSpace...
     P                 B
     D                 PI              n
     D  i_qUsrSpc                          const likeds(qObj_t)
      /free

         clCmd = 'CHKOBJ OBJ(' + %trim(qUsrSpc.lib) + '/'
                               + %trim(qUsrSpc.name) + ') OBJTYPE(*USRSPC)';

         monitor;
            QCMDEXC(clCmd: %len(clCmd));
         on-error;
            return *off;
         endmon;

         return *on;

      /end-free
     P                 E
      *
