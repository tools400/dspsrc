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
      *     >>PARM<< OPTION(*EVENTF);                                       *
      *   >>END-COMPILE<<                                                   *
      *   >>EXECUTE<<                                                       *
      * >>END-PRE-COMPILER<<                                                *
      *=====================================================================*
     H NOMAIN
      /COPY QDSPSRC,H_SPEC
      /COPY QDSPSRC,COPYRIGHT
      *
     FDSPSRCD   CF   E             WORKSTN USROPN
     F                                     INFDS(WORKSTN)
     F                                     SFILE(PBSFL:RECNO)
     F                                     indds(wrkstn_flags)
      *
      /copy qdspsrc,types_h
      /copy qdspsrc,workstn
      /copy qdspsrc,qbnlspgm
      /copy qdspsrc,qbnlpgmi
      *
     D wrkstn_flags    DS                  qualified
     D  sflDsp                80     80n
     D  sflEnd                81     81n
     D  sflDspCtl             82     82n
     D  sflNxtChg             83     83n
     D  sfpau_pc              84     84n

      *
     D RECNO           S             10I 0
      *
     D WORKSTN         DS                  likeds(workstn_infds_t)
      *
     D spgl0100        DS                  likeds(spgl0100_t)
     D pgml0100        DS                  likeds(pgml0100_t)
      *
     D module          DS                  qualified
     D  pgm                    1     10
     D  pgmLib                11     20
     D  mod                   21     30
     D  modLib                31     40
     D  srcFile               41     50
     D  srcLib                51     60
     D  srcMbr                61     70
      *
     D isFound         S               n
      *
     D cTRUE           C                   CONST('1')
     D cFALSE          C                   CONST('0')
      *
     D yCount          S             10p 0
     D yModule         DS           512
      *
      ********************************************************************
      *  Program entry point                                             *
      ********************************************************************
      *
     P DSPSRCR2...
     P                 B                   export
     D                 PI
     D  i_qObj                       20A   const
     D  i_objType                    10A   const
     D  i_autoSelect                   N   const
     D  o_qSrcFile                               likeds(qObj_t)
     D  o_srcMbr                     10A
     D  o_rc                         10A
      *
      *---------------------------------------------------*
      *
     C                   EXSR      FIRST
      *
     C                   DO        *HIVAL
      *
     C                   WRITE     PBBOT
      *
      *  If there are no module ...
     C                   IF        (not wrkstn_flags.sflDsp)
      *  ... display 'not found' message
     C                   WRITE     PBLEER
     C                   ENDIF
      *
     C                   EXFMT     PBCTL
      *
     C                   SELECT
     C                   WHEN      (workstn.aid = cKeyF3)
     C                   EVAL      o_rc = '*CANCEL'
     C                   LEAVE
     C                   WHEN      (workstn.aid = cKeyF5)
     C                   EXSR      VREFR
     C                   ITER
     C                   WHEN      (workstn.aid = cKeyF12)
     C                   EVAL      o_rc = '*CANCEL'
     C                   LEAVE
     C                   WHEN      (workstn.aid = cKeyEnter)
     C                   EXSR      VSFL
     C                   IF        (isFound = cTRUE)
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
      *  Close program
     C                   CLOSE     DSPSRCD
      *
     C     ENDE          TAG
      *
     C                   EXSR      DELLST
      *
     C                   RETURN
      *
      *====================================================*
      *  Refresh screen                                    *
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
      *  Read changed subfile records                      *
      *====================================================*
      *
     C     VSFL          BEGSR
      *
      *  "Not found"
     C                   EVAL      isFound = cFALSE
      *
     C                   IF        (not wrkstn_flags.sflDsp)
      *  Keine Einträge vorhanden ...
     C                   ELSE
      *
     C                   DOU       %eof(DSPSRCD)
     C                   READC     PBSFL
      *  "Is found"
     C                   IF        (not %eof(DSPSRCD))
     C                   SELECT
     C                   WHEN      (SFPAU = '')
     C                   EVAL      wrkstn_flags.sflNxtChg = *off
     C                   EVAL      wrkstn_flags.sfpau_pc = *off
     C                   UPDATE    PBSFL
     C                   WHEN      (SFPAU = '1')
     C                   EVAL      SFPAU = ''
     C                   EVAL      wrkstn_flags.sflNxtChg = *off
     C                   EVAL      wrkstn_flags.sfpau_pc = *off
     C                   UPDATE    PBSFL
     C                   EXSR      FILLEL
     C                   EVAL      isFound = cTRUE
     C                   OTHER
     C                   EVAL      wrkstn_flags.sflNxtChg = *on
     C                   EVAL      wrkstn_flags.sfpau_pc = *on
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
      *  Set return values from selected module            *
      *====================================================*
      *
     C     FILLEL        BEGSR
      *
     C     $$SRCF        CAT(P)    $$SRCL        o_qSrcFile
     C                   EVAL      o_srcMbr = $$SRCM
      *
     C                   ENDSR
      *
      *====================================================*
      *  Create module list                                *
      *====================================================*
      *
     C     CRTLST        BEGSR
      *
     C                   MOVEL(P)  *BLANKS       yModule
      *
     C                   IF        (i_objType = '*PGM')
     C                   CALLP     DSPSRCR1(i_qObj: '1': yCount: yModule)
     C                   ELSE
     C                   CALLP     DSPSRCR3(i_qObj: '1': yCount: yModule)
     C                   ENDIF
      *
     C                   ENDSR
      *
      *====================================================*
      *  Delete module list                                *
      *====================================================*
      *
     C     DELLST        BEGSR
      *
     C                   IF        (i_objType = '*PGM')
     C                   CALLP     DSPSRCR1(i_qObj: '4': yCount: yModule)
     C                   ELSE
     C                   CALLP     DSPSRCR3(i_qObj: '4': yCount: yModule)
     C                   ENDIF
      *
     C                   ENDSR
      *
      *====================================================*
      *  Read next module entry from list                  *
      *====================================================*
      *
     C     REDLST        BEGSR
      *
     C                   IF        (i_objType = '*PGM')
     C                   CALLP     DSPSRCR1(i_qObj: '5': yCount: yModule)
     C                   Eval      pgml0100 = yModule
     C                   Eval      module.pgm = pgml0100.pgm
     C                   Eval      module.pgmLib = pgml0100.pgmLib
     C                   Eval      module.mod = pgml0100.mod
     C                   Eval      module.modLib = pgml0100.modLib
     C                   Eval      module.srcFile = pgml0100.srcFile
     C                   Eval      module.srcLib = pgml0100.srcLib
     C                   Eval      module.srcMbr = pgml0100.srcMbr
     C                   ELSE
     C                   CALLP     DSPSRCR3(i_qObj: '5': yCount: yModule)
     C                   Eval      spgl0100 = yModule
     C                   Eval      module.pgm = spgl0100.srvPgm
     C                   Eval      module.pgmLib = spgl0100.srvPgmLib
     C                   Eval      module.mod = spgl0100.mod
     C                   Eval      module.modLib = spgl0100.modLib
     C                   Eval      module.srcFile = spgl0100.srcFile
     C                   Eval      module.srcLib = spgl0100.srcLib
     C                   Eval      module.srcMbr = spgl0100.srcMbr
     C                   ENDIF
      *
     C                   ENDSR
      *
      *====================================================*
      *  Clear subfile                                     *
      *====================================================*
      *
     C     PBCLR         BEGSR
      *
     C                   EVAL      wrkstn_flags.sflDsp = *off
     C                   EVAL      wrkstn_flags.sflDspCtl = *off
     C                   WRITE     PBCTL
     C                   EVAL      wrkstn_flags.sflDspCtl = *on
      *
     C                   EVAL      wrkstn_flags.sflEnd = *on
      *
      *
     C                   EVAL      RECNO = 0
      *
     C                   EVAL      SFSANR = 1
      *
     C                   ENDSR
      *
      *====================================================*
      *  Fill subfile ith module list                      *
      *====================================================*
      *
     C     PBFL          BEGSR
      *
     C                   DOW       (yCount > 0)
      *
     C                   EVAL      RECNO = RECNO + 1
     C                   EXSR      REDLST
     C                   EXSR      FILLSF
      *
      *  If there is only one module in the list, ...
     C                   IF        (yCount = 1 and RECNO = 1)
      *  ... then select it automatically
     C                   EVAL      wrkstn_flags.sflNxtChg = *on
     C                   EVAL      SFPAU = '1'
     C                   ELSE
      *  ... else let the user select the module
     C                   EVAL      wrkstn_flags.sflNxtChg = *off
     C                   EVAL      SFPAU = ''
     C                   ENDIF
      *
     C                   EVAL      wrkstn_flags.sfpau_pc = *off
      *
     C                   WRITE     PBSFL
     C                   EVAL      wrkstn_flags.sflDsp = *on
     C                   ENDDO
      *
     C                   ENDSR
      *
      *====================================================*
      *  Populate subfile fields                           *
      *====================================================*
      *
     C     FILLSF        BEGSR
      *
     C                   EVAL      SFPAU = ''
     C                   EVAL      $$MDNM = module.mod
     C                   EVAL      $$MDLB = module.modLib
     C                   EVAL      $$SRCF = module.srcFile
     C                   EVAL      $$SRCL = module.srcLib
     C                   EVAL      $$SRCM = module.srcMbr
      *
     C                   ENDSR
      *
      *====================================================*
      *  Initialize the program                            *
      *====================================================*
      *
     C     FIRST         BEGSR
      *
      *  Subfile record number
     C                   EVAL      RECNO = 0
      *  "Not found"  flag
     C                   EVAL      isFound = cFALSE
      *
     C                   EVAL      o_rc = ''
     C                   EVAL      o_qSrcFile = ''
     C                   EVAL      o_srcMbr = ''
      *
     C                   EXSR      CRTLST
      *
     C                   SELECT
      *  No more entries available
     C                   WHEN      (yCount <= 0)
     C                   GOTO      ENDE
      *  Only one module found, select it automatically
     C                   WHEN      (yCount = 1 AND i_autoSelect)
     C                   EXSR      REDLST
     C                   EXSR      FILLSF
     C                   EXSR      FILLEL
     C                   GOTO      ENDE
     C                   OTHER
      *  More than one module available, let the user select
     C                   OPEN      DSPSRCD
     C                   EXSR      VREFR
     C                   ENDSL
      *
     C                   ENDSR
      *
     P                 E
      *
