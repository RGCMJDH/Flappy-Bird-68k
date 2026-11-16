*-----------------------------------------------------------
* PIPE MANAGEMENT
* PIPPOSX (W)  (A0)
* PIPPOSY (W) 2(A0) - POSITION OF THE TOP PIPE
*-----------------------------------------------------------
PIPINITALL  MOVEM.L D0-D1/A0,-(A7)
            MOVE.W  #PIPNUM-1,D0
.LOOP       JSR     PIPINIT
            MOVE.W  D0,D1
            MULU.W  #PIPXGAP,D1
            ADD.W   (A0),D1
            MOVE.W  D1,(A0)
            ADD.L   #4,A0
            DBRA.W  D0,.LOOP
            MOVEM.L (A7)+,D0-D1/A0
            RTS

PIPINIT
            MOVEM.L D0,-(A7)
            JSR     UTLRAND
            MULU.W  #FLRPOSY-HOLHEIGH-2*PIPHEAD,D0
            LSR.L   #8,D0                   ; DIVIDE D0/256
            ADD.W   #PIPHEAD,D0
            MOVE.W  #SCRWIDTH,(A0)          ; SET INITIAL X POSITION
            MOVE.W  D0,2(A0)                ; SET INITIAL Y POSITION
            MOVEM.L (A7)+,D0
            RTS

PIPUPDALL   MOVEM.L D0-D1/A0,-(A7)
            CLR.W   (MINPOSY)
            MOVE.W  #FLRPOSY-BRDHEIGH,(MAXPOSY)
            MOVE.W  #PIPNUM-1,D0
.LOOP       JSR     PIPUPD
            ADD.L   #4,A0
            DBRA.W  D0,.LOOP
            MOVEM.L (A7)+,D0-D1/A0
            RTS

PIPUPD
            MOVEM.L D0,-(A7)
            MOVE.W  (A0),D0                 ; X POSITION
            SUB.W   #PIPXSPD,D0            
            MOVE.W  D0,(A0)
            
            ; CHECK IF THE PIPE IS OUT OF BOUNDS
            ADD.W   #PIPXGAP*PIPNUM-SCRWIDTH,D0
            BNE     .NOSPAWN
            JSR     PIPINIT
            
.NOSPAWN    MOVE.W  (A0),D0
            SUB.W   (BRDPOSX),D0
            ADD.W   #PIPWIDTH,D0
            BMI.W   .RET
            SUB.W   #BRDWIDTH+PIPWIDTH,D0
            BLO.W   .UPDCOL

.RET        MOVEM.L (A7)+,D0
            RTS
            
; UPDATE COLLISION DETECTION VARIABLES
.UPDCOL     MOVE.W  2(A0),D0
            MOVE.W  D0,(MINPOSY)
            ADD.W   #HOLHEIGH-BRDHEIGH,D0
            MOVE.W  D0,(MAXPOSY)
            BRA     .RET

PIPPLOTALL  MOVEM.L D0-D4/A0,-(A7)

            ;PAINT FLOOR
                        
            ; SET PEN COLOR
            MOVE.B  #80,D0
            MOVE.L  #PIPFILCL,D1
            TRAP    #15
            
            ; SET FILL COLOR
            MOVE.B  #81,D0
            MOVE.L  #PIPFILCL,D1
            TRAP    #15
            
            CLR.W   D1
            MOVE.W  #FLRPOSY,D2
            MOVE.W  #SCRWIDTH,D3
            MOVE.W  #SCRHEIGH,D4
            MOVE.B  #87,D0
            TRAP    #15

            MOVE.W  #PIPNUM-1,D0
.LOOP       JSR     PIPPLOT
            ADD.L   #4,A0
            DBRA.W  D0,.LOOP
            MOVEM.L (A7)+,D0-D4/A0
            RTS
            
PIPPLOT
            MOVEM.L D0-D4,-(A7)
            
            ; SET PEN COLOR
            MOVE.B  #80,D0
            MOVE.L  #PIPPENCL,D1
            TRAP    #15
            
            ; SET FILL COLOR
            MOVE.B  #81,D0
            MOVE.L  #PIPFILCL,D1
            TRAP    #15
            
            ; PLOT UPPER PIPE HEAD
            MOVE.W  (A0),D1                 ; X0
            MOVE.W  2(A0),D4                ; Y1
            MOVE.W  D4,D2
            SUB.W   #PIPHEAD,D2
            MOVE.W  D1,D3
            ADD.W   #PIPWIDTH,D3
            MOVE.B  #87,D0
            TRAP    #15
            
            ; PLOT UPPER PIPE BODY
            MOVE.W  D2,D4
            MOVE.W  #-1,D2
            ADD.W   #PIPHEDOFS,D1
            SUB.W   #PIPHEDOFS,D3
            TRAP    #15
            
            ; PLOT LOWER PIPE BODY
            MOVE.W  D4,D2
            MOVE.W  #FLRPOSY-1,D4
            ADD.W   #HOLHEIGH+2*PIPHEAD,D2
            TRAP    #15
            
            ; PLOT LOWER PIPE HEAD
            SUB.W   #PIPHEDOFS,D1
            ADD.W   #PIPHEDOFS,D3
            MOVE.W  D2,D4
            SUB.W   #PIPHEAD,D2
            TRAP    #15
            
            MOVEM.L (A7)+,D0-D4
            RTS






*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
