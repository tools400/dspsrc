
       // List ILE service program information API
     d QBNLSPGM        pr                  ExtPgm('QBNLSPGM')
     d   usrSpc                      20a   Const
     d   fmt                          8a   Const
     d   srvPgm                      20a   Const
     d   errors                   32766a   Options(*VarSize) NoOpt

       // Structure of an entry in a QBNLSPGM list.
     d SPGL0100_t      ds                  Qualified Based(template)
     d  srvPgm                       10a
     d  srvPgmLib                    10a
     d  mod                          10a
     d  modLib                       10a
     d  srcFile                      10a
     d  srcLib                       10a
     d  srcMbr                       10a
     d  modAttr                      10a
     d  modCrtDatTim                 13a
     d  srcUpdDatTim                 13a
     d  srtSeqTbl                    10a
     d  srtSeqTblLib                 10a
     d  langId                       10a
     d  optLvl                       10i 0
     d  maxOptLvl                    10i 0
     d  dbgDta                       10a
     d  rlsCrtOn                      6a
     d  rlsCrtFor                     6a
     d  reserved_1                   20a
     d  usrModInd                     1a
     d  licPgm                       13a
     d  ptfNbr                        5a
     d  aparId                        6a
     d  crtDta                        1a
     d  modCcsid                     10i 0
     d  objCtlLvl                     8a
     d  enablePrfCol                  1a
     d  profilingDta                 10a
     d  reserved_2                    1a
      *   ...

       // Structure of an entry in a QBNLSPGM list.
     d SPGL0600_t      ds                  Qualified Based(template)
     d  srvPgmName                   10a
     d  srvPgmLib                    10a
     d  ccsid                        10i 0
     d  procNmSize                   10i 0
     d  procNm                      256a
     d  usesArgOpt                   10a

       // Structure of an entry in a QBNLSPGM list.
     d SPGL0610_t      ds                  Qualified Based(template)
        // Size of this entry. Each entry has a different size.
     d  size                         10i 0
     d  srvPgmName                   10a
     d  srvPgmLib                    10a
     d  ccsid                        10i 0
     d  procNmOff                    10i 0
     d  procNmSize                   10i 0
     d  usesArgOpt                   10a
      *   char(*)   -   Reserved
      *   char(*)   -   Long procedure export name

