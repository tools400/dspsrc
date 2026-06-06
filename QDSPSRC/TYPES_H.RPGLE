**free
/if not defined(TYPES_H)
/define TYPES_H

dcl-pr DSPSRCR1;
  i_qPgm   likeds(qObj_t) const;
  i_option char(1) const;
  o_count  packed(10);
  o_module char(512);
end-pr;

dcl-pr DSPSRCR2;
  i_qObj       char(20) const;
  i_objType    char(10) const;
  i_autoSelect ind const;
  o_qSrcFile   likeds(qObj_t);
  o_srcMbr     char(10);
  o_rc         char(10);
end-pr;

dcl-pr DSPSRCR3;
  i_qSrvPgm likeds(qObj_t) const;
  i_option  char(1) const;
  o_count   packed(10);
  o_module  char(512);
end-pr;

/copy qdspsrc,fdqobj

/endif
