            INCLUDE "IMGDATA.X68"

IMGPLT      MOVEM.L D0-D3/A0,-(A7)
            LEA.L   IMGDAT,A0
            MOVE.W  #IMGPOSY-1,D2           ; Y COORDINATE
.NEWROW     MOVE.W  #IMGPOSX-1,D3           ; X COORDINATE
            ADDQ.W  #1,D2
            CMP.W   #IMGHEIGH+IMGPOSY,D2
            BGE     .DONE
            
.LOOP       ADDQ.W  #1,D3
            CMP.W   #IMGWIDTH+IMGPOSX,D3
            BGE     .NEWROW

            ; LOAD COLOR
            MOVE.L  (A0)+,D1
            MOVE.L  D1,D0
            AND.L    #$FF000000,D0
            BNE     .LOOP                   ; PIXEL IS TRANSPARENT
            
            ; SET PEN COLOR
            MOVE.B  #80,D0
            TRAP    #15
            
            ; DRAW PIXEL
            MOVE.W  D3,D1
            ADDQ.B  #2,D0
            TRAP    #15
            
            BRA     .LOOP
            
.DONE       MOVEM.L (A7)+,D0-D3/A0
            RTS


*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
