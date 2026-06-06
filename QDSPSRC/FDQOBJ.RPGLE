**free
/if not defined(qObj_t)
/define qObj_t
// ============================================================= *
//   Qualified object name                                       *
//===============================================================*

dcl-ds qObj_t qualified template;
  name char(10);
  lib  char(10);
end-ds;

/endif
