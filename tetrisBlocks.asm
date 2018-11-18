\ Simple example illustrating use of BeebAsm

mode2linesize = &280
oswrch = &FFEE
osasci = &FFE3
blockaddr = &70
xscratch = blockaddr+2
yscratch = xscratch+1

ORG &2000         ; code origin (like P%=&2000)

.start
    JSR mode2
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
{
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
}
    

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
{
    \ go to the top left
    LDA #&00:STA blockaddr
    LDA #&30:STA blockaddr+1
    STY yscratch
    STX xscratch
    LDY #0
    CPY xscratch
    BEQ rowposition
.columnloop
    LDA blockaddr
    ADC #&10
    STA blockaddr
    BCC blockaddresscolumnloopinc
    INC blockaddr+1
.blockaddresscolumnloopinc
    INY
    CPY xscratch
    BNE columnloop
.rowposition
    CLC
    LDX #0
    CPX yscratch
    BEQ anddone
.rowloop
    LDA blockaddr
    ADC #mode2linesize MOD 256
    STA blockaddr
    LDA blockaddr + 1
    ADC #mode2linesize DIV 256
    STA blockaddr + 1
    INX
    CPX yscratch
    BNE rowloop
.anddone
    RTS
}

.end

SAVE "Main", start, end