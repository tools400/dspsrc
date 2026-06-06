**free
//=====================================================================*
//                                                                     *
//  Kurzdokumentation :                                                *
//                                                                     *
//  Bereich . . . : DSPSRC                                             *
//  Objekt  . . . : DSPSRCR2                                           *
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
//  01.03.2007  Th.Raddatz    Wrong option in module selection subfile *
//                            was not correctly processed. Added       *
//                            'DSPATR(PC)' to SFPAU.                   *
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
ctl-opt nomain;
/copy QDSPSRC,H_SPEC
/copy QDSPSRC,COPYRIGHT

dcl-f DSPSRCD workstn(*ext) usage(*input: *output) usropn infds(workstn) sfile(PBSFL: recno)
  indds(wrkstn_flags);

/copy qdspsrc,types_h
/copy qdspsrc,workstn
/copy qdspsrc,qbnlspgm
/copy qdspsrc,qbnlpgmi

dcl-ds wrkstn_flags qualified;
  sflDsp    ind pos(80);
  sflEnd    ind;
  sflDspCtl ind;
  sflNxtChg ind;
  sfpau_pc  ind;
end-ds;


dcl-s RECNO int(10);

dcl-ds WORKSTN likeds(workstn_infds_t);

dcl-ds spgl0100 likeds(spgl0100_t);
dcl-ds pgml0100 likeds(pgml0100_t);

dcl-ds module qualified;
  pgm     char(10);
  pgmLib  char(10);
  mod     char(10);
  modLib  char(10);
  srcFile char(10);
  srcLib  char(10);
  srcMbr  char(10);
end-ds;

dcl-s isFound ind;

dcl-c cTRUE '1';
dcl-c cFALSE '0';

dcl-s yCount packed(10);
dcl-ds yModule len(512);
end-ds;

//*******************************************************************
//  Program entry point                                             *
//*******************************************************************
dcl-proc DSPSRCR2 export;
  dcl-pi *n;
    i_qObj       char(20) const;
    i_objType    char(10) const;
    i_autoSelect ind const;
    o_qSrcFile   likeds(qObj_t);
    o_srcMbr     char(10);
    o_rc         char(10);
  end-pi;
//---------------------------------------------------*

//  Subfile record number
RECNO = 0;

//  "Not found"  flag
isFound = cFALSE;

o_rc = '';
o_qSrcFile = '';
o_srcMbr = '';

exsr CRTLST;

select;
   //  No more entries available
when (yCount <= 0);
   return;

   //  Only one module found, select it automatically
when (yCount = 1 AND i_autoSelect);
   exsr REDLST;
   exsr FILLSF;
   exsr FILLEL;
   return;

   //  More than one module available, let the user select
other;
   OPEN DSPSRCD;
   exsr VREFR;
endsl;

dow '1';

   write PBBOT;

   //  If there are no module ...
   if (not wrkstn_flags.sflDsp);
      //  ... display 'not found' message
      write PBLEER;
   endif;

   EXFMT PBCTL;

   select;
   when (workstn.aid = cKeyF3);
      o_rc = '*CANCEL';
      LEAVE;
   when (workstn.aid = cKeyF5);
      exsr VREFR;
      iter;
   when (workstn.aid = cKeyF12);
      o_rc = '*CANCEL';
      LEAVE;
   when (workstn.aid = cKeyEnter);
      exsr VSFL;
      if (isFound = cTRUE);
         LEAVE;
      else;
         iter;
      endif;
   other;
      iter;
   endsl;

enddo;

//---------------------------------------------------*
//  Close program
close DSPSRCD;

exsr DELLST;

return;

//====================================================*
//  Refresh screen                                    *
//====================================================*

begsr VREFR;

   exsr CRTLST;

   exsr PBCLR;
   exsr PBFL;

endsr;

//====================================================*
//  Read changed subfile records                      *
//====================================================*

