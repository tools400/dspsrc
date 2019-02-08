      /if not defined(QUSRSPC)
      /define QUSRSPC
      *
      *  Create User Space (QUSCRTUS) API
     d QUSCRTUS...
     d                 pr                  extpgm('QUSCRTUS')
     d  i_qUsrSpc                    20A   const
     d  i_extAttr                    10a   const
     d  i_initSize                   10i 0 const
     d  i_initValue                   1a   const
     d  i_pubAuth                    10a   const
     d  i_text                       50A   const
     d  i_replace                    10a   const options(*nopass)               | optGrp 1
     d  io_ErrCode                65535a         options(*nopass: *varsize)     |
     d  i_domain                     10a   const options(*nopass)               | optGrp 2
     d  i_tfrSizeReq                 10i 0 const options(*nopass)               | optGrp 3
     d  i_optSpcAlgn                  1a   const options(*nopass)               | optGrp 3
      *
      *  Change User Space (QUSCHGUS) API
     d QUSCHGUS...
     d                 pr                  extpgm('QUSCHGUS')
     d  i_qUsrSpc                    20A   const
     d  i_start                      10i 0 const
     d  i_length                     10i 0 const
     d  i_data                    65535a   const options(*varsize)
     d  i_force                       1a   const
     d  io_ErrCode                65535a         options(*nopass: *varsize)     | optGrp 1
      *
      *  Retrieve User Space (QUSRTVUS) API
     d QUSRTVUS...
     d                 pr                  extpgm('QUSRTVUS')
     d  i_qUsrSpc                    20A   const
     d  i_start                      10i 0 const
     d  i_length                     10i 0 const
     d  o_rcvVar                  65535a   const options(*varsize)
     d  io_ErrCode                65535a         options(*nopass: *varsize)     | optGrp 1
      *
      *  Retrieve Pointer to User Space (QUSPTRUS) API
     d QUSPTRUS...
     d                 pr                  extpgm('QUSPTRUS')
     d  i_qUsrSpc                    20A   const
     d  o_pUsrSpc                      *
     d  io_ErrCode                65535a         options(*nopass: *varsize)     | optGrp 1
      *
      *  Change User Space Attributes (QUSCUSAT) API
     d QUSCUSAT...
     d                 pr                  extpgm('QUSCUSAT')
     d  o_rtnLib                     10a
     d  i_qUsrSpc                    20A   const
     d  i_attrs                   65535a   const options(*varsize)
     d  io_ErrCode                65535a         options(*varsize)
      *
     d QUSRSPC_ATTR_SIZE...
     d                 c                   1                                    BINARY(4)
     d QUSRSPC_ATTR_INITIAL_VALUE...
     d                 c                   2                                    CHAR(1)
     d QUSRSPC_ATTR_AUTO_EXTEND...
     d                 c                   3                                    CHAR(1)
     d QUSRSPC_ATTR_TRANSFER_SIZE_REQ...
     d                 c                   4                                    BINARY(4)
      *
     d QUSRSPC_attr_size_t...
     d                 ds                  qualified               based(pDummy)
     d  key                          10i 0
     d  dataLen                      10i 0
     d  size                         10i 0
      *
     d QUSRSPC_initial_value_t...
     d                 ds                  qualified               based(pDummy)
     d  key                          10i 0
     d  dataLen                      10i 0
     d  value                         1a
      *
     d QUSRSPC_auto_extend_t...
     d                 ds                  qualified               based(pDummy)
     d  key                          10i 0
     d  dataLen                      10i 0
     d  autoExtend                    1a
      *
     d QUSRSPC_ztansfer_size_req_t...
     d                 ds                  qualified               based(pDummy)
     d  key                          10i 0
     d  dataLen                      10i 0
     d  tfrSizeReq                   10i 0
      *
      *  Retrieve User Space Attributes (QUSRUSAT) API
     d QUSRUSAT...
     d                 pr                  extpgm('QUSRUSAT')
     d  o_rcvVar                  65535a         options(*varsize)
     d  i_lenRcvVar                  10i 0 const
     d  i_format                      8a   const
     d  i_qUsrSpc                    20A   const
     d  io_ErrCode                65535a         options(*varsize)
      *
      *  SPCA0100 Format
     d SPCA0100_t      ds                  qualified               based(pDummy)
     d  bytRet                 1      4I 0
     d  bytAvl                 5      8I 0
     d  size                   9     12I 0
     d  autoExtend            13     13A
     d  initValue             14     14A
     d  usrSpcLib             15     24A
      *
      *  Delete User Space (QUSDLTUS) API
     d QUSDLTUS...
     d                 pr                  extpgm('QUSDLTUS')
     d  i_qUsrSpc                    20A   const
     d  io_ErrCode                65535a         options(*varsize)
      *
      /endif
