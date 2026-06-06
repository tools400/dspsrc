**free

//  ... Execute Command (QCMDEXC) API
dcl-pr QCMDEXC extpgm('QCMDEXC');
  i_cmd        char(32702) options(*varsize) const;
  i_length     packed(15: 5) const;
  i_IGCprcCtrl char(3) options(*nopass) const;
end-pr;

dcl-c QCMDEXC_IGC 'IGC';

