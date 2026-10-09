#-----------------------------------------------------------------------
#  Utility . . . : DSPSRC
#  Description   : Builds the DSPSRC utility from the IFS of an IBM i.
#  Author  . . . : Thomas Raddatz   <thomas.raddatz@tools400.de>
#
#  Usage:
#
#    gmake                   Builds all objects into library $(BIN_LIB)
#    gmake BIN_LIB=MYLIB     Builds all objects into library MYLIB
#    gmake LNG=ENG           Builds the English version of the utility
#    gmake clean             Deletes the objects of the utility
#    gmake erase             Deletes the whole target library
#
#  Call gmake from the root directory of the project, because the
#  source paths are specified relative to the current directory.
#
#  Library list:
#
#    Module DSPSRCR2 declares the display file DSPSRCD, which the RPG
#    compiler resolves through the library list of the compile job.
#    Every "system" call runs in its own job, so neither the makefile
#    nor the caller can prepare that list with ADDLIBLE. RUNSQLSTM runs
#    all statements of a script in one job, hence DSPSRCR2 is compiled
#    through a generated script that sets the library list first.
#
#  This makefile is the IFS equivalent of QDSPSRC/A_INSTALL.CLP.
#-----------------------------------------------------------------------

NAME=Display source - A tools400 utility
BIN_LIB=DSPSRC
SRCDIR=QDSPSRC

#  Language of the display file, the help panel group and the command.
#  GER = German, ENG = English.
LNG=GER

ifeq ($(LNG),ENG)
DSPF_SRC=DSPSRCDE
PNLGRP_SRC=DSPSRCPE
CMD_SRC=DSPSRCE
else
DSPF_SRC=DSPSRCDG
PNLGRP_SRC=DSPSRCPG
CMD_SRC=DSPSRCG
endif

#  Temporary source file for sources that cannot be compiled from the
#  IFS. Deliberately not named QSOURCE, so that an existing source file
#  of the target library can never be deleted by 'cleanup' or 'clean'.
TMP_SRCF=QGMAKESRC

#  Generated script that compiles DSPSRCR2 in a job of its own.
TMP_SQL=/tmp/gmake_$(BIN_LIB)_dspsrcr2.sql

DBGVIEW=*LIST
TGTRLS=*CURRENT
TGTCCSID=*JOB

#-----------------------------------------------------------------------
#  Objects
#-----------------------------------------------------------------------

all: $(BIN_LIB).lib DSPSRCD.FILE DSPSRCC.CLLE DSPSRCR1.RPGLE DSPSRCR2.RPGLE \
     DSPSRCR3.RPGLE DSPSRCC.PGM DSPSRCP.PNLGRP DSPSRC.CMD cleanup
	@echo "Built all"

#  Build order. The display file comes first, because DSPSRCR2 needs its
#  external description. The command needs the program and the help
#  panel group, hence it is built last.
DSPSRCD.FILE: $(BIN_LIB).lib
DSPSRCP.PNLGRP: $(BIN_LIB).lib
DSPSRCC.CLLE: $(BIN_LIB).lib
DSPSRCR1.RPGLE DSPSRCR3.RPGLE: $(BIN_LIB).lib
DSPSRCR2.RPGLE: $(BIN_LIB).lib DSPSRCD.FILE
DSPSRCC.PGM: DSPSRCC.CLLE DSPSRCR1.RPGLE DSPSRCR2.RPGLE DSPSRCR3.RPGLE
DSPSRC.CMD: DSPSRCC.PGM DSPSRCP.PNLGRP

#-----------------------------------------------------------------------
#  Rules
#
#  Commands that would fail because an object already exists or does not
#  exist yet are guarded with "test" on the /QSYS.lib view. A failing
#  "system" call dies from a signal, and the shell then prints
#  "IOT/Abort trap" no matter how the output is redirected, so the call
#  has to be avoided instead of silenced.
#-----------------------------------------------------------------------

#  CRTDSPF does not support stream files and has no REPLACE parameter,
#  therefore the source is copied to a temporary source file member
#  first and an existing display file is deleted. CPYFRMSTMF creates
#  the member itself, it does not have to exist.
DSPSRCD.FILE:
	system "CPYFRMSTMF FROMSTMF('$(SRCDIR)/$(DSPF_SRC).DSPF') TOMBR('/QSYS.lib/$(BIN_LIB).lib/$(TMP_SRCF).file/DSPSRCD.mbr') MBROPT(*REPLACE)"
	! test -e /QSYS.lib/$(BIN_LIB).lib/DSPSRCD.FILE || system "DLTF FILE($(BIN_LIB)/DSPSRCD)"
	system "CRTDSPF FILE($(BIN_LIB)/DSPSRCD) SRCFILE($(BIN_LIB)/$(TMP_SRCF)) SRCMBR(DSPSRCD) TEXT('$(NAME)')"

#  DSPSRCR2 declares the display file DSPSRCD, which the RPG compiler
#  looks up in the library list. RUNSQLSTM runs CHGLIBL and CRTRPGMOD
#  in the same job, which a pair of "system" calls cannot do. The
#  quotes of the CL command are doubled, because it is an SQL string.
DSPSRCR2.RPGLE:
	echo "CALL QSYS2.QCMDEXC('CHGLIBL LIBL($(BIN_LIB) QGPL)');" > $(TMP_SQL)
	echo "CALL QSYS2.QCMDEXC('CRTRPGMOD MODULE($(BIN_LIB)/DSPSRCR2) SRCSTMF(''$(SRCDIR)/DSPSRCR2.RPGLE'') INCDIR(''$(SRCDIR)'') DEFINE(IFS_BUILD) TEXT(''$(NAME)'') REPLACE(*YES) DBGVIEW($(DBGVIEW)) TRUNCNBR(*NO) TGTRLS($(TGTRLS)) TGTCCSID($(TGTCCSID))');" >> $(TMP_SQL)
	system "RUNSQLSTM SRCSTMF('$(TMP_SQL)') COMMIT(*NONE)"
	rm -f $(TMP_SQL)

