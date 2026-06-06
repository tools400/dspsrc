**free
/if not defined(errCode_t)
/define errCode_t
//===============================================================*
//  API error code                                               *
//===============================================================*
dcl-ds errCode_t qualified template;
  bytPrv     int(10);
  bytAvl     int(10);
  excID      char(7);
  reserved_1 char(1);
  excDta     char(256);
end-ds;

/endif
