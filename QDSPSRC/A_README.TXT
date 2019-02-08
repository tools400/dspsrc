DSPSRC - A Tools/400 Utility
----------------------------

DSPSRC is a utility that displays the source code of a given object. For
ILE objects with multiple modules, the DSPSRC command displays the list
of modules to let the user select the one he wants to open.

Dependencies: *NONE

Compile members with the following PDM option:

   STRPREPRC USESRCFILE(&L/&F) USESRCMBR(&N) OPTION(*EVENTF) CHGOBJD(*NO)
     LIB(&O) OBJ(&N) SRCLIB(&L) SRCFILE(&F) SRCMBR(&N) USER0(&X)
     USER1(*LIST) USER2(*FULL)

Members of type MAKPGM or BND are used for linking programs (MAKPGM)
and service programs (BND).

2019, Thomas Raddatz
