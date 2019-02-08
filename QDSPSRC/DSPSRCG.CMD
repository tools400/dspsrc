/* =================================================================== */
/*                                                                     */
/*  Kurzdokumentation :                                                */
/*                                                                     */
/*  Bereich . . . : DSPSRC                                             */
/*  Objekt  . . . : DSPSRCG                                            */
/*  Beschreibung  : Tool: DSPSRC     (Display Source Code) Ger         */
/*  Author  . . . : Thomas Raddatz   <thomas.raddatz@tools400.de>      */
/*  Datum . . . . : 25.07.2001                                         */
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
/* >>PRE-COMPILER<<                                                    */
/*                                                                     */
/*   >>CRTCMD<< CRTCMD       CMD(&LI/DSPSRC) +                         */
/*                           SRCFILE(&SL/&SF) +                        */
/*                           SRCMBR(&SM);                              */
/*                                                                     */
/*   >>COMPILE<<                                                       */
/*     >>PARM<< PGM(*LIBL/DSPSRCC);                                    */
/*     >>PARM<< HLPPNLGRP(*LIBL/DSPSRCP);                              */
/*     >>PARM<< HLPID(DSPSRC);                                         */
/*   >>END-COMPILE<<                                                   */
/*                                                                     */
/*   >>EXECUTE<<                                                       */
/*                                                                     */
/* >>END-PRE-COMPILER<<                                                */
/* =================================================================== */
/*                                                                     */
/*  Bei einer Erweiterung des Parameters OBJTYPE, bitte auch im        */
/*  CL-Programm die Variable &TYPAVAIL entsprechend ändern.            */
/*  Max. sind 10 Typen möglich. Danach muß die auch die Länge          */
/*  von &TYPAVAIL sowie die Abfrage auf 100 geändert werden.           */
/*                                                                     */
/* =================================================================== */

             CMD        PROMPT('Quellenteildatei anzeigen')

             PARM       KWD(OBJ) TYPE(QUAL1)     +
                          MIN(1)                 +
                          PROMPT('Objekt')

             PARM       KWD(OBJTYPE) TYPE(*CHAR) +
                          LEN(10)                +
                          RSTD(*YES)             +
                          DFT(*SEARCH)           +
                          VALUES(*SEARCH         +
                                 *CMD            +
                                 *FILE           +
                                 *MODULE         +
                                 *PGM            +
                                 *SRVPGM         +
                                 *TBL            +
                                 )               +
                          PROMPT('Objektart')

             PARM       KWD(DSPMOD) TYPE(*CHAR)  +
                          LEN(1)                 +
                          RSTD(*YES)             +
                          DFT(*NO)               +
                          SPCVAL((*YES 1)        +
                                 (*NO  0))       +
                          PMTCTL(*PMTRQS)        +
                          PROMPT('ILE-Module anzeigen')

 QUAL1:      QUAL       TYPE(*NAME) LEN(10) MIN(1)
             QUAL       TYPE(*NAME) LEN(10) DFT(*LIBL) +
                          SPCVAL((*LIBL) (*CURLIB)) +
                          PROMPT('Bibliothek')

