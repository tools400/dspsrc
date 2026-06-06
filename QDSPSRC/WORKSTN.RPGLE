**free
/if not defined(WORKSTN)
/define workstn

//  Key pressed
dcl-s keyPressed_t char(1) template;

//  Workstation information data structure
dcl-ds workstn_infds_t qualified template;
  dcl-subf open char(1) pos(9);
  status        zoned(5) pos(11);
  AID           char(1) pos(369);
end-ds;

//  Command keys
dcl-c cKeyF1 X'31';
dcl-c cKeyF2 X'32';
dcl-c cKeyF3 X'33';
dcl-c cKeyF4 X'34';
dcl-c cKeyF5 X'35';
dcl-c cKeyF6 X'36';
dcl-c cKeyF7 X'37';
dcl-c cKeyF8 X'38';
dcl-c cKeyF9 X'39';
dcl-c cKeyF10 X'3A';
dcl-c cKeyF11 X'3B';
dcl-c cKeyF12 X'3C';
dcl-c cKeyF13 X'B1';
dcl-c cKeyF14 X'B2';
dcl-c cKeyF15 X'B3';
dcl-c cKeyF16 X'B4';
dcl-c cKeyF17 X'B5';
dcl-c cKeyF18 X'B6';
dcl-c cKeyF19 X'B7';
dcl-c cKeyF20 X'B8';
dcl-c cKeyF21 X'B9';
dcl-c cKeyF22 X'BA';
dcl-c cKeyF23 X'BB';
dcl-c cKeyF24 X'BC';

dcl-c cKeyClear X'BD';
dcl-c cKeyDelete X'BD';

dcl-c cKeyEnter X'F1';
//          Nicht definiert                   F2
dcl-c cKeyHelp X'F3';
dcl-c cKeyPageDown X'F4';
dcl-c cKeyPageUp X'F5';
dcl-c cKeyPrintScr X'F6';
//          Nicht definiert                   F7
dcl-c cKeyReset X'F8';

dcl-c cKeyLightPen X'3F';

dcl-c cSflFold *off;
dcl-c cSflDrop *on;

//  5250 color codes
//------------------------------------------------------*
// Green
dcl-c c5250_GRN X'20';
// Green/Reverse
dcl-c c5250_GRNR X'21';
// Green/Underscore
dcl-c c5250_GRNU X'24';
// Green/Underscore/Reverse
dcl-c c5250_GRNUR X'25';
//------------------------------------------------------*
// White
dcl-c c5250_WHT X'22';
// White/Reverse
dcl-c c5250_WHTR X'23';
// White/Underscore
dcl-c c5250_WHTU X'26';
//------------------------------------------------------*
// Red
dcl-c c5250_RED X'28';
// Red/Reverse
dcl-c c5250_REDR X'29';
// Red/Blink
dcl-c c5250_REDB X'2A';
// Red/Reverse/Blink
dcl-c c5250_REDRB X'2B';
// Red/Underscore
dcl-c c5250_REDU X'2C';
// Red/Underscore/Reverse
dcl-c c5250_REDUR X'2D';
// Red/Underscore/Blink
dcl-c c5250_REDUB X'2E';
//------------------------------------------------------*
// Turquoise/Column Separators
dcl-c c5250_TRQC X'30';
// Turquoise/Column Separators/Reverse
dcl-c c5250_TRQCR X'31';
// Turquoise/Underscore
dcl-c c5250_TRQU X'34';
// Turquoise/Underscore/Reverse
dcl-c c5250_TRQUR X'35';
//------------------------------------------------------*
// Yellow/Column Separators
dcl-c c5250_YLWC X'32';
// Yellow/Column Separators/Reverse
dcl-c c5250_YLWCR X'33';
// Yellow/Underscore
dcl-c c5250_YLWU X'36';
//------------------------------------------------------*
// Pink
dcl-c c5250_PNK X'38';
// Pink/Reverse
dcl-c c5250_PNKR X'39';
// Pink/Underscore
dcl-c c5250_PNKU X'3C';
// Pink/Underscore/Reverse
dcl-c c5250_PNKUR X'3D';
//------------------------------------------------------*
// Blue
dcl-c c5250_BLU X'3A';
// Blue/Reverse
dcl-c c5250_BLUR X'3B';
// Blue/Underscore
dcl-c c5250_BLUU X'3E';
//------------------------------------------------------*
// Nondisplay
dcl-c c5250_ND1 X'27';
// Nondisplay
dcl-c c5250_ND2 X'2F';
// Nondisplay
dcl-c c5250_ND3 X'37';
// Nondisplay
dcl-c c5250_ND4 X'3F';

/endif
