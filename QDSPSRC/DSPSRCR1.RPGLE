**free
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
ctl-opt nomain;
/copy QDSPSRC,H_SPEC
/copy QDSPSRC,COPYRIGHT

dcl-ds lstHdr likeds(genLstHdr_t) based(pLstHdr);
dcl-ds pgml0100 likeds(PGML0100_t) based(pPgml0100);
dcl-ds errCode likeds(errCode_t);

/copy qdspsrc,types_h
/copy qdspsrc,qusrspc
/copy qdspsrc,genlsthdr
/copy qdspsrc,fderrcode
/copy qdspsrc,qbnlpgmi
/copy qdspsrc,qcmdexc

dcl-ds qUsrSpc likeds(qObj_t);
dcl-s numRecords int(10);
dcl-s clCmd varchar(512);

dcl-pr existUserSpace ind extproc('existUserSpace');
  i_qUsrSpc likeds(qObj_t) const;
end-pr;

//*******************************************************************
//  Program entry point                                             *
//*******************************************************************
dcl-proc DSPSRCR1 export;
  dcl-pi *n;
    i_qPgm   likeds(qObj_t) const;
    i_option char(1) const;
    o_count  packed(10);
    o_module char(512);
  end-pi;
  //---------------------------------------------------*

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

end-proc;

//====================================================*
//  Check user space existance                        *
//====================================================*
dcl-proc existUserSpace;
  dcl-pi *n ind;
    i_qUsrSpc likeds(qObj_t) const;
  end-pi;

  clCmd = 'CHKOBJ OBJ(' + %trim(qUsrSpc.lib) + '/'
                        + %trim(qUsrSpc.name) + ') OBJTYPE(*USRSPC)';

  monitor;
    QCMDEXC(clCmd: %len(clCmd));
  on-error;
    return *off;
  endmon;

  return *on;

end-proc;

