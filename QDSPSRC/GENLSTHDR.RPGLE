      /if not defined(genLstHdr_t)
      /define genLstHdr_t
      * ============================================================= *
      *   Generic List Header for List APIs                           *
      *===============================================================*
      *
     d genLstHdr_t...
     d                 ds                  qualified               based(pDummy)
     d  userArea               1     64A
     d  size                  65     68I 0
     d  release               69     72A
     d  format                73     80A
     d  API                   81     90A
     d  crtDate               91    103A
     d  infStat              104    104A
     d  sizeUsrSpc           105    108I 0
     d  ofsInpSct            109    112I 0
     d  sizeInpSct           113    116I 0
     d  ofsHdrSct            117    120I 0
     d  sizeHdrSct           121    124I 0
     d  ofsLstSct            125    128I 0
     d  sizeLstSct           129    132I 0
     d  numE                 133    136I 0
     d  sizeE                137    140I 0
     d  CCSID                141    144I 0
     d  cntryID              145    146A
     d  lngID                147    149A
     d  subLstInd            150    150A
     d  reserved_01          151    192A
      *  Additional Format 0300 Fields
     d  APIEntryPoint        193    448A
     d  reserved_02          449    576A
      *
      /endif
