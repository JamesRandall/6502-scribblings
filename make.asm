oswrch = &FFEE
osasci = &FFE3
osbyte = &FFF4
blockaddr = &70
xscratch = blockaddr+2
yscratch = xscratch+1
gridx = &1800
gridy = &1801
currentshapex = &1802
currentshapey = &1803
framecounter = &1804
pitredrawneeded = &1805

ORG &2000         ; code origin (like P%=&2000)

\ startup code - order is important
INCLUDE "src\init.asm"
INCLUDE "src\gameLoop.asm"

\ sub routines - order unimportant
INCLUDE "src\tetrisBlocks.asm"
INCLUDE "src\utils.asm"

.end
SAVE "Main", start, end