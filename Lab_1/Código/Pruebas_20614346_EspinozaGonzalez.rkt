#lang racket

;------------------------------------------------------------------------------------------------------------------------------------------------------
;-------------------------------------------------------- Funciones principales -----------------------------------------------------------------------
;------------------------------------------------------------------------------------------------------------------------------------------------------


;------------------------------------------------------------------------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------------------------------------------------------------------------



;------------------------------------------------------------------------------------------------------------------------------------------------------
;------------------------------------------------------------ Funciones TDAs --------------------------------------------------------------------------
;------------------------------------------------------------------------------------------------------------------------------------------------------

;-------------------------------------------------------------- pixbit-d ------------------------------------------------------------------------------

;Constructor pixbit-d
(define pixbit1 (pixbit-d 4 2 1 3))
(define pixbit2 (pixbit-d 2 5 0 1))
(define pixbit3 (pixbit-d 1 3 5 2))  ;Este nos devolverá la representación de un pixbit-d erroneo porque el bit no puede ser 5 '(-1 -1 -1 -1)

;Pertenencia pixbit-d
(define pixbit?1 (pixbit-d? pixbit1))
(define pixbit?2 (pixbit-d? pixbit2))
(define pixbit?3 (pixbit-d? pixbit3)) ;Falso


;;Selectores pixbit-d
;selector x
(define getpixbit.x1 (getpixbit.x pixbit1))
(define getpixbit.x2 (getpixbit.x pixbit2))
(define getpixbit.x3 (getpixbit.x pixbit3))   ;Al ser erroneo nos devolvera un -1

;selector y
(define getpixbit.y1 (getpixbit.y pixbit1))
(define getpixbit.y2 (getpixbit.y pixbit2))
(define getpixbit.y3 (getpixbit.y pixbit3))   ;Al ser erroneo nos devolvera un -1

;selector bit
(define getpixbit.bit1 (getpixbit.bit pixbit1))
(define getpixbit.bit2 (getpixbit.bit pixbit2))
(define getpixbit.bit3 (getpixbit.bit pixbit3))   ;Al ser erroneo nos devolvera un -1

;selector depth
(define getpixbit.depth1 (getpixbit.depth pixbit1))
(define getpixbit.depth2 (getpixbit.depth pixbit2))
(define getpixbit.depth3 (getpixbit.depth pixbit3))   ;Al ser erroneo nos devolvera un -1


;;Modificadores pixbit-d
;modificador x
(define changepixbit.x1 (changepixbit.x pixbit1 1))
(define changepixbit.x2 (changepixbit.x pixbit2 "a")) ;Al ingresar un string en lugar de un entero nos devolvera la lista sin cambios
(define changepixbit.x3 (changepixbit.x pixbit3 7))   ;Al ser un pixbit erroneo nos devolvera '(-1 -1 -1 -1)

;modificador y
(define changepixbit.y1 (changepixbit.y pixbit1 7))
(define changepixbit.y2 (changepixbit.y pixbit2 "hola")) ;Al ingresar un string en lugar de un entero nos devolvera la lista sin cambios
(define changepixbit.y3 (changepixbit.y pixbit3 2))      ;Al ser un pixbit erroneo nos devolvera '(-1 -1 -1 -1)

;modificador bit
(define changepixbit.bit1 (changepixbit.bit pixbit1 0))
(define changepixbit.bit2 (changepixbit.bit pixbit2 8))   ;Al ingresar un número distinto de 0 o 1 nos devolvera la lista sin cambios
(define changepixbit.bit3 (changepixbit.bit pixbit3 27))   ;Al ser un pixbit erroneo nos devolvera '(-1 -1 -1 -1)

;modificador depth
(define changepixbit.depth1 (changepixbit.depth pixbit1 1))
(define changepixbit.depth2 (changepixbit.depth pixbit2 "adiós")) ;Al ingresar un string en lugar de un entero nos devolvera la lista sin cambios
(define changepixbit.depth3 (changepixbit.depth pixbit3 9))   ;Al ser un pixbit erroneo nos devolvera '(-1 -1 -1 -1)

;------------------------------------------------------------------------------------------------------------------------------------------------------


;-------------------------------------------------------------- pixrgb-d ------------------------------------------------------------------------------

