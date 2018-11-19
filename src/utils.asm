.mode2
    LDA #22:JSR oswrch
    LDA #2:JSR oswrch
    RTS

.hidecursor
    LDA #23:JSR oswrch
    LDA #1:JSR oswrch
    LDA #0:JSR oswrch
    LDA #0:JSR oswrch
    LDA #0:JSR oswrch
    LDA #0:JSR oswrch
    LDA #0:JSR oswrch
    LDA #0:JSR oswrch
    LDA #0:JSR oswrch
    LDA #0:JSR oswrch
    RTS

\ wait for v sync
.fx19
    LDA #19:JMP osbyte