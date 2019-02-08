/* -------------------------------------------------------------------------- */
/* DSPSRC     - SCRIPT MEMBER                                                 */
/* Use commands  xmlgenINC (generate text for install pgm)                    */
/*               xmlgenMBR (to define source members                          */
/*               xmlgenCMD (execute qcmdexc at run time                       */
/* Put &TOLIB where you want user selected lib at run time.                   */
   DCL &TOLIB *CHAR 10
/* -------------------------------------------------------------------------- */
             XMLGENINC  XINCLUDE(*YES)


             XMLGENVRS XSRCFILE(QDSPSRC) XSRCLIB(TOOLS400) XSRCMBR(COPYRIGHT)

             XMLGENCND  XMSG('Select language (GER, ENG)') +
                          XVALUES(GER ENG) XVAR(&LANG)

             XMLGENSET  XVAR(&SRCFILE) XVALUE(QDSPSRC)

/* ---------------------------------- */
/*  Deploy source member              */
/* ---------------------------------- */
             XMLGENMBR  XMBR(A_INSTALL ) XMBRATR(CLP   ) +
                          XFROMSRCF(QDSPSRC   ) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QDSPSRC   ) XOBJTYPE(*CMD    ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(A_README  ) XMBRATR(TXT   ) +
                          XFROMSRCF(QDSPSRC   ) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QDSPSRC   ) XOBJTYPE(*CMD    ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(COPYRIGHT ) XMBRATR(RPGLE ) +
                          XFROMSRCF(QDSPSRC   ) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QDSPSRC   ) XOBJTYPE(*CMD    ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(DSPSRCC   ) XMBRATR(CLLE ) +
                          XFROMSRCF(QDSPSRC   ) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QDSPSRC   ) XOBJTYPE(*PGM ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(DSPSRCDE  ) XMBRATR(DSPF ) +
                          XFROMSRCF(QDSPSRC   ) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QDSPSRC   ) XOBJTYPE(*FILE) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(DSPSRCDG  ) XMBRATR(DSPF ) +
                          XFROMSRCF(QDSPSRC   ) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QDSPSRC   ) XOBJTYPE(*FILE) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(DSPSRCE   ) XMBRATR(CMD   ) +
                          XFROMSRCF(QDSPSRC   ) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QDSPSRC   ) XOBJTYPE(*CMD    ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(DSPSRCG   ) XMBRATR(CMD   ) +
                          XFROMSRCF(QDSPSRC   ) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QDSPSRC   ) XOBJTYPE(*CMD    ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(DSPSRCPE  ) XMBRATR(PNLGRP) +
                          XFROMSRCF(QDSPSRC   ) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QDSPSRC   ) XOBJTYPE(*PNLGRP) +
                          XGENCRT(*NO ) XPARAM(*BLANK) +
                          XCND(*NONE)

             XMLGENMBR  XMBR(DSPSRCPG  ) XMBRATR(PNLGRP) +
                          XFROMSRCF(QDSPSRC   ) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QDSPSRC   ) XOBJTYPE(*PNLGRP) +
                          XGENCRT(*NO ) XPARAM(*BLANK) +
                          XCND(*NONE)

             XMLGENMBR  XMBR(DSPSRCR1) XMBRATR(RPGLE) +
                          XFROMSRCF(QDSPSRC   ) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QDSPSRC   ) XOBJTYPE(*PGM ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(DSPSRCR2) XMBRATR(RPGLE) +
                          XFROMSRCF(QDSPSRC   ) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QDSPSRC   ) XOBJTYPE(*PGM ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(DSPSRCR3) XMBRATR(RPGLE) +
                          XFROMSRCF(QDSPSRC   ) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QDSPSRC   ) XOBJTYPE(*PGM ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(FDERRCODE ) XMBRATR(RPGLE ) +
                          XFROMSRCF(QDSPSRC   ) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QDSPSRC   ) XOBJTYPE(*CMD    ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(FDQOBJ    ) XMBRATR(RPGLE ) +
                          XFROMSRCF(QDSPSRC   ) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QDSPSRC   ) XOBJTYPE(*CMD    ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(GENLSTHDR ) XMBRATR(RPGLE ) +
                          XFROMSRCF(QDSPSRC   ) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QDSPSRC   ) XOBJTYPE(*CMD    ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(H_SPEC    ) XMBRATR(RPGLE ) +
                          XFROMSRCF(QDSPSRC   ) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QDSPSRC   ) XOBJTYPE(*CMD    ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(QCMDEXC   ) XMBRATR(RPGLE ) +
                          XFROMSRCF(QDSPSRC   ) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QDSPSRC   ) XOBJTYPE(*CMD    ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(QBNLPGMI  ) XMBRATR(RPGLE ) +
                          XFROMSRCF(QDSPSRC   ) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QDSPSRC   ) XOBJTYPE(*CMD    ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(QBNLSPGM  ) XMBRATR(RPGLE ) +
                          XFROMSRCF(QDSPSRC   ) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QDSPSRC   ) XOBJTYPE(*CMD    ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(QUSRSPC   ) XMBRATR(RPGLE ) +
                          XFROMSRCF(QDSPSRC   ) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QDSPSRC   ) XOBJTYPE(*CMD    ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(WORKSTN   ) XMBRATR(RPGLE ) +
                          XFROMSRCF(QDSPSRC   ) XFROMSRCL(TOOLS400) +
                          XTOSRCF(QDSPSRC   ) XOBJTYPE(*CMD    ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

/* ---------------------------------- */
/*  Create objects                    */
/* ---------------------------------- */
             XMLGENCMD  XCMD(CRTBNDCL PGM(&TOLIB/A_INSTALL) +
                          SRCFILE(&TOLIB/QDSPSRC) SRCMBR(*PGM) +
                          DFTACTGRP(*NO) ACTGRP(*NEW) +
                          DBGVIEW(*LIST)) XDLTSPLF(A_INSTALL)

             XMLGENCMD  XCMD(CALL PGM(&TOLIB/A_INSTALL) +
                             PARM('&TGTRLS' '&SRCFILE' '&TOLIB' '&LANG'))
             XMLGENCMD  XCMD(DLTPGM PGM(&TOLIB/A_INSTALL))