;Constructor pixbit-d
(define pixrgb1 (pixrgb-d 4 2 124 222 152 3))
(define pixrgb2 (pixrgb-d 2 5 52 15 52 1))
(define pixrgb3 (pixrgb-d 1 3 45 636 335 2))  ;Este nos devolverá la representación de un pixbit-d erroneo por el g,b mayores de 255 '(-1 -1 -1 -1 -1 -1)

;Pertenencia pixbit-d
(define pixrgb?1 (pixrgb-d? pixrgb1))
(define pixrgb?2 (pixrgb-d? pixrgb2))
(define pixrgb?3 (pixrgb-d? pixrgb3)) ;Falso


;;Selectores pixrgb-d
;selector x
(define getpixrgb.x1 (getpixrgb.x pixrgb1))
(define getpixrgb.x2 (getpixrgb.x pixrgb2))
(define getpixrgb.x3 (getpixrgb.x pixrgb3))   ;Al ser erroneo nos devolvera un -1

;selector y
(define getpixrgb.y1 (getpixrgb.y pixrgb1))
(define getpixrgb.y2 (getpixrgb.y pixrgb2))
(define getpixrgb.y3 (getpixrgb.y pixrgb3))   ;Al ser erroneo nos devolvera un -1

;selector r
(define getpixrgb.r1 (getpixrgb.r pixrgb1))
(define getpixrgb.r2 (getpixrgb.r pixrgb2))
(define getpixrgb.r3 (getpixrgb.r pixrgb3))   ;Al ser erroneo nos devolvera un -1

;selector g
(define getpixrgb.g1 (getpixrgb.g pixrgb1))
(define getpixrgb.g2 (getpixrgb.g pixrgb2))
(define getpixrgb.g3 (getpixrgb.g pixrgb3))   ;Al ser erroneo nos devolvera un -1

;selector b
(define getpixrgb.b1 (getpixrgb.b pixrgb1))
(define getpixrgb.b2 (getpixrgb.b pixrgb2))
(define getpixrgb.b3 (getpixrgb.b pixrgb3))   ;Al ser erroneo nos devolvera un -1

;selector depth
(define getpixrgb.depth1 (getpixrgb.depth pixrgb1))
(define getpixrgb.depth2 (getpixrgb.depth pixrgb2))
(define getpixrgb.depth3 (getpixrgb.depth pixrgb3))   ;Al ser erroneo nos devolvera un -1


;;Modificadores pixbit-d
;modificador x
(define changepixrgb.x1 (changepixrgb.x pixrgb1 1))
(define changepixrgb.x2 (changepixrgb.x pixrgb2 "a")) ;Al ingresar un string en lugar de un entero nos devolvera la lista sin cambios
(define changepixrgb.x3 (changepixrgb.x pixrgb3 7))   ;Al ser un pixbit erroneo nos devolvera '(-1 -1 -1 -1 -1 -1)

;modificador y
(define changepixrgb.y1 (changepixrgb.y pixrgb1 7))
(define changepixrgb.y2 (changepixrgb.y pixrgb2 "hola")) ;Al ingresar un string en lugar de un entero nos devolvera la lista sin cambios
(define changepixrgb.y3 (changepixrgb.y pixrgb3 2))      ;Al ser un pixbit erroneo nos devolvera '(-1 -1 -1 -1 -1 -1)

;modificador r
(define changepixrgb.r1 (changepixrgb.r pixrgb1 0))
(define changepixrgb.r2 (changepixrgb.r pixrgb2 685))   ;Al ingresar un número mayor a 255 nos devolvera la lista sin cambios
(define changepixrgb.r3 (changepixrgb.r pixrgb3 27))   ;Al ser un pixbit erroneo nos devolvera '(-1 -1 -1 -1 -1 -1)

;modificador g
(define changepixrgb.g1 (changepixrgb.g pixrgb1 0))
(define changepixrgb.g2 (changepixrgb.g pixrgb2 9238))   ;Al ingresar un número mayor a 255 nos devolvera la lista sin cambios
(define changepixrgb.g3 (changepixrgb.g pixrgb3 217))   ;Al ser un pixbit erroneo nos devolvera '(-1 -1 -1 -1 -1 -1)

;modificador b
(define changepixrgb.b1 (changepixrgb.b pixrgb1 0))
(define changepixrgb.b2 (changepixrgb.b pixrgb2 -5))   ;Al ingresar un número menor a 0 nos devolvera la lista sin cambios
(define changepixrgb.b3 (changepixrgb.b pixrgb3 127))   ;Al ser un pixbit erroneo nos devolvera '(-1 -1 -1 -1 -1 -1)

