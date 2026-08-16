        .cpu    "65816"
*       =       $1000
        .as
        .xs
        sec
        xce
        jsr     L101F
        jsr     L10AB
        jsr     L10F2
        jsr     L1106
        jsr     L1109
        jsr     L112C
        jsr     L11F9
        jsr     L11FC
        nop
        nop
        nop
        brk

        .byte   $80

L101F   ora     (L0080,x)
        cop     #$80
        ora     $80,s
        tsb     L0080
        ora     L0080
        asl     L0080
        ora     [L0080]
        php
        ora     #$80
        asl     a
        phd
        tsb     @w L0086
        ora     @w L0086
        asl     @w L0086
        ora     @l L0089
        bpl     _L1041
_L1041  ora     (L0080),y
        ora     (L0080)
        ora     ($80,s),y
        trb     L0080
        ora     L0080,x
        asl     L0080,x
        ora     [L0080],y
        clc
        ora     L0086,y
        inc     a
        tcs
        trb     @w L0086
        ora     @w L0086,x
        asl     @w L0086,x
        ora     @l L0089,x
        jsr     L0086
        and     (L0080,x)
        jsl     L0089
        and     $80,s
        bit     L0080
        and     L0080
        rol     L0080
        and     [L0080]
        plp
        and     #$80
        rol     a
        pld
        bit     @w L0086
        and     @w L0086
        rol     @w L0086
        and     @l L0089
        bmi     _L1089
_L1089  and     (L0080),y
        and     (L0080)
        and     ($80,s),y
        bit     L0080,x
        and     L0080,x
        rol     L0080,x
        and     [L0080],y
        sec
        and     L0086,y
        dec     a
        tsc
        bit     @w L0086,x
        and     @w L0086,x
        rol     @w L0086,x
        and     @l L0089,x
        rti

L10AB   eor     (L0080,x)
        .byte   $42,$80
        eor     $80,s
        mvp     #$84,#$83
        eor     L0080
        lsr     L0080
        eor     [L0080]
        pha
        eor     #$80
        lsr     a
        phk
        jmp     _L10C2

_L10C2  eor     @w L0086
        lsr     @w L0086
        eor     @l L0089
        bvc     _L10CE
_L10CE  eor     (L0080),y
        eor     (L0080)
        eor     ($80,s),y
        mvn     #$84,#$83
        eor     L0080,x
        lsr     L0080,x
        eor     [L0080],y
        cli
        eor     L0086,y
        phy
        tcd
        jml     _L10E7

_L10E7  eor     @w L0086,x
        lsr     @w L0086,x
        eor     @l L0089,x
        rts

L10F2   adc     (L0080,x)
        per     $0ff6
        adc     $80,s
        stz     L0080
        adc     L0080
        ror     L0080
        adc     [L0080]
        pla
        adc     #$80
        ror     a
        rtl

L1106   jmp     (L0086)

L1109   adc     @w L0086
        ror     @w L0086
        adc     @l L0089
        bvs     _L1115
_L1115  adc     (L0080),y
        adc     (L0080)
        adc     ($80,s),y
        stz     L0080,x
        adc     L0080,x
        ror     L0080,x
        adc     [L0080],y
        sei
        adc     L0086,y
        ply
        tdc
        jmp     (L0086,x)

L112C   adc     @w L0086,x
        ror     @w L0086,x
        adc     @l L0089,x
        bra     _L1138

_L1138  sta     (L0080,x)
        brl     _L113D

_L113D  sta     $80,s
        sty     L0080
        sta     L0080
        stx     L0080
        sta     [L0080]
        dey
        bit     #$80
        txa
        phb
        sty     @w L0086
        sta     @w L0086
        stx     @w L0086
        sta     @l L0089
        bcc     _L115B
_L115B  sta     (L0080),y
        sta     (L0080)
        sta     ($80,s),y
        sty     L0080,x
        sta     L0080,x
        stx     L0080,y
        sta     [L0080],y
        tya
        sta     L0086,y
        txs
        txy
        stz     @w L0086
        sta     @w L0086,x
        stz     @w L0086,x
        sta     @l L0089,x
        ldy     #$80
        lda     (L0080,x)
        ldx     #$80
        lda     $80,s
        ldy     L0080
        lda     L0080
        ldx     L0080
        lda     [L0080]
        tay
        lda     #$80
        tax
        plb
        ldy     @w L0086
        lda     @w L0086
        ldx     @w L0086
        lda     @l L0089
        bcs     _L11A0
_L11A0  lda     (L0080),y
        lda     (L0080)
        lda     ($80,s),y
        ldy     L0080,x
        lda     L0080,x
        ldx     L0080,y
        lda     [L0080],y
        clv
        lda     L0086,y
        tsx
        tyx
        ldy     @w L0086,x
        lda     @w L0086,x
        ldx     @w L0086,y
        lda     @l L0089,x
        cpy     #$80
        cmp     (L0080,x)
        rep     #$00
        cmp     $80,s
        cpy     L0080
        cmp     L0080
        dec     L0080
        cmp     [L0080]
        iny
        cmp     #$80
        dex
        wai
        cpy     @w L0086
        cmp     @w L0086
        dec     @w L0086
        cmp     @l L0089
        bne     _L11E5
_L11E5  cmp     (L0080),y
        cmp     (L0080)
        cmp     ($80,s),y
        pei     (L0080)
        cmp     L0080,x
        dec     L0080,x
        cmp     [L0080],y
        cld
        cmp     L0086,y
        phx
        stp

L11F9   jml     [L0086]

L11FC   cmp     @w L0086,x
        dec     @w L0086,x
        cmp     @l L0089,x
        cpx     #$80
        sbc     (L0080,x)
        sep     #$00
        sbc     $80,s
        cpx     L0080
        sbc     L0080
        inc     L0080
        sbc     [L0080]
        inx
        sbc     #$80
        nop
        xba
        cpx     @w L0086
        sbc     @w L0086
        inc     @w L0086
        sbc     @l L0089
        beq     _L122A
_L122A  sbc     (L0080),y
        sbc     (L0080)
        sbc     ($80,s),y
        pea     $0086
        sbc     L0080,x
        inc     L0080,x
        sbc     [L0080],y
        sed
        sbc     L0086,y
        plx
        xce
        jsr     (L0086,x)
        sbc     @w L0086,x
        inc     @w L0086,x
        sbc     @l L0089,x
        .logical $0080
L0080   bit     _L0082
_L0082  bit     _L0082
        bit     _L0082
L0086   bit     @w L0086
L0089   lda     @l L0089
        .here
