; ==============================================================================
; BIRD RELATED
; ==============================================================================
            
; ------------------------------------------------------------------------------
BRDINIT
; INITIALIZE BIRD.
; ------------------------------------------------------------------------------
            MOVE.W  #SCRWIDTH/4,(BRDPOSX)
            MOVE.W  #SCRHEIGH/2,(BRDPOSY)
            MOVE.W  #0, (BRDVELY)
            RTS

BRDUPD
            MOVEM.L D0-D1, -(A7)
            MOVE.W  (BRDPOSY),D0
            MOVE.W  (BRDVELY),D1
            ADD.W   #BRDGRV,D1
            CMP.W   #BRDMAXVELY,D1
            BLE     .NOVELCAP
            MOVE.W  #BRDMAXVELY,D1
.NOVELCAP   BTST.B  #0,(KBDEDGE)
            BEQ     .NOJUMP
            MOVE.W  #BRDJMPVEL,D1
            MOVE.L  #0,D7
            TRAP    #SNDPLTN
.NOJUMP     ADD.W   D1,D0
            MOVE.W  D1,(BRDVELY)
            CMP.W   #FLRPOSY,D0
            BLE     .NOPOSCAP
            MOVE.W  #FLRPOSY,D0
.NOPOSCAP   MOVE.W  D0,(BRDPOSY)
            
            ; CHECK COLLISIONS
            CMP.W   (MINPOSY),D0
            BLO     .COL
            CMP.W   (MAXPOSY),D0
            BHI     .COL
            BRA     .NOCOL
.COL        MOVE.W  #1,(STANEXT)
.NOCOL      MOVEM.L (A7)+, D0-D1
            RTS
            
.JUMP       
            RTS

; ------------------------------------------------------------------------------
BRDPLOT
            MOVEM.L D0-D4, -(A7)
            MOVE.B  #80, D0
            MOVE.L  #BRDCOL, D1
            TRAP    #15                     ; SET PEN COLOR
            ADDQ.B  #1, D0
            TRAP    #15                     ; SET FILL COLOR
            MOVE.W  (BRDPOSX),D1
            MOVE.W  (BRDPOSY),D2
            MOVE.W  D1, D3
            MOVE.W  D2, D4
            ADD.W   #BRDWIDTH, D3
            ADD.W   #BRDHEIGH, D4
            MOVE.B  #87, D0
            TRAP    #15
            
            MOVEM.L (A7)+, D0-D4
            RTS




*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
