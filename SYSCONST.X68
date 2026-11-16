; ==============================================================================
; GAME CONSTATS 
; ==============================================================================

; --- TRAP RELATED CONSTANTS --------------------------------------------------

KBDTRAP     EQU     0                       ; KEYBOARD UPDATE TRAP
SCRTRAP     EQU     1                       ; SCREEN REFRESH TRAP
SNDPLTN     EQU     2                       ; SOUND PLAY TRAP NUMBER

;---KEYCODES---------------------------------------------------
KBDLEFT     EQU     $25
KBDUP       EQU     $26
KBDRIGHT    EQU     $27
KBDDOWN     EQU     $28

KBDSPACE    EQU     ' '
KBDPAUSE    EQU     'P'

; --- SCREEN RELATED CONSTANTS ------------------------------------------------

SCRWIDTH    EQU     640                     ; SCREEN WIDTH (PIXELS)
SCRHEIGH    EQU     480                     ; SCREEN HEIGHT (PIXELS)
SCRIRQ      EQU     1                       ; SCREEN INTERRUPT NUMBER
SCRTIM      EQU     20                      ; SCREEN TIMER (MS)









*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
