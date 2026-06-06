**free
/if not defined(QUSRSPC)
/define QUSRSPC

//  Create User Space (QUSCRTUS) API
dcl-pr QUSCRTUS extpgm('QUSCRTUS');
  i_qUsrSpc    char(20) const;
  i_extAttr    char(10) const;
  i_initSize   int(10) const;
  i_initValue  char(1) const;
  i_pubAuth    char(10) const;
  i_text       char(50) const;
  i_replace    char(10) options(*nopass) const; // optGrp 1
  io_ErrCode   char(65535) options(*nopass: *varsize);
  i_domain     char(10) options(*nopass) const; // optGrp 2
  i_tfrSizeReq int(10) options(*nopass) const; // optGrp 3
  i_optSpcAlgn char(1) options(*nopass) const; // optGrp 3
end-pr;

//  Change User Space (QUSCHGUS) API
dcl-pr QUSCHGUS extpgm('QUSCHGUS');
  i_qUsrSpc  char(20) const;
  i_start    int(10) const;
  i_length   int(10) const;
  i_data     char(65535) options(*varsize) const;
  i_force    char(1) const;
  io_ErrCode char(65535) options(*nopass: *varsize); // optGrp 1
end-pr;

//  Retrieve User Space (QUSRTVUS) API
dcl-pr QUSRTVUS extpgm('QUSRTVUS');
  i_qUsrSpc  char(20) const;
  i_start    int(10) const;
  i_length   int(10) const;
  o_rcvVar   char(65535) options(*varsize) const;
  io_ErrCode char(65535) options(*nopass: *varsize); // optGrp 1
end-pr;

//  Retrieve Pointer to User Space (QUSPTRUS) API
dcl-pr QUSPTRUS extpgm('QUSPTRUS');
  i_qUsrSpc  char(20) const;
  o_pUsrSpc  pointer;
  io_ErrCode char(65535) options(*nopass: *varsize); // optGrp 1
end-pr;

//  Change User Space Attributes (QUSCUSAT) API
dcl-pr QUSCUSAT extpgm('QUSCUSAT');
  o_rtnLib   char(10);
  i_qUsrSpc  char(20) const;
  i_attrs    char(65535) options(*varsize) const;
  io_ErrCode char(65535) options(*varsize);
end-pr;

dcl-c QUSRSPC_ATTR_SIZE 1; // BINARY(4)
dcl-c QUSRSPC_ATTR_INITIAL_VALUE 2; // CHAR(1)
dcl-c QUSRSPC_ATTR_AUTO_EXTEND 3; // CHAR(1)
dcl-c QUSRSPC_ATTR_TRANSFER_SIZE_REQ 4; // BINARY(4)

dcl-ds QUSRSPC_attr_size_t qualified template;
  key     int(10);
  dataLen int(10);
  size    int(10);
end-ds;

dcl-ds QUSRSPC_initial_value_t qualified template;
  key     int(10);
  dataLen int(10);
  value   char(1);
end-ds;

dcl-ds QUSRSPC_auto_extend_t qualified template;
  key        int(10);
  dataLen    int(10);
  autoExtend char(1);
end-ds;

dcl-ds QUSRSPC_ztansfer_size_req_t qualified template;
  key        int(10);
  dataLen    int(10);
  tfrSizeReq int(10);
end-ds;

//  Retrieve User Space Attributes (QUSRUSAT) API
dcl-pr QUSRUSAT extpgm('QUSRUSAT');
  o_rcvVar    char(65535) options(*varsize);
  i_lenRcvVar int(10) const;
  i_format    char(8) const;
  i_qUsrSpc   char(20) const;
  io_ErrCode  char(65535) options(*varsize);
end-pr;

//  SPCA0100 Format
dcl-ds SPCA0100_t qualified template;
  bytRet     int(10) pos(1);
  bytAvl     int(10) pos(5);
  size       int(10) pos(9);
  autoExtend char(1) pos(13);
  initValue  char(1) pos(14);
  usrSpcLib  char(10) pos(15);
end-ds;

//  Delete User Space (QUSDLTUS) API
dcl-pr QUSDLTUS extpgm('QUSDLTUS');
  i_qUsrSpc  char(20) const;
  io_ErrCode char(65535) options(*varsize);
end-pr;

/endif
