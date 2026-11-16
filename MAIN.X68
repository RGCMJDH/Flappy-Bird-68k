; PRACTICA TONI FUENTES Y ALBERTO GALLEGO 
; ==============================================================================

            ORG     $1000

            INCLUDE "SYSCONST.X68"
            INCLUDE "CONST.X68"
            INCLUDE "LIB/DMMCONST.X68"
            INCLUDE "LIB/UTLCONST.X68"
            INCLUDE "LIB/DMMCODE.X68"
            INCLUDE "LIB/AGLCODE.X68"
            INCLUDE "LIB/UTLCODE.X68"
            
SCRTRAP     EQU     1                       ; SCREEN REFRESH TRAP

            ORG     $1000    
            INCLUDE "SYSVAR.X68"
            INCLUDE "VARS.X68"
            INCLUDE "LIB/DMMVARS.X68"
            INCLUDE "LIB/UTLVARS.X68"

            INCLUDE "SYSTEM.X68"
            INCLUDE "BACKGROUND.X68"
            INCLUDE "IMAGE.X68"
            INCLUDE "BIRD.X68"
            INCLUDE "PIPE.X68"
            INCLUDE "SCORE.X68"
            INCLUDE "GAME.X68"
            INCLUDE "GOVER.X68"
            INCLUDE "STATES.X68"
            
START:
            ORI.W   #$0700, SR              ; DISABLE INTERRUPTIONS
            JSR     SYSINIT
            JSR     SNDINIT
            JSR     UTLINIT
            JSR     STAINIT

.LOOP

; UPDATE
            CLR.B   D0

            ; READ INPUT DEVICES
            ; TRAP    #KBDTRAP
            
            CLR.B   D0

            JSR     STAUPD

            ; UPDATE GAME LOGIC
            ;LEA     PIPES,A1
            ;JSR     PIPUPDALL
            ;JSR     BRDUPD
            ;JSR     SCOUPD
            ;RTS


; SYNC
.WINT       TST.B   (SCRINTCT)
            ADDQ.B #1, D6
            MOVE.B (SCRINTCT),D5
            BEQ     .WINT

            CLR.B   (SCRINTCT)
 
            JSR     STAPLOT
            
            TRAP    #SCRTRAP
            
            BRA     .LOOP


STOP        
            SIMHALT

    
            END    START        















*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
