      /if not defined(WORKSTN)
      /define WORKSTN
      *
      *  Key pressed
     d keyPressed_t    s              1a   based(pDummy)
      *
      *  Workstation information data structure
     d workstn_infds_t...
     d                 ds                  qualified               based(pDummy)
     d  open                   9      9A
     d  status                11     15S 0
     d  AID                  369    369A
      *
      *  Command keys
     d cKeyF1          c                   CONST(X'31')
     d cKeyF2          c                   CONST(X'32')
     d cKeyF3          c                   CONST(X'33')
     d cKeyF4          c                   CONST(X'34')
     d cKeyF5          c                   CONST(X'35')
     d cKeyF6          c                   CONST(X'36')
     d cKeyF7          c                   CONST(X'37')
     d cKeyF8          c                   CONST(X'38')
     d cKeyF9          c                   CONST(X'39')
     d cKeyF10         c                   CONST(X'3A')
     d cKeyF11         c                   CONST(X'3B')
     d cKeyF12         c                   CONST(X'3C')
     d cKeyF13         c                   CONST(X'B1')
     d cKeyF14         c                   CONST(X'B2')
     d cKeyF15         c                   CONST(X'B3')
     d cKeyF16         c                   CONST(X'B4')
     d cKeyF17         c                   CONST(X'B5')
     d cKeyF18         c                   CONST(X'B6')
     d cKeyF19         c                   CONST(X'B7')
     d cKeyF20         c                   CONST(X'B8')
     d cKeyF21         c                   CONST(X'B9')
     d cKeyF22         c                   CONST(X'BA')
     d cKeyF23         c                   CONST(X'BB')
     d cKeyF24         c                   CONST(X'BC')
      *
     d cKeyClear       c                   CONST(X'BD')
     d cKeyDelete      c                   CONST(X'BD')
      *
     d cKeyEnter       c                   CONST(X'F1')
      *          Nicht definiert                   F2
     d cKeyHelp        c                   CONST(X'F3')
     d cKeyPageDown    c                   CONST(X'F4')
     d cKeyPageUp      c                   CONST(X'F5')
     d cKeyPrintScr    c                   CONST(X'F6')
      *          Nicht definiert                   F7
     d cKeyReset       c                   CONST(X'F8')
      *
     d cKeyLightPen    c                   CONST(X'3F')
      *
     d cSflFold        c                   CONST(*off)
     d cSflDrop        c                   CONST(*on )
      *
      *  5250 color codes
      *------------------------------------------------------*
      * Green
     d c5250_GRN       c                   CONST(X'20')
      * Green/Reverse
     d c5250_GRNR      c                   CONST(X'21')
      * Green/Underscore
     d c5250_GRNU      c                   CONST(X'24')
      * Green/Underscore/Reverse
     d c5250_GRNUR     c                   CONST(X'25')
      *------------------------------------------------------*
      * White
     d c5250_WHT       c                   CONST(X'22')
      * White/Reverse
     d c5250_WHTR      c                   CONST(X'23')
      * White/Underscore
     d c5250_WHTU      c                   CONST(X'26')
      *------------------------------------------------------*
      * Red
     d c5250_RED       c                   CONST(X'28')
      * Red/Reverse
     d c5250_REDR      c                   CONST(X'29')
      * Red/Blink
     d c5250_REDB      c                   CONST(X'2A')
      * Red/Reverse/Blink
     d c5250_REDRB     c                   CONST(X'2B')
      * Red/Underscore
     d c5250_REDU      c                   CONST(X'2C')
      * Red/Underscore/Reverse
     d c5250_REDUR     c                   CONST(X'2D')
      * Red/Underscore/Blink
     d c5250_REDUB     c                   CONST(X'2E')
      *------------------------------------------------------*
      * Turquoise/Column Separators
     d c5250_TRQC      c                   CONST(X'30')
      * Turquoise/Column Separators/Reverse
     d c5250_TRQCR     c                   CONST(X'31')
      * Turquoise/Underscore
     d c5250_TRQU      c                   CONST(X'34')
      * Turquoise/Underscore/Reverse
     d c5250_TRQUR     c                   CONST(X'35')
      *------------------------------------------------------*
      * Yellow/Column Separators
     d c5250_YLWC      c                   CONST(X'32')
      * Yellow/Column Separators/Reverse
     d c5250_YLWCR     c                   CONST(X'33')
      * Yellow/Underscore
     d c5250_YLWU      c                   CONST(X'36')
      *------------------------------------------------------*
      * Pink
     d c5250_PNK       c                   CONST(X'38')
      * Pink/Reverse
     d c5250_PNKR      c                   CONST(X'39')
      * Pink/Underscore
     d c5250_PNKU      c                   CONST(X'3C')
      * Pink/Underscore/Reverse
     d c5250_PNKUR     c                   CONST(X'3D')
      *------------------------------------------------------*
      * Blue
     d c5250_BLU       c                   CONST(X'3A')
      * Blue/Reverse
     d c5250_BLUR      c                   CONST(X'3B')
      * Blue/Underscore
     d c5250_BLUU      c                   CONST(X'3E')
      *------------------------------------------------------*
      * Nondisplay
     d c5250_ND1       c                   CONST(X'27')
      * Nondisplay
     d c5250_ND2       c                   CONST(X'2F')
      * Nondisplay
     d c5250_ND3       c                   CONST(X'37')
      * Nondisplay
     d c5250_ND4       c                   CONST(X'3F')
      *
      /endif
