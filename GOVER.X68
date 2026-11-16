*-----------------------------------------------------------
* GAME OVER SCREEN LOGIC
*-----------------------------------------------------------

; ------------------------------------------------------------------------------
GOVINIT
; GAME OVER SCREEN INIT
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            
            MOVEM.L D0-D4/A1-A2,-(A7)
            
            ; PREPARAMOS
            CLR.L   D1
            CLR.L   D2
            CLR.L   D3

            JSR     UTLFIN
            
            ; PREPARAMOS PUNTEROS PARA SUBRUTINAS 
            LEA     .DOC,A1
            LEA     HIGHSCO,A2
            MOVE.L  #2,D2
            JSR     UTLFRD

.WRFIL      ; TODO LISTO PARA ESCRIBIR
            CLR.W   D3
            MOVE.W  (SCOPASS),D3
            
            CMP.W   (HIGHSCO),D3
            BLE     .DONE
            
            MOVE.W  D3,(HIGHSCO)
            
            ; WRITE TO FILE
            LEA     .DOC,A1
            LEA     HIGHSCO,A2
            CLR.L   D2
            MOVE.L  #2,D2
            JSR     UTLFWR
            
            ;FIN
.DONE       MOVEM.L (A7)+,D0-D4/A1-A2
            RTS    
       
.DOC        DC.B    'SCORE/score.bin',0
            DS.W    0

; ------------------------------------------------------------------------------
GOVUPD
; GAME OVER SCREEN UPDATE
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L D0-D1,-(A7)
            
            ; MOUSE READ
            MOVE.B  #61,D0
            MOVE.B  #0,D1                   ; READ MOUSE DOWN STATE
            TRAP    #15
            
            ; CHECK RIGHT CLICK
            BTST    #0,D0
            BEQ     .DONE
            
            ; CHECK X MOUSE POSITION
            CMP.W   #BTNMINX,D1
            BLE     .DONE
            CMP.W   #BTNMAXX,D1
            BGE     .DONE
            
            ; CHECK Y MOUSE POSITION            
            SWAP    D1
            CMP.W   #BTNMINY,D1
            BLE     .DONE
            CMP.W   #BTNMAXY,D1
            BGE     .DONE
            
            MOVE.W  #0,(STANEXT)
.DONE       MOVEM.L (A7)+,D0-D1
            RTS

; ------------------------------------------------------------------------------
GOVPLT
; GAME OVER SCREEN PLOT
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
            ;CLR.L   D1
            ;MOVE.B  #81,D0
            ;TRAP    #15
; ------------------------------------------------------------------------------

            MOVEM.L D0-D4/A1-A0,-(A7)
            
            LEA     .TXT1,A0
            MOVE.B  #10,D0
            JSR     UTLPRINT
                        
            ; IMPRIMIMOS RESULTADO PARTIDA
            LEA     .TXT4,A0
            JSR     UTLPRINT
            CLR.L   D1
            MOVE.W  (SCOPASS),D1
            MOVE.B  #40,D2
            MOVE.B  #20,D0 ; Mostrar un número con signo en D1.L en formato decimal en un campo de D2.B columnas de ancho.
            TRAP    #15
            
            ; IMPRIMIMOS ULTIMO RESULTADO
            LEA     .TXT3 ,A0
            JSR     UTLPRINT
            CLR.L   D1
            MOVE.W  (HIGHSCO),D1
            MOVE.B  #40,D2
            MOVE.B  #20,D0
            TRAP    #15

            ; DRAW BUTTON RECTANGLE
            MOVE.B  #90,D0                  ; DRAW UNFILLED RECTANGLE
            MOVE.W  #BTNMINX,D1
            MOVE.W  #BTNMINY,D2
            MOVE.W  #BTNMAXX,D3
            MOVE.W  #BTNMAXY,D4
            TRAP    #15
            
            JSR     IMGPLT
            
            ; BLINKING TEXT FUNCTIONALITY
            BTST.B  #4,(SCRCYCCT)
            BEQ     .DONE
            
            LEA     .TXT2,A0
            MOVE.B  #25,D0
            JSR     UTLPRINT
            
.DONE       MOVEM.L (A7)+,D0-D4/A1-A0
            RTS
            
.TXT1       DC.B    'GAME OVER',0
.TXT2       DC.B    'CLICK HERE TO CONTINUE',0
.TXT3       DC.B    'HIGHEST SCORE:',0
.TXT4       DC.B    'YOUR SCORE:',0
            DS.W    0
 





*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
