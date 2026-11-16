*-----------------------------------------------------------
* GAME BACKGROUND LOGIC
*-----------------------------------------------------------

; INICIALIZE BACKGROUND
BGINIT      CLR.W   (BGPOSX)
            RTS

BGUPD       MOVEM.L D0,-(A7)
            MOVE.W  (BGPOSX),D0
            ADD.W   #BGVEL,D0
            DIVU    #BGLEN,D0               ; CALCULATE MODULUS OF
            SWAP    D0                      ; D0 / BGLEN
.DONE       MOVE.W  D0,(BGPOSX)
            MOVEM.L (A7)+,D0
            RTS

BGPLT       MOVEM.L D0-D7/A0,-(A7)
            
            ; SET SKY FILL COLOR
            MOVE.W  #81,D0
            MOVE.L  #BGSKY,D1
            TRAP    #15
            
            ; FLOOD FILL BG WITH SKY COLOR
            MOVE.W  #89,D0
            CLR.W   D1
            CLR.W   D2
            TRAP    #15
            
            ; SET CLOUD PEN COLOR
            MOVE.W  #80,D0
            MOVE.L  #BGCLDCOL,D1
            TRAP    #15     
            
            ; SET CLOUD FILL COLOR
            ADDQ.W  #1,D0
            TRAP    #15
            
            ; PLOT CLOUDS
            ; (D5,D6): CENTER
            ; D7: RADIUS
            
            MOVE.W  #-BGLEN,D5
            SUB.W   (BGPOSX),D5
.RESET      LEA.L   .CLOUDS,A0              ; REPEAT THE CLOUD CYCLE
.LOOP       ADD.W   (A0)+,D5
            MOVE.W  (A0)+,D6
            MOVE.W  (A0)+,D7
            BEQ     .RESET                  ; RESET THE CYCLE WHEN DETECTING A CLOUD WITH RADIUS 0
            
            ; PLOT CLOUD ECLIPSE
            MOVE.W  #88,D0
            MOVE.W  D5,D1
            MOVE.W  D6,D2
            MOVE.W  D5,D3
            MOVE.W  D6,D4
            SUB.W   D7,D1
            SUB.W   D7,D2
            ADD.W   D7,D3
            ADD.W   D7,D4
            TRAP    #15
            
            CMP.W   #SCRWIDTH+BGLEN,D5
            BLT     .LOOP
            
            ; FILL BOTTOM PART OF SCREEN
            MOVE.W  #89,D0
            CLR.W   D1
            MOVE.W  #SCRHEIGH-1,D2
            TRAP    #15
            
            MOVEM.L (A7)+,D0-D7/A0
            RTS
            
.CLOUDS     DC.W    0,300,32
            DC.W    48,290,32
            DC.W    40,310,32
            DC.W    40,0,0

*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