DSPSRCC.CLLE:
	system "CRTCLMOD MODULE($(BIN_LIB)/DSPSRCC) SRCSTMF('$(SRCDIR)/DSPSRCC.CLLE') TEXT('$(NAME)') REPLACE(*YES) DBGVIEW($(DBGVIEW)) TGTRLS($(TGTRLS))"

#  DEFINE(IFS_BUILD) switches the sources over to the IFS copy books
#  "/copy 'H_SPEC.RPGLE'", which INCDIR resolves in $(SRCDIR). Without
#  it the compiler resolves "/copy QDSPSRC,H_SPEC" through the library
#  list and silently picks up a QDSPSRC source file of another library
#  instead of the sources of this repository.
%.RPGLE:
	system "CRTRPGMOD MODULE($(BIN_LIB)/$*) SRCSTMF('$(SRCDIR)/$*.RPGLE') INCDIR('$(SRCDIR)') DEFINE(IFS_BUILD) TEXT('$(NAME)') REPLACE(*YES) DBGVIEW($(DBGVIEW)) TRUNCNBR(*NO) TGTRLS($(TGTRLS)) TGTCCSID($(TGTCCSID))"

DSPSRCC.PGM:
	system "CRTPGM PGM($(BIN_LIB)/DSPSRCC) MODULE($(BIN_LIB)/DSPSRCC $(BIN_LIB)/DSPSRCR1 $(BIN_LIB)/DSPSRCR2 $(BIN_LIB)/DSPSRCR3) ENTMOD($(BIN_LIB)/DSPSRCC) ACTGRP(*NEW) DETAIL(*BASIC) REPLACE(*YES) TEXT('$(NAME)') TGTRLS($(TGTRLS))"

#  CRTPNLGRP does not support stream files, therefore the source is
#  copied to a temporary source file member first.
DSPSRCP.PNLGRP:
	system "CPYFRMSTMF FROMSTMF('$(SRCDIR)/$(PNLGRP_SRC).PNLGRP') TOMBR('/QSYS.lib/$(BIN_LIB).lib/$(TMP_SRCF).file/DSPSRCP.mbr') MBROPT(*REPLACE)"
	system "CRTPNLGRP PNLGRP($(BIN_LIB)/DSPSRCP) SRCFILE($(BIN_LIB)/$(TMP_SRCF)) SRCMBR(DSPSRCP) REPLACE(*YES) TEXT('$(NAME)')"

#  CRTCMD has no REPLACE parameter, hence the command is deleted first.
DSPSRC.CMD:
	! test -e /QSYS.lib/$(BIN_LIB).lib/DSPSRC.CMD || system "DLTCMD CMD($(BIN_LIB)/DSPSRC)"
	system "CRTCMD CMD($(BIN_LIB)/DSPSRC) PGM($(BIN_LIB)/DSPSRCC) SRCSTMF('$(SRCDIR)/$(CMD_SRC).CMD') TEXT('$(NAME)') HLPPNLGRP($(BIN_LIB)/DSPSRCP) HLPID(DSPSRC)"

%.lib:
	test -d /QSYS.lib/$*.lib || system "CRTLIB LIB($*) TEXT('$(NAME)')"
	test -e /QSYS.lib/$*.lib/$(TMP_SRCF).FILE || system "CRTSRCPF FILE($*/$(TMP_SRCF)) RCDLEN(112) TEXT('Temporary source file, used by gmake')"

#-----------------------------------------------------------------------
#  Housekeeping
#
#  The modules are deleted after binding, just like A_INSTALL.CLP does,
#  so that the target library ends up with the same objects.
#-----------------------------------------------------------------------

cleanup:
	rm -f $(TMP_SQL)
	! test -e /QSYS.lib/$(BIN_LIB).lib/DSPSRCC.MODULE || system "DLTMOD MODULE($(BIN_LIB)/DSPSRCC)"
	! test -e /QSYS.lib/$(BIN_LIB).lib/DSPSRCR1.MODULE || system "DLTMOD MODULE($(BIN_LIB)/DSPSRCR1)"
	! test -e /QSYS.lib/$(BIN_LIB).lib/DSPSRCR2.MODULE || system "DLTMOD MODULE($(BIN_LIB)/DSPSRCR2)"
	! test -e /QSYS.lib/$(BIN_LIB).lib/DSPSRCR3.MODULE || system "DLTMOD MODULE($(BIN_LIB)/DSPSRCR3)"
	! test -e /QSYS.lib/$(BIN_LIB).lib/$(TMP_SRCF).FILE || system "DLTF FILE($(BIN_LIB)/$(TMP_SRCF))"

clean: cleanup
	! test -e /QSYS.lib/$(BIN_LIB).lib/DSPSRC.CMD || system "DLTCMD CMD($(BIN_LIB)/DSPSRC)"
	! test -e /QSYS.lib/$(BIN_LIB).lib/DSPSRCP.PNLGRP || system "DLTPNLGRP PNLGRP($(BIN_LIB)/DSPSRCP)"
	! test -e /QSYS.lib/$(BIN_LIB).lib/DSPSRCC.PGM || system "DLTPGM PGM($(BIN_LIB)/DSPSRCC)"
	! test -e /QSYS.lib/$(BIN_LIB).lib/DSPSRCD.FILE || system "DLTF FILE($(BIN_LIB)/DSPSRCD)"

erase:
	! test -d /QSYS.lib/$(BIN_LIB).lib || system "DLTLIB LIB($(BIN_LIB))"
