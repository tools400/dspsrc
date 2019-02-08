      /if not defined(TYPES_H)
      /define TYPES_H
      *
     D DSPSRCR1...
     D                 PR
     D  i_qPgm                             const likeds(qObj_t)
     D  i_option                      1A   const
     D  o_count                      10P 0
     D  o_module                    512A
      *
     D DSPSRCR2...
     D                 PR
     D  i_qObj                       20A   const
     D  i_objType                    10A   const
     D  i_autoSelect                   N   const
     D  o_qSrcFile                               likeds(qObj_t)
     D  o_srcMbr                     10A
     D  o_rc                         10A
      *
     D DSPSRCR3...
     D                 PR
     D  i_qSrvPgm                          const likeds(qObj_t)
     D  i_option                      1A   const
     D  o_count                      10P 0
     D  o_module                    512A
      *
      /copy qdspsrc,fdqobj
      *
      /endif
