       //=====================================================================*
       //                                                                     *
       //  Kurzdokumentation :                                                *
       //                                                                     *
       //  Bereich . . . : DSPSRC                                             *
       //  Objekt  . . . : DSPSRCR1                                           *
       //  Beschreibung  : Tool: DSPSRC     (Display Source Code)             *
       //  Author  . . . : Thomas Raddatz   <thomas.raddatz@tools400.de>      *
       //  Datum . . . . : 25.07.2001                                         *
       //                                                                     *
       //=====================================================================*
       //                                                                     *
       //  This software is free software, you can redistribute it and/or     *
       //  modify it under the terms of the GNU General Public License (GPL)  *
       //  as published by the Free Software Foundation.                      *
       //                                                                     *
       //  See GNU General Public License for details.                        *
       //          http://www.opensource.org                                  *
       //          http://www.opensource.org/licenses/gpl-license.html        *
       //                                                                     *
       //=====================================================================*
       //  History:                                                           *
       //                                                                     *
       //  Datum       Name          Änderung                                 *
       //  ----------  ------------  ---------------------------------------  *
       //  10.01.2003  Th.Raddatz    Removed special character § from source. *
       //  08.02.2019  Th.Raddatz    Converted to /free.                      *
       //                                                                     *
       //=====================================================================*
       // >>PRE-COMPILER<<                                                    *
       //   >>CRTCMD<< CRTRPGMOD    MODULE(&LI/&OB) +                         *
       //                           SRCFILE(&SL/&SF) +                        *
       //                           SRCMBR(&SM);                              *
       //   >>IMPORTANT<<                                                     *
       //     >>PARM<< TRUNCNBR(*NO);                                         *
       //     >>PARM<< DBGVIEW(*LIST);                                        *
       //     >>PARM<< OPTION(*EVENTF);                                       *
       //   >>END-IMPORTANT<<                                                 *
       //   >>EXECUTE<<                                                       *
       // >>END-PRE-COMPILER<<                                                *
       //=====================================================================*
       //                                                                     *
       //  INPUT-Parameter:                                                   *
       //  ================                                                   *
       //                                                                     *
       //  i_qPgm    Qualifizierte Programmname                               *
       //             1 - 10:  pgm                                            *
       //            11 - 20:  library                                        *
       //                        *ALL        Alle Bibliotheken auf dem System *
       //                        *ALLUSR     Alle nicht-IBM Bibliotheken      *
       //                        *CURLIB     Aktuelle Bibliothek des Jobs     *
       //                        *LIBL       kompl. Bibliotheksliste          *
       //                        *USRLIBL    Benutzerteil der Bibl.Liste      *
       //                                                                     *
       //  i_option  Funktionscode                                            *
       //              1 - erstellen Liste                   CREATE           *
       //              5 - lesen nächsten Eintrag            READ             *
       //              4 - löschen Liste                     DELETE           *
       //                                                                     *
       //  OUTPUT-Parameter:                                                  *
       //  =================                                                  *
       //                                                                     *
       //  o_count   Anzahl noch verfügbarer Einträge                         *
       //  o_module  Eintragsdaten                                            *
       //                                                                     *
       //=====================================================================*
     H NOMAIN
      /COPY QDSPSRC,H_SPEC
      /COPY QDSPSRC,COPYRIGHT

     D lstHdr          DS                  likeds(genLstHdr_t) based(pLstHdr)
     D pgml0100        DS                  likeds(PGML0100_t) based(pPgml0100)
     D errCode         DS                  likeds(errCode_t)

      /copy qdspsrc,types_h
      /copy qdspsrc,qusrspc
      /copy qdspsrc,genlsthdr
      /copy qdspsrc,fderrcode
      /copy qdspsrc,qbnlpgmi
      /copy qdspsrc,qcmdexc

     D qUsrSpc         DS                  likeds(qObj_t)
     D numRecords      S             10I 0
     D clCmd           S            512A   varying

     D existUserSpace...
     D                 PR              n   extproc('existUserSpace')
     D  i_qUsrSpc                          const likeds(qObj_t)

       //*******************************************************************
       //  Program entry point                                             *
       //*******************************************************************
     P DSPSRCR1...
     P                 B                   export
     D                 PI
     D  i_qPgm                             const likeds(qObj_t)
     D  i_option                      1A   const
     D  o_count                      10P 0
     D  o_module                    512A
       //---------------------------------------------------*
      /free

       qUsrSpc.name = 'DSPSRC';
       qUsrSpc.lib = 'QTEMP';

       select;
          //  Create module list
       when (i_option = '1');
          exsr CREATE;
          //  Delete list
       when (i_option = '4');
          exsr DELETE;
          //  Get next entry
       when (i_option = '5');
          exsr READ;
       endsl;

       //====================================================*
       //  CREATE --  Erstellen USRSPC und Liste             *
       //----------------------------------------------------*
       //  Erforderliche Änderungen für anderes List API     *
       //    - evtl. Initialgröße des USRSPC                 *
       //    - API Aufruf für Liste                          *
       //====================================================*
       begsr CREATE;

          if (not existUserSpace(qUsrSpc));
             QUSCRTUS(
                qUsrSpc: 'TEMP': 2048: '': '*ALL': '');
          endif;

          clear errCode;
          errCode.bytPrv = %size(errCode);

          QBNLPGMI(
            qUsrSpc: 'PGML0100': i_qPgm: errCode);

          if (errCode.bytAvl > 0);
             //  Fehler aufgetreten!
             numRecords = 0;
          else;
             //  ermitteln Offset zu den Eintragsdaten
             QUSPTRUS(qUsrSpc: pLstHdr);

             numRecords = lstHdr.numE;
          endif;

          o_count = numRecords;
          o_module = '';

       endsr;

       //====================================================*
       //  DELETE --  Löschen USRSPC                         *
       //----------------------------------------------------*
       //  Erforderliche Änderungen für anderes List API     *
       //    - *NONE                                         *
       //====================================================*
       begsr DELETE;

          if (existUserSpace(qUsrSpc));
             clCmd = 'DLTUSRSPC +
                     USRSPC(' + %trim(qUsrSpc.lib) + '/'
                              + %trim(qUsrSpc.name) + ')';
             callp(e) QCMDEXC(clCmd: %len(clCmd));
          endif;

          o_count = 0;
          o_module = '';

       endsr;

       //====================================================*
       //  READ   --  Lesen nächsten Eintrag                 *
       //----------------------------------------------------*
       //  Erforderliche Änderungen für anderes List API     *
       //    - *NONE                                         *
       //====================================================*
       begsr READ;

          o_count = -1;
          o_module  = '';

          if (numRecords > 0);

             pPgml0100 = pLstHdr + lstHdr.ofsLstSct +
               ((lstHdr.numE - numRecords) *
               lstHdr.sizeE);
             numRecords = numRecords - 1;

             o_count = numRecords;
             o_module = pgml0100;

          endif;

       endsr;

      /end-free
     P                 E

       //====================================================*
       //  Check user space existance                        *
       //====================================================*
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

