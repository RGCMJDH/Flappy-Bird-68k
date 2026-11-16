
; ==============================================================================
; GAME VARIABLES
; ==============================================================================

; --- BIRD RELATED VARIABLES ---------------------------------------------------

BRDPOSX     DS.W    1                       ; BIRD X COORDINATE
BRDPOSY     DS.W    1                       ; BIRD Y COORDINATE
BRDVELY     DS.W    1                       ; BIRD Y VELOCITY

MINPOSY     DS.W    1                       ; MIN Y POSITION WITHOUT COLLISIONS
MAXPOSY     DS.W    1                       ; MAX Y POSITION WITHOUT COLLISIONS
PREVMIN     DS.W    1                       ; MIN Y POSITION IN PREVIOUS FRAME
            DS.W    0
            
; --- PIPE RELATED VARIABLES ---------------------------------------------------

PIPES       DS.W    2*PIPNUM

; --- SCOREBOARD RELATED VARIABLES ---------------------------------------------

SCOPASS     DS.W    1                       ; NUMBER OF PIPES PASSED
HIGHSCO     DS.W    1                       ; PERSONAL SCORE RECORD

; --- STATE RELATED VARIABLES --------------------------------------------------

STACUR      DS.W    1                       ; CURRENT STATE
STANEXT     DS.W    1                       ; NEXT STATE

; --- GAME SCREEN STATE
; BIT 0: GAME PAUSED
; BIT 1: GAME STARTED
GAMSTATE    DS.B    1                       ; GAME PAUSED STATE
            DS.W    0

; --- BACKGROUND RELATED VARIABLES
BGPOSX      DS.W    1


*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
