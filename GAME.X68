*-----------------------------------------------------------
* GAME LOGIC
*-----------------------------------------------------------

GAMINIT     MOVEM.L A0,-(A7)
            CLR.W   (GAMSTATE)
            JSR     BGINIT
            JSR     BRDINIT
            JSR     SCOINIT
            LEA     PIPES,A0
            JSR     PIPINITALL
            MOVEM.L (A7)+,A0
            RTS
            
GAMUPD      
            TRAP    #KBDTRAP
            ; UPDATE GAME LOGIC
            MOVEM.L D0/A0,-(A7)
            
            ; UPDATE GAME PAUSED STATE
            BTST.B  #0,(KBDEDGE)
            BEQ     .PAUSETST
            MOVE.B  (GAMSTATE),D0
            ORI.B   #2,D0
            MOVE.B  D0,(GAMSTATE)

.PAUSETST   BTST.B  #1,(GAMSTATE)
            BEQ     .UPDATE
            BTST.B  #1,(KBDEDGE)
            BEQ     .UPDATE
            MOVE.B  (GAMSTATE),D0
            EORI.B   #1,D0                   ; TOGGLE PAUSE STATE
            MOVE.B  D0,(GAMSTATE)
            
.UPDATE     BTST.B  #0,(GAMSTATE)
            BNE     .DONE
            JSR     BGUPD
            BTST    #1,(GAMSTATE)
            BEQ     .DONE
            LEA     PIPES,A0
            JSR     PIPUPDALL
            JSR     BRDUPD
            JSR     SCOUPD
.DONE       MOVEM.L (A7)+,D0/A0
            RTS

GAMPLT
            MOVEM.L D0-D1/A0,-(A7)
            JSR     BGPLT
            LEA     PIPES,A0
            JSR     PIPPLOTALL
            JSR     BRDPLOT
            JSR     SCOPLOT
            BTST.B  #1,(GAMSTATE)
            BEQ     .TITLEPLT
            BTST.B  #0,(GAMSTATE)
            BNE     .PAUSEPLT
.DONE       MOVEM.L (A7)+,D0-D1/A0
            RTS

; MAIN TITLE PLOT
.TITLEPLT
            
            CLR.L   D1
            MOVE.B  #80,D0
            TRAP    #15
            
            MOVE.L  #BGSKY,D1
            ADDQ.B  #1,D0
            TRAP    #15
            
            LEA     .TIT1,A0
            MOVE.B  #10,D0
            JSR     UTLPRINT
            
            BTST.B  #4,(SCRCYCCT)
            BEQ     .DONE
            
            MOVE.L  #BGCLDCOL,D1
            MOVE.B  #81,D0
            TRAP    #15
            
            LEA     .TIT2,A0
            MOVE.B  #25,D0
            JSR     UTLPRINT
            
            BRA     .DONE

.TIT1       DC.B    'FLAPPY BIRD 68000',0
.TIT2       DC.B    'PRESS SPACE TO JUMP',0
            DS.W    0

; PAUSE TITLE PLOT
.PAUSEPLT
            
            CLR.L   D1
            MOVE.B  #81,D0
            TRAP    #15
            
            LEA     .PAUSETXT1,A0
            MOVE.B  #10,D0
            JSR     UTLPRINT
            
            BTST.B  #4,(SCRCYCCT)
            BEQ     .DONE
            
            LEA     .PAUSETXT2,A0
            MOVE.B  #25,D0
            JSR     UTLPRINT
            
            BRA     .DONE

.PAUSETXT1  DC.B    'GAME PAUSED',0
.PAUSETXT2  DC.B    'PRESS P TO CONTINUE',0
            DS.W    0


*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
