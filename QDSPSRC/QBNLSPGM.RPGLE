**free

// List ILE service program information API
dcl-pr QBNLSPGM extpgm('QBNLSPGM');
  usrSpc char(20) const;
  fmt    char(8) const;
  srvPgm char(20) const;
  errors char(32766) options(*varsize) noopt;
end-pr;

// Structure of an entry in a QBNLSPGM list.
dcl-ds SPGL0100_t qualified based(template);
  srvPgm       char(10);
  srvPgmLib    char(10);
  mod          char(10);
  modLib       char(10);
  srcFile      char(10);
  srcLib       char(10);
  srcMbr       char(10);
  modAttr      char(10);
  modCrtDatTim char(13);
  srcUpdDatTim char(13);
  srtSeqTbl    char(10);
  srtSeqTblLib char(10);
  langId       char(10);
  optLvl       int(10);
  maxOptLvl    int(10);
  dbgDta       char(10);
  rlsCrtOn     char(6);
  rlsCrtFor    char(6);
  reserved_1   char(20);
  usrModInd    char(1);
  licPgm       char(13);
  ptfNbr       char(5);
  aparId       char(6);
  crtDta       char(1);
  modCcsid     int(10);
  objCtlLvl    char(8);
  enablePrfCol char(1);
  profilingDta char(10);
  reserved_2   char(1);
//   ...
end-ds;

// Structure of an entry in a QBNLSPGM list.
dcl-ds SPGL0600_t qualified based(template);
  srvPgmName char(10);
  srvPgmLib  char(10);
  ccsid      int(10);
  procNmSize int(10);
  procNm     char(256);
  usesArgOpt char(10);
end-ds;

// Structure of an entry in a QBNLSPGM list.
dcl-ds SPGL0610_t qualified based(template);
  // Size of this entry. Each entry has a different size.
  size       int(10);
  srvPgmName char(10);
  srvPgmLib  char(10);
  ccsid      int(10);
  procNmOff  int(10);
  procNmSize int(10);
  usesArgOpt char(10);
//   char(*)   -   Reserved
//   char(*)   -   Long procedure export name
end-ds;

