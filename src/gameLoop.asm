    LDX #0
    LDY #0
    STX currentshapex
    STY currentshapey
    LDA #1
    STA pitredrawneeded

.gameloop
    JSR fx19 \ wait for v sync, 50 times a second
    LDA pitredrawneeded
    CMP #1
    BNE skippitredraw
    LDA #0
    STA pitredrawneeded
    STA gridx
    STA gridy
{
    .rowloop
        .columnloop
            JSR getblockcolor
            CMP #0
            BEQ skipdrawingblock
            LDX gridx
            LDY gridy
            JSR drawblock
        .skipdrawingblock
            LDX gridx
            INX            
            CPX #10
            BEQ columnloopdone
            STX gridx
            LDY gridy
            JMP columnloop
    .columnloopdone
        LDY gridy
        INY
        CPY #22
        BEQ pitrenderingcomplete
        STY gridy
        LDX #0
        STX gridx
        JMP rowloop
    .pitrenderingcomplete
}
.skippitredraw
    JSR erasecurrentshape
    JSR updateframe
    JSR drawcurrentshape
    JMP gameloop

.updateframe
{
    INC framecounter
    LDA framecounter
    CMP #25 \ 0.5 second
    BNE skipframeupdate
    LDA #0
    STA framecounter
    INC currentshapey
.skipframeupdate
    RTS
}


\ gets the block color from the pit from the gridx and gridy memory
\ locations
.getblockcolor
{
    CLC
    LDA #0
    LDY #0
    .rows        
        CPY gridy
        BEQ columns
        ADC #10
        INY
        JMP rows
    .columns
        CLC
        ADC gridx
        TAX
        LDA pit,X
    RTS
}

\ draws the shape at the current position
.drawcurrentshape
{
    LDX currentshapex
    LDY currentshapey
    STX gridx
    STY gridy
    LDA #0
    STA currentshapeoffset
    .columninner
        LDX currentshapeoffset
        LDA currentshape,X
        CMP #0
        BEQ skipdrawingblock
        JSR drawblock
    .skipdrawingblock
        INC currentshapeoffset
        LDX currentshapeoffset
        CPX #4
        BEQ incrow
        CPX #8
        BEQ incrow
        CPX #12
        BEQ incrow
        CPX #16
        BEQ donecurrentshape            
        INC gridx
        JMP columninner
    .incrow
        INC gridy
        LDY currentshapex
        STY gridx
        JMP columninner
    .donecurrentshape
    RTS
}

\ will erase the shape at the current position
.erasecurrentshape
{
    LDX currentshapex
    LDY currentshapey
    STX gridx
    STY gridy
    LDA #0
    STA currentshapeoffset
    .columninner
        LDX currentshapeoffset
        LDA currentshape,X
        CMP #0
        BEQ skiperasingblock
        LDA #0
        JSR drawblock
    .skiperasingblock
        INC currentshapeoffset
        LDX currentshapeoffset
        CPX #4
        BEQ incrow
        CPX #8
        BEQ incrow
        CPX #11
        BEQ incrow
        CPX #16
        BEQ donecurrentshape            
        INC gridx
        JMP columninner
    .incrow
        INC gridy
        LDY currentshapex
        STY gridx
        JMP columninner
    .donecurrentshape
    RTS
}

.currentshapeoffset EQUB 0
\ represents the current in play shape
.currentshape
    EQUB 0, 3, 0, 0
    EQUB 3, 3, 3, 0
    EQUB 0, 0, 0, 0
    EQUB 0, 0, 0, 0

\ a bit wasteful but its easy
.pit
    EQUB 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    EQUB 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    EQUB 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    EQUB 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    EQUB 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    EQUB 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    EQUB 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    EQUB 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    EQUB 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    EQUB 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    EQUB 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    EQUB 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    EQUB 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    EQUB 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    EQUB 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    EQUB 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    EQUB 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    EQUB 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    EQUB 12, 0, 0, 0, 0, 0, 0, 0, 0, 0
    EQUB 12, 12, 0, 0, 0, 0, 0, 0, 0, 0
    EQUB 12, 3, 0, 0, 0, 0, 0, 0, 0, 0
    EQUB 3, 3, 3, 0, 0, 0, 51, 51, 51, 51
