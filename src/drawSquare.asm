\ Simple example illustrating use of BeebAsm

mode2linesize = &280

\ draw the current block using the colour in the accumulator at position in memory
\ locations gridx, gridy
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

    \ tetris grid is 10 wide, 22 deep and our blocks are 4 pixels wide and 8 pixels deep
    \ mode 2 is 160x256 resolution.
    \ when this is called x and y should contain co-ordinate of block
    \ we then
    \ 1. start at the top left
    \ 2. for each row we add on &ff, &ff, &80
    .calculateblockaddress
    {
        \ go to the top left of screen memory
        LDA #&00:STA blockaddr
        LDA #&30:STA blockaddr+1
        LDY #0
        CPY gridx
        BEQ rowposition
        \ for each column move us across by adding 16 bytes to our screen address (one of our blocks is 16 bytes wide)
    .columnloop
        CLC
        LDA blockaddr
        ADC #&10
        STA blockaddr
        BCC carryflagclear
        INC blockaddr+1
    .carryflagclear
        INY
        CPY gridx
        BNE columnloop
        \ for each row add on &280 bytes - the size of a mode 2 line
    .rowposition
        CLC
        LDX #0
        CPX gridy
        BEQ done
    .rowloop
        LDA blockaddr
        ADC #mode2linesize MOD 256
        STA blockaddr
        LDA blockaddr + 1
        ADC #mode2linesize DIV 256
        STA blockaddr + 1
        INX
        CPX gridy
        BNE rowloop
    .done
        RTS
    }
}

\ mode 2 solid colors in 2 pixel pairs
\ 0000  0
\ 0001  1
\ 0010  2
\ 0011  3
\ 0100  4
\ 0101  5
\ 0110  6
\ 0111  7
\ 
\ 00000000  0
\ 00000011  3
\ 00001100  12
\ 00001111  15
\ 00110000  48
\ 00110011  51
\ 00111100  60
\ 00111111  63

.blockcolors EQUB 3, 12, 15, 48, 51, 60, 63
