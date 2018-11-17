\ Simple example illustrating use of BeebAsm

oswrch = &FFEE
osasci = &FFE3
blockaddr = &70
xscratch = blockaddr+2
yscratch = xscratch+1

ORG &2000         ; code origin (like P%=&2000)

.start
    JSR mode2
    \LDA #screen MOD 256:STA addr
    \LDA #screen DIV 256:STA addr+1
.renderloop
    LDA #3
    LDX #2
    LDY #2
    JSR drawblock

    LDA #3
    LDX #3
    LDY #2
    JSR drawblock

    LDA #3
    LDX #4
    LDY #2
    JSR drawblock

    LDA #3
    LDX #3
    LDY #3
    JSR drawblock

    JMP renderloop

    \ x - gridx, y - gridy, a - colour
.drawblock
    PHA
    JSR calculateblockaddress
    PLA
    LDY #0    
.loop
    STA (blockaddr),Y
    INY
    CPY #16
    BNE loop
.finished
    RTS
    

.mode2
    LDA #22:JSR oswrch
    LDA #2:JSR oswrch
    RTS

\ tetris grid is 10 wide, 22 deep and our blocks are 4 pixels wide and 8 pixels deep
\ mode 2 is 160x256 resolution.
\ when this is called x and y should contain co-ordinate of block
\ we then
\ 1. start at the top left
\ 2. for each row we add on &ff, &ff, &80
.calculateblockaddress 
    \ go to the top left
    LDA #&00:STA blockaddr
    LDA #&30:STA blockaddr+1
    STY yscratch
    STX xscratch
    LDY #0
    CPY xscratch
    BEQ blockaddressrowloopouter
.blockaddresscolumnloop
    LDA blockaddr
    ADC #&10
    STA blockaddr
    BCC blockaddresscolumnloopinc
    INC blockaddr+1
.blockaddresscolumnloopinc
    INY
    CPY xscratch
    BNE blockaddresscolumnloop
.blockaddressrowloopouter
    LDX #0
    CPX yscratch
    BEQ anddone
.blockaddresscolumnloopinner
    LDA blockaddr
    ADC #&FF
    BCC skip1
    INC blockaddr+1
.skip1
    ADC #&FF
    BCC skip2
    INC blockaddr+1
.skip2
    ADC #&80
    BCC skip3
    INC blockaddr+1
.skip3
    STA blockaddr
    INX
    CPX yscratch
    BNE blockaddresscolumnloopinner
.anddone
    RTS

.red EQUB 255
.end

SAVE "Main", start, end