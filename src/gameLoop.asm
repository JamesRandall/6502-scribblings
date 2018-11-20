    \ set up a new game loop by positioning a shape at the top of the pit
    LDX #0
    LDY #0
    STX currentshapex
    STY currentshapey
    \ we only redraw the whole pit if needed as its expensive but on first
    \ run through of the game loop we do draw it - this lets us see any diagnostic
    \ pit data (i.e. a preset pit)
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
            \ we only draw a block if it is non-zero i.e. their is a block in this pit location
            JSR getpitblock
            CMP #0
            BEQ movetonextpitlocation
            \ if its non zero then we draw the pit block
            LDX gridx
            LDY gridy
            JSR drawblock
        .movetonextpitlocation
            \ we move across the x axis first
            LDX gridx
            INX            
            CPX #10 \ when we get to the 10th column we've done on the row so move to the next row
            BEQ movetonextpitrow
            STX gridx
            LDY gridy
            JMP columnloop
    .movetonextpitrow
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
\ after (optionally) drawing the pit we update the current in play shape
.skippitredraw
    JSR erasecurrentshape
    JSR updateframe
    JSR drawcurrentshape
    JMP gameloop

\ update the position of the in play object if required - we use the v-sync (frame) counter
\ to time things
.updateframe
{
    INC framecounter
    LDA framecounter
    CMP #25 
    BNE skipframeupdate \ if we've not done 25 frames (0.5 second) then their nothing to update
    \ ever 0.5 second we set the counter back to zero 
    LDA #0
    STA framecounter
    INC currentshapey
.skipframeupdate
    RTS
}

