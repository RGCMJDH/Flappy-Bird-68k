*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
            ; INCLUDE "CONST.X68"

SYSINIT
            MOVE.L  (A7)+, A0               ; GET RETURN ADDRESS
            ;JSR     DMMINIT                 ; INIT DYNAMIC MEMORY
            JSR     KBDINIT                 ; INIT KEYBOARD
            JSR     SCRINIT                 ; INIT SCREEN
            ANDI.W  #$DFFF, SR              ; SWITCH TO USER
            MOVE.L  A0, -(A7)               ; PUT RETURN ADDRESS
            RTS

SCRINIT

            MOVE.L  #SCRTRAP, D0
            MOVE.L  #SCRUPD, ($80+4*SCRTRAP)
            
            ; SET RESOLUTION
            MOVE.L  #SCRWIDTH<<16|SCRHEIGH, D1
            MOVE.B  #33, D0
            TRAP    #15
            
            ; SET WINDOWED MODE
            MOVE.L  #1, D1
            TRAP    #15
            
            ; CLEAR VISIBLE BUFFER
            MOVE.W  #$FF00, D1
            MOVE.B  #11, D0
            TRAP    #15
            
            ; ENABLE DOUBLE BUFFER
            MOVE.B  #17, D1
            MOVE.B  #92, D0
            TRAP    #15
            
            ; SET EXCETPION VECTOR & ENABLE EXCEPTION PROCESSING
            MOVE.L  #SCRISR, ($60+SCRIRQ*4)
            MOVE.B  #5, D1
            MOVE.B  #32, d0
            TRAP    #15
            
            ; ENABLE AUTO-IRQ
            MOVE.B  #%10000000|SCRIRQ,D2
            MOVE.B  #SCRTIM,D3
            MOVE.B  #6,D1
            MOVE.B  #32,D0
            TRAP    #15
            
            CLR.B   (SCRINTCT)              ; PREPARE INTERRUPT FLAG
            CLR.B   (SCRCYCCT)              ; PREPARE CYCLE COUNTER
            ANDI.W  #$F8FF,SR               ; ENABLE INTS
            RTS
            

SCRISR
            ADDQ.B  #1, (SCRINTCT)
            ADDQ.B  #1, (SCRCYCCT)
            RTE

SCRUPD
            MOVEM.L D0-D1,-(A7)
            
            ; SWITCH BUFFERS
            MOVEQ   #94,D0
            TRAP    #15
            
            ; CLEAR HIDDEN BUFFER
            MOVEQ   #11,D0
            MOVE.W  #$FF00,D1
            TRAP    #15
            
            MOVEM.L (A7)+,D0-D1
            RTE

; ------------------------------------------------------------------------------
SNDINIT
; SOUND SYSTEM INIT
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L D0-D1/A0-A1,-(A7)
            MOVE.L  #SNDPLAY,($80+SNDPLTN*4)
            CLR.B   D1
            LEA     .SNDLIST,A0
.LOOP       MOVE.L  (A0)+,D0
            BEQ     .DONE
            MOVE.L  D0,A1
            MOVE.B  #71,D0
            TRAP    #15
            ADDQ.B  #1,D1
            BRA     .LOOP
.DONE       MOVEM.L (A7)+,D0-D1/A0-A1
            RTS
.SNDJUMP    DC.B    'SND/JUMP.wav',0
.SNDMAIN    DC.B    'SND/MAIN.wav',0
.SNDLIST    DC.L    .SNDJUMP,.SNDMAIN,0
            
; ------------------------------------------------------------------------------
SNDPLAY
; PLAY SOUND
; INPUT    : D7 SOUND ID
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.W D0-D1,-(A7)
            MOVE.B  #72,D0
            MOVE.B  D7,D1
            TRAP    #15
            MOVEM.W (A7)+,D0-D1
            RTE

; ------------------------

KBDINIT
            CLR.B   (KBDVAL)                 ; INIT VARS
            CLR.B   (KBDEDGE)
            MOVE.L  #KBDREAD,($80+KBDTRAP*4) ; INSTALL
            RTS
; ------------------------------------------------------------------------------
KBDREAD
; UPDATE KEYBOARD INFO
; 1 -> PAUSE
; 0 -> SPACE
; ------------------------------------------------------------------------------
            MOVEM.L D0-D3, -(A7)
            MOVE.B  #19, D0
            MOVE.L  #KBDPAUSE<<8|KBDSPACE,D1
            TRAP #15
            
            JSR     .STORE                  ; CONVERT TO DESIRED FORMAT
            
            ; COMPUTE KBDEDGE
            MOVE.B  (KBDVAL),D0
            NOT.B   D0
            AND.B   D2,D0
            MOVE.B  D0,(KBDEDGE)
            
            MOVE.B  D2,(KBDVAL)             ; STORE KBDVAL
            
            MOVEM.L (A7)+,D0-D3
            RTE

.STORE      MOVE.W  #3, D3
.LOOP       LSL.L   #8, D1
            ROXL.B  #1, D2
            DBRA.W  D3, .LOOP
            RTS
















*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
