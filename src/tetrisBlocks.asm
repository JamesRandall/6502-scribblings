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