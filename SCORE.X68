*-----------------------------------------------------------
* SCORE MANAGEMENT
*-----------------------------------------------------------
SCOINIT     CLR.W   (MINPOSY)
            CLR.W   (MAXPOSY)
            CLR.W   (PREVMIN)
            CLR.W   (SCOPASS)
            RTS

SCOUPD      MOVEM.L D0-D1,-(A7)
            MOVE.W  (MINPOSY),D0
            CMP.W   (PREVMIN),D0
            BGE     .NOINCR
            MOVE.W  (SCOPASS),D1
            ADDQ.W  #1,D1
            MOVE.W  D1,(SCOPASS)
.NOINCR     MOVE.W  D0,(PREVMIN)
            MOVEM.L (A7)+,D0-D1
            RTS

SCOPLOT     
            MOVEM.L D0-D1/A1,-(A7)
            
            ; SET BACKGROUND COLOR
            MOVE.B  #81,D0
            MOVE.L  #0,D1
            TRAP    #15
            
            ; SET FIRST LINE POSITION
            MOVE.B  #11,D0
            MOVE.W  #SCOPOS,D1
            TRAP    #15

            ; PRINT LINE
            LEA     .TXT,A1
            CLR.L   D1
            MOVE.W  (SCOPASS),D1
            MOVE.B  #17,D0
            TRAP    #15
            MOVEM.L (A7)+,D0-D1/A1
            RTS
            
.TXT        DC.B    'SCORE :', 0

*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~

*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