;modificador depth
(define changepixrgb.depth1 (changepixrgb.depth pixrgb1 1))
(define changepixrgb.depth2 (changepixrgb.depth pixrgb2 "adiós")) ;Al ingresar un string en lugar de un entero nos devolvera la lista sin cambios
(define changepixrgb.depth3 (changepixrgb.depth pixrgb3 9))   ;Al ser un pixbit erroneo nos devolvera '(-1 -1 -1 -1 -1 -1)


;------------------------------------------------------------------------------------------------------------------------------------------------------


;-------------------------------------------------------------- pixhex-d ------------------------------------------------------------------------------

;Constructor pixhex-d
(define pixhex1 (pixhex-d 4 2 "#D245F2" 3))
(define pixhex2 (pixhex-d 2 5 "#A3B4D2" 1))
(define pixhex3 (pixhex-d 1 3 5 2))  ;Este nos devolverá la representación de un pixbit-d erroneo porque hex no puede ser un número '(-1 -1 "" -1)

;Pertenencia pixbit-d
(define pixhex?1 (pixhex-d? pixhex1))
(define pixhex?2 (pixhex-d? pixhex2))
(define pixhex?3 (pixhex-d? pixhex3)) ;Falso


;;Selectores pixbit-d
;selector x
(define getpixhex.x1 (getpixhex.x pixhex1))
(define getpixhex.x2 (getpixhex.x pixhex2))
(define getpixhex.x3 (getpixhex.x pixhex3))   ;Al ser erroneo nos devolvera un -1

;selector y
(define getpixhex.y1 (getpixhex.y pixhex1))
(define getpixhex.y2 (getpixhex.y pixhex2))
(define getpixhex.y3 (getpixhex.y pixhex3))   ;Al ser erroneo nos devolvera un -1

;selector hex
(define getpixhex.hex1 (getpixhex.hex pixhex1))
(define getpixhex.hex2 (getpixhex.hex pixhex2))
(define getpixhex.hex3 (getpixhex.hex pixhex3))   ;Al ser erroneo nos devolvera un ""

;selector depth
(define getpixhex.depth1 (getpixhex.depth pixhex1))
(define getpixhex.depth2 (getpixhex.depth pixhex2))
(define getpixhex.depth3 (getpixhex.depth pixhex3))   ;Al ser erroneo nos devolvera un -1


;;Modificadores pixbit-d
;modificador x
(define changepixhex.x1 (changepixhex.x pixhex1 1))
(define changepixhex.x2 (changepixhex.x pixhex2 "a")) ;Al ingresar un string en lugar de un entero nos devolvera la lista sin cambios
(define changepixhex.x3 (changepixhex.x pixhex3 7))   ;Al ser un pixbit erroneo nos devolvera '(-1 -1 "" -1)

;modificador y
(define changepixhex.y1 (changepixhex.y pixhex1 7))
(define changepixhex.y2 (changepixhex.y pixhex2 "hola")) ;Al ingresar un string en lugar de un entero nos devolvera la lista sin cambios
(define changepixhex.y3 (changepixhex.y pixhex3 2))      ;Al ser un pixbit erroneo nos devolvera '(-1 -1 "" -1)

;modificador hex
(define changepixhex.hex1 (changepixhex.hex pixhex1 "#52F3A5"))
(define changepixhex.hex2 (changepixhex.hex pixhex2 8))           ;Al ingresar un número nos devolvera la lista sin cambios
(define changepixhex.hex3 (changepixhex.hex pixhex3 "#721352"))   ;Al ser un pixbit erroneo nos devolvera '(-1 -1 "" -1)

;modificador depth
(define changepixhex.depth1 (changepixhex.depth pixhex1 1))
(define changepixhex.depth2 (changepixhex.depth pixhex2 "adiós")) ;Al ingresar un string en lugar de un entero nos devolvera la lista sin cambios
(define changepixhex.depth3 (changepixhex.depth pixhex3 9))   ;Al ser un pixbit erroneo nos devolvera '(-1 -1 "" -1)

;------------------------------------------------------------------------------------------------------------------------------------------------------

;------------------------------------------------------------------------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------------------------------------------------------------------------

(require "TDAs/TDA_pixbit-d_20614346_EspinozaGonzalez.rkt")
(require "TDAs/TDA_pixrgb-d_20614346_EspinozaGonzalez.rkt")
(require "TDAs/TDA_pixhex-d_20614346_EspinozaGonzalez.rkt")