; ==============================================================================
; GAME CONSTS
; ==============================================================================

; --- BIRD RELATED CONSTANTS ---------------------------------------------------
BRDARD      EQU     8
BRDCOL      EQU     $0000D0D0
BRDVEL      EQU     5
BRDGRV      EQU     2                       ; GRAVITY
BRDWIDTH    EQU     16
BRDHEIGH    EQU     16
BRDMAXVELY  EQU     12
BRDJMPVEL   EQU     -12

; --- PIPE RELATED CONSTANTS --------------------------------------------------
PIPCOL      EQU     $00FFFFFF
HOLHEIGH    EQU     120                     ; HOLE HEIGH
PIPWIDTH    EQU     64
PIPHEAD     EQU     28                      ; PIPE HEAD HEIGHT
PIPHEDOFS   EQU     4                       ; PIPE HEAD OFFSET
PIPPENCL    EQU     $00FFFFFF               ; PIPE PEN COLOR
PIPFILCL    EQU     $00008000               ; PIPE FILL COLOR
PIPEDGE     EQU     5                       ; PIPE EDGE WIDTH
PIPXSPD     EQU     5                       ; PIPE X SPEED

PIPXGAP     EQU     200
PIPNUM      EQU     4

; --- GAME OVER STATE RELATED CONSTANTS ---------------------------------------
GOVSTRX     EQU     35                      ; TITLE X COORDINATE
GOVSTRY     EQU     15                      ; TITLE Y COORDINATE
GOVSTRC     EQU     $00FFFFFF               ; TITLE COLOR

; --- IMAGE RELATED CONSTANTS -------------------------------------------------

IMGHEIGH    EQU     40
IMGWIDTH    EQU     40
IMGPOSX     EQU     (SCRWIDTH-IMGWIDTH)/2
IMGPOSY     EQU     (SCRHEIGH-IMGHEIGH)/2

; --- BUTTON RELATED CONSTANTS ------------------------------------------------

BTNMINX     EQU     SCRWIDTH/2-96
BTNMAXX     EQU     SCRWIDTH/2+96
BTNMINY     EQU     3*SCRHEIGH/4+10
BTNMAXY     EQU     3*SCRHEIGH/4+34

; --- FLOOR RELATED CONSTANTS -------------------------------------------------
FLRPOSY     EQU     400

; --- SCORE RELATED CONSTANTS -------------------------------------------------
SCOPOS      EQU     0                       ; FIRST TEXT LINE COORDINATES

; --- STATE RELATED CONSTANTS -------------------------------------------------

STANONE     EQU     -1                      ; NON-EXISTENT STATE NUMBER

; --- BACKGROUND RELATED CONSTANTS

BGSKY       EQU     $00800000
BGCLDCOL    EQU     $00D04000
BGVEL       EQU     2
BGLEN       EQU     128                     ; BACKGROUND CLOUD PATTERN PERIOD




*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
