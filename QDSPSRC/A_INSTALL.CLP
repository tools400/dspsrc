     /* =================================================================== */
     /*                                                                     */
     /*  Documentation:                                                     */
     /*                                                                     */
     /*  Utility . . . : DSPSRC                                             */
     /*  Object  . . . : A_INSTALL  (PGM)                                   */
     /*  Source member : A_INSTALL                                          */
     /*  Source type . : CLLE                                               */
     /*  Description   : DSPSRC - Installer                                 */
     /*  Author  . . . : Thomas Raddatz   <thomas.raddatz@tools400.de>      */
     /*                                                                     */
     /* =================================================================== */
     /*                                                                     */
     /*  This software is free software, you can redistribute it and/or     */
     /*  modify it under the terms of the GNU General Public License (GPL)  */
     /*  as published by the Free Software Foundation.                      */
     /*                                                                     */
     /*  See GNU General Public License for details.                        */
     /*          http://www.opensource.org                                  */
     /*          http://www.opensource.org/licenses/gpl-license.html        */
     /*                                                                     */
     /* =================================================================== */
     /*  History:                                                           */
     /*                                                                     */
     /*  Datum       Name          Änderung                                 */
     /*  ----------  ------------  ---------------------------------------  */
     /*                                                                     */
     /* =================================================================== */
     /*   >>PRE-COMPILER<<                                                  */
     /*     >>CRTCMD<<    CRTBNDCL  PGM(QTEMP/&OB) +                        */
     /*                             SRCFILE(&SL/&SF) SRCMBR(&SM);           */
     /*     >>IMPORTANT<<                                                   */
     /*       >>PARM<<    OPTION(*EVENTF);                                  */
     /*     >>END-IMPORTANT<<                                               */
     /*     >>EXECUTE<<                                                     */
     /*     >>CMD<<       CALL   PGM(QTEMP/A_INSTALL) +                     */
     /*                          PARM('*CURRENT' '&SF' '&LI' 'GER');        */
     /*     >>CMD<<       DLTPGM PGM(QTEMP/A_INSTALL);                      */
     /*   >>END-PRE-COMPILER<<                                              */
     /* =================================================================== */
             PGM        PARM(&TGTRLS &SRCFILE &TOLIB &LNG)

             DCL        VAR(&TGTRLS   ) TYPE(*CHAR) LEN(10)
             DCL        VAR(&SRCFILE  ) TYPE(*CHAR) LEN(10)
             DCL        VAR(&TOLIB    ) TYPE(*CHAR) LEN(10)
             DCL        VAR(&LNG      ) TYPE(*CHAR) LEN( 3)

             DCL        VAR(&SRCLIB   ) TYPE(*CHAR) LEN(10)

             DCL        VAR(&PNLGRP   ) TYPE(*CHAR) LEN(10)
             DCL        VAR(&DSPF     ) TYPE(*CHAR) LEN(10)
             DCL        VAR(&CMD      ) TYPE(*CHAR) LEN(10)

             CHGVAR     VAR(&SRCLIB) VALUE(&TOLIB   )

             IF         COND(&LNG *EQ 'ENG') THEN(DO)
                CHGVAR     VAR(&PNLGRP ) VALUE('DSPSRCPE')
                CHGVAR     VAR(&DSPF   ) VALUE('DSPSRCDE')
                CHGVAR     VAR(&CMD    ) VALUE('DSPSRCE')
             ENDDO
             ELSE       CMD(DO)
                CHGVAR     VAR(&PNLGRP ) VALUE('DSPSRCPG')
                CHGVAR     VAR(&DSPF   ) VALUE('DSPSRCDG')
                CHGVAR     VAR(&CMD    ) VALUE('DSPSRCG')
             ENDDO

     /* ---------------------------------- */
     /*  Delete old objects                */
     /* ---------------------------------- */
             DLTCMD     CMD(&TOLIB/DSPSRC)
             MONMSG     MSGID(CPF2105)

             DLTPNLGRP  PNLGRP(&TOLIB/DSPSRCP)
             MONMSG     MSGID(CPF2105)

             DLTMOD     MODULE(&TOLIB/DSPSRCC)
             MONMSG     MSGID(CPF2105)

             DLTMOD     MODULE(&TOLIB/DSPSRCR1)
             MONMSG     MSGID(CPF2105)

             DLTMOD     MODULE(&TOLIB/DSPSRCR2)
             MONMSG     MSGID(CPF2105)

             DLTMOD     MODULE(&TOLIB/DSPSRCR3)
             MONMSG     MSGID(CPF2105)

             DLTF       FILE(&TOLIB/DSPSRCD)
             MONMSG     MSGID(CPF2105)

             DLTPGM     PGM(&TOLIB/DSPSRCC)
             MONMSG     MSGID(CPF2105)

         /* --------------------------------- */
         /*  DSPSRC v1.2 and before           */
         /* --------------------------------- */
             DLTPGM     PGM(&TOLIB/DSPSRCR1)
             MONMSG     MSGID(CPF2105)

             DLTPGM     PGM(&TOLIB/DSPSRCR2)
             MONMSG     MSGID(CPF2105)

             DLTPGM     PGM(&TOLIB/DSPSRCR3)
             MONMSG     MSGID(CPF2105)

     /* -------------------------------- */
     /*  Create display file             */
     /* -------------------------------- */
             CRTDSPF    FILE(&TOLIB/DSPSRCD) +
                          SRCFILE(&SRCLIB/&SRCFILE) +
                          SRCMBR(&DSPF)
             DLTSPLF    FILE(DSPSRCD  ) JOB(*) SPLNBR(*LAST)
             MONMSG     MSGID(CPF0000)

     /* -------------------------------- */
     /*  Create modules                  */
     /* -------------------------------- */
             CRTCLMOD   MODULE(&TOLIB/DSPSRCC ) +
                          SRCFILE(&SRCLIB/&SRCFILE) +
                          SRCMBR(*MODULE) +
                          DBGVIEW(*LIST) +
                          TGTRLS(&TGTRLS)
             DLTSPLF    FILE(DSPSRCC  ) JOB(*) SPLNBR(*LAST)
             MONMSG     MSGID(CPF0000)

             CRTRPGMOD  MODULE(&TOLIB/DSPSRCR1) +
                          SRCFILE(&SRCLIB/&SRCFILE) +
                          SRCMBR(*MODULE) +
                          DBGVIEW(*LIST) TRUNCNBR(*NO) +
                          TGTRLS(&TGTRLS)
             DLTSPLF    FILE(DSPSRCR1 ) JOB(*) SPLNBR(*LAST)
             MONMSG     MSGID(CPF0000)

             CRTRPGMOD  MODULE(&TOLIB/DSPSRCR2) +
                          SRCFILE(&SRCLIB/&SRCFILE) +
                          SRCMBR(*MODULE) +
                          DBGVIEW(*LIST) TRUNCNBR(*NO) +
                          TGTRLS(&TGTRLS)
             DLTSPLF    FILE(DSPSRCR2 ) JOB(*) SPLNBR(*LAST)
             MONMSG     MSGID(CPF0000)

             CRTRPGMOD  MODULE(&TOLIB/DSPSRCR3) +
                          SRCFILE(&SRCLIB/&SRCFILE) +
                          SRCMBR(*MODULE) +
                          DBGVIEW(*LIST) TRUNCNBR(*NO) +
                          TGTRLS(&TGTRLS)
             DLTSPLF    FILE(DSPSRCR3 ) JOB(*) SPLNBR(*LAST)
             MONMSG     MSGID(CPF0000)

     /* -------------------------------- */
     /*  Create programs                 */
     /* -------------------------------- */
             CRTPGM     PGM(&TOLIB/DSPSRCC) +
                        MODULE(&TOLIB/DSPSRCC   +
                               &TOLIB/DSPSRCR1  +
                               &TOLIB/DSPSRCR2  +
                               &TOLIB/DSPSRCR3) +
                          ACTGRP(*NEW) +
                          DETAIL(*BASIC) +
                          TGTRLS(&TGTRLS)
             DLTSPLF    FILE(DSPSRCC) JOB(*) SPLNBR(*LAST)
             MONMSG     MSGID(CPF0000)

     /* -------------------------------- */
     /*  Create panel groups             */
     /* -------------------------------- */
             CRTPNLGRP  PNLGRP(&TOLIB/DSPSRCP) +
                          SRCFILE(&SRCLIB/&SRCFILE) +
                          SRCMBR(&PNLGRP)
             DLTSPLF    FILE(DSPSRCP  ) JOB(*) SPLNBR(*LAST)
             MONMSG     MSGID(CPF0000)

     /* -------------------------------- */
     /*  Create commands                 */
     /* -------------------------------- */
             CRTCMD     CMD(&TOLIB/DSPSRC) PGM(&TOLIB/DSPSRCC) +
                          SRCFILE(&SRCLIB/&SRCFILE) +
                          SRCMBR(&CMD) +
                          HLPPNLGRP(&TOLIB/DSPSRCP) HLPID(DSPSRC)
             DLTSPLF    FILE(&CMD     ) JOB(*) SPLNBR(*LAST)
             MONMSG     MSGID(CPF0000)

     /* -------------------------------- */
     /*  Delete obsolete objects         */
     /* -------------------------------- */
             DLTMOD     MODULE(&TOLIB/DSPSRCC)
             DLTMOD     MODULE(&TOLIB/DSPSRCR1)
             DLTMOD     MODULE(&TOLIB/DSPSRCR2)
             DLTMOD     MODULE(&TOLIB/DSPSRCR3)

             ENDPGM
