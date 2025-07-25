FOOZP    equ   $f0
OVERL    equ   $3000
projover equ   $3100      ;replaced by proj symbol w/same name, diff addr (no match)
FOO      equ   $f000
FOO_5    equ   $f005

         org   $2000
         jmp   skip

         asc   'hello, '  ;string should be split by no-op addr change
         org   $200a
         asc   'world'
         dfb   $80

         org   $2100
skip     lda   #$00
         sta   addr1-1    ;edit this operand
         sta   addr1
         sta   addr1+1
         jmp   next1

         asc   'testing stuff.'
addr1    asc   '!?---'
         org   $00f4
zf4      dfb   $00
         dfb   $00
L00F6    dfb   $00
         dfb   $00
         org   $2200
line1    asc   'this is line1',00
line2    asc   'this is line2',00
L221C    asc   'this is line3',00
         asc   'this is line4',00
         dfb   $80

]foo_f0  equ   $f0
]foo_f4  equ   $f4
next1    lda   addr1
         sta   FOO
         sta   FOO_5
         sta   FOO+8
         ldx   OVERL
         ldx   projover
         ldx   $4000
         ldx   line1
         ldx   line2+1
         ldx   L221C
         ldx   L221C+1
         ldx   line2+35
         ldy   $00
         ldy   ]foo_f0
         ldy   ]foo_f0+1
         ldy   FOOZP+2
         ldy   zf4
         ldy   L00F6
         lda   #$00
         nop
         bcc   bitsy+1
bitsy    dfb   $2c
         lda   #$ff
         jmp   :L228B

         dw    FOO
         dw    FOO_5
         dw    FOO+9
         dw    OVERL
         dw    projover
         dw    $4000
         dw    line1
         dw    line2+5
         dw    L221C
         dw    line2+33
         dw    zf4
         dfb   $80

:L228B   nop
         jmp   :L22A8

         dfb   $4c
         dfb   $8b
         asc   '"L9"L'
         dfb   $95
         dfb   $22
         dfb   $4c
         dfb   $00
         dfb   $30
         dfb   $ea
         asc   'L9"L'
         dfb   $00
         asc   '1LLLLLL'

:L22A8   rts

