
    LDA #0
    STA blockcolorindex
    
.gameloop
    LDX blockcolorindex
    LDA blockcolors, X
    STA blockcolor
    LDX #0
    LDY #0
    STX gridx
    STY gridy
{
    .rowloop
        .columnloop
            LDA blockcolor
            JSR drawblock

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
        BEQ updatecolor
        STY gridy
        LDX #0
        STX gridx
        JMP rowloop
    .updatecolor
        LDX blockcolorindex
        INX
        CPX #7
        BNE saveupdatedcolorindex
        LDX #0        
    .saveupdatedcolorindex
        STX blockcolorindex
}
    JMP gameloop
