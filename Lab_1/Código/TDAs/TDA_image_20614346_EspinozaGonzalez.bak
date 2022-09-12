#lang racket

;-------------------------------------------------- Importaciones y exportaciones --------------------------------------------------------------------

(require "TDA_pixbit-d_20614346_EspinozaGonzalez.rkt")  ;TDA pixbit-d
(require "TDA_pixrgb-d_20614346_EspinozaGonzalez.rkt")  ;TDA pixrgb-d
(require "TDA_pixhex-d_20614346_EspinozaGonzalez.rkt")  ;TDA pixhex-d

(provide (all-defined-out))

;-----------------------------------------------------------------------------------------------------------------------------------------------------


;--------------------------------------------------------------------------------------------------------------------------------------------------
;----------------------------------------------------------- TDA ----------------------------------------------------------------------------------
;-----------------------------------------------------------image----------------------------------------------------------------------------------
;--------------------------------------------------------------------------------------------------------------------------------------------------

;La representación estará dada por una lista la cual constara con el formato (int x int x int x list x int) de la siguiente forma:

;(compressed?(0|1) ,x>0, y>0, pixels, muc(most-used-color))

;--------------------------------------------------------------------------------------------------------------------------------------------------



;-------------------------------------------------- Pertenencia --------------------------------------------------------------------------------------

(define image? (lambda (image)
                 (if (and (list? image) (not (equal? image (list -1 -1 -1 null -1))))
                     (if (= (length image) 5)
                         (if (and (and (number? (car image)) (and (number? (cadr image)) (and (number? (caddr image)) (list? (cadddr image))))))
                          #t
                          #f
                          )
                         #f
                         )
                     #f
                     )))

;-----------------------------------------------------------------------------------------------------------------------------------------------------


;-------------------------------------------------- Selectores ---------------------------------------------------------------------------------------

;Función que obtiene el valor compressed de una imagen
;Entrada: image
;Salida: int
(define getcompressed (lambda (image)
                        (if (image? image)
                            (car image)
                            -1
                         )))

;Función que obtiene el valor width de una imagen
;Entrada: image
;Salida: int
(define getwidth (lambda (image)
                        (if (image? image)
                            (cadr image)
                            -1
                         )))

;Función que obtiene el valor height de una imagen
;Entrada: image
;Salida: int
(define getheight (lambda (image)
                        (if (image? image)
                            (caddr image)
                            -1
                         )))

;Función que obtiene los pixels de una imagen
;Entrada: image
;Salida: list
(define getpixels (lambda (image)
                        (if (image? image)
                            (cadddr image)
                            null
                         )))

;Función que obtiene el valor getmostused de una imagen
;Entrada: image
;Salida: int | list | string dependiendo si la imagen es un bitmap | pixmap | hexmap respectivamente
(define getmostused (lambda (image)
                        (if (image? image)
                            (car (cddddr image))
                            -1
                         )))

;-----------------------------------------------------------------------------------------------------------------------------------------------------



;-------------------------------------------------- Otras funciones ----------------------------------------------------------------------------------





;-----------------------------------------------------------------------------------------------------------------------------------------------------


