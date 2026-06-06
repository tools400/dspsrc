**free
/if not defined(genLstHdr_t)
/define genLstHdr_t
// ============================================================= *
//   Generic List Header for List APIs                           *
//===============================================================*

dcl-ds genLstHdr_t qualified template;
  userArea      char(64);
  size          int(10);
  release       char(4);
  format        char(8);
  API           char(10);
  crtDate       char(13);
  infStat       char(1);
  sizeUsrSpc    int(10);
  ofsInpSct     int(10);
  sizeInpSct    int(10);
  ofsHdrSct     int(10);
  sizeHdrSct    int(10);
  ofsLstSct     int(10);
  sizeLstSct    int(10);
  numE          int(10);
  sizeE         int(10);
  CCSID         int(10);
  cntryID       char(2);
  lngID         char(3);
  subLstInd     char(1);
  reserved_01   char(42);
  //  Additional Format 0300 Fields
  APIEntryPoint char(256);
  reserved_02   char(128);
end-ds;

/endif