begsr VSFL;

   //  "Not found"
   isFound = cFALSE;

   if (not wrkstn_flags.sflDsp);
      //  Keine Einträge vorhanden ...
   else;

      dou %eof(DSPSRCD);
         READC PBSFL;
         //  "Is found"
         if (not %eof(DSPSRCD));
            select;
            when (SFPAU = '');
               wrkstn_flags.sflNxtChg = *off;
               wrkstn_flags.sfpau_pc = *off;
               UPDATE PBSFL;
            when (SFPAU = '1');
               SFPAU = '';
               wrkstn_flags.sflNxtChg = *off;
               wrkstn_flags.sfpau_pc = *off;
               UPDATE PBSFL;
               exsr FILLEL;
               isFound = cTRUE;
            other;
               wrkstn_flags.sflNxtChg = *on;
               wrkstn_flags.sfpau_pc = *on;
               UPDATE PBSFL;
               LEAVE;
            endsl;
         endif;

      enddo;

   endif;

endsr;

//====================================================*
//  Set return values from selected module            *
//====================================================*

begsr FILLEL;

   o_qSrcFile = $$SRCF + $$SRCL;
   o_srcMbr = $$SRCM;

endsr;

//====================================================*
//  Create module list                                *
//====================================================*

begsr CRTLST;

   yModule = '';

   if (i_objType = '*PGM');
      DSPSRCR1(i_qObj: '1': yCount: yModule);
   else;
      DSPSRCR3(i_qObj: '1': yCount: yModule);
   endif;

endsr;

//====================================================*
//  Delete module list                                *
//====================================================*

begsr DELLST;

   if (i_objType = '*PGM');
      DSPSRCR1(i_qObj: '4': yCount: yModule);
   else;
      DSPSRCR3(i_qObj: '4': yCount: yModule);
   endif;

endsr;

//====================================================*
//  Read next module entry from list                  *
//====================================================*

begsr REDLST;

   if (i_objType = '*PGM');
      DSPSRCR1(i_qObj: '5': yCount: yModule);
      pgml0100 = yModule;
      module.pgm = pgml0100.pgm;
      module.pgmLib = pgml0100.pgmLib;
      module.mod = pgml0100.mod;
      module.modLib = pgml0100.modLib;
      module.srcFile = pgml0100.srcFile;
      module.srcLib = pgml0100.srcLib;
      module.srcMbr = pgml0100.srcMbr;
   else;
      DSPSRCR3(i_qObj: '5': yCount: yModule);
      spgl0100 = yModule;
      module.pgm = spgl0100.srvPgm;
      module.pgmLib = spgl0100.srvPgmLib;
      module.mod = spgl0100.mod;
      module.modLib = spgl0100.modLib;
      module.srcFile = spgl0100.srcFile;
      module.srcLib = spgl0100.srcLib;
      module.srcMbr = spgl0100.srcMbr;
   endif;

endsr;

//====================================================*
//  Clear subfile                                     *
//====================================================*

begsr PBCLR;

   wrkstn_flags.sflDsp = *off;
   wrkstn_flags.sflDspCtl = *off;
   WRITE PBCTL;
   wrkstn_flags.sflDspCtl = *on;

   wrkstn_flags.sflEnd = *on;

   RECNO = 0;
   SFSANR = 1;

endsr;

//====================================================*
//  Fill subfile ith module list                      *
//====================================================*

begsr PBFL;

   dow (yCount > 0);

      RECNO = RECNO + 1;
      exsr REDLST;
      exsr FILLSF;

      //  If there is only one module in the list, ...
      if (yCount = 1 and RECNO = 1);
         //  ... then select it automatically
         wrkstn_flags.sflNxtChg = *on;
         SFPAU = '1';
      else;
         //  ... else let the user select the module
         wrkstn_flags.sflNxtChg = *off;
         SFPAU = '';
      endif;

      wrkstn_flags.sfpau_pc = *off;

      WRITE PBSFL;
      wrkstn_flags.sflDsp = *on;
   enddo;

endsr;

//====================================================*
//  Populate subfile fields                           *
//====================================================*

begsr FILLSF;

   SFPAU = '';
   $$MDNM = module.mod;
   $$MDLB = module.modLib;
   $$SRCF = module.srcFile;
   $$SRCL = module.srcLib;
   $$SRCM = module.srcMbr;

endsr;

end-proc;

