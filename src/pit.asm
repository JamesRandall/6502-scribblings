
\ gets the block color from the pit from the gridx and gridy memory
\ locations
.getpitblock
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
