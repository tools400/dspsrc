      /if not defined(errCode_t )
      /define errCode_t
      *===============================================================*
      *  API error code                                               *
      *===============================================================*
     d errCode_t       ds                  qualified           based(pDummy)
     d  bytPrv                       10i 0
     d  bytAvl                       10i 0
     d  excID                         7a
     d  reserved_1                    1a
     d  excDta                      256a
      *
      /endif
