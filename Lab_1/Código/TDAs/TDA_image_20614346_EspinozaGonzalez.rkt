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

(define getcompressed (lambda (image)
                        (if (image? image)
                            (car image)
                            -1
                         )))

(define getwidth (lambda (image)
                        (if (image? image)
                            (cadr image)
                            -1
                         )))

(define getheight (lambda (image)
                        (if (image? image)
                            (caddr image)
                            -1
                         )))

(define getpixels (lambda (image)
                        (if (image? image)
                            (cadddr image)
                            null
                         )))

(define getmostused (lambda (image)
                        (if (image? image)
                            (car (cddddr image))
                            -1
                         )))

;-----------------------------------------------------------------------------------------------------------------------------------------------------


;-------------------------------------------------- Modificadores ------------------------------------------------------------------------------------

;Función que convierte un pixrgb-d a un pixhex-d
;Entrada: pixrgb-d
;Salida: pixhex-d
(define pixrgb->pixhex (lambda (pixrgb-d)
                         (pixhex-d (getpixrgb.x pixrgb-d) (getpixrgb.y pixrgb-d) 
                         (string-append "#" (car (rgb->hex (getpixrgb.r pixrgb-d))) (cadr (rgb->hex (getpixrgb.r pixrgb-d)))
                                        (car (rgb->hex (getpixrgb.g pixrgb-d))) (cadr (rgb->hex (getpixrgb.g pixrgb-d)))
                                        (car (rgb->hex (getpixrgb.b pixrgb-d))) (cadr (rgb->hex (getpixrgb.b pixrgb-d)))
                                        )
                         (getpixrgb.depth pixrgb-d)
                         )))

;Función que convierte una pixrgb-dlist a una pixhex-dlist haciendo uso de la función anterior
;Entrada: pixrgb-dlist
;Salida: pixhex-dlist
(define pixelsrgb->pixelshex (lambda (pixels)
                               (if (not (equal? pixels null))
                                   (cons (pixrgb->pixhex (car pixels)) (pixelsrgb->pixelshex (cdr pixels)))
                                   null
                                   )
                               ))

;
(define mostusedrgb->mostusedhex (lambda (pixmap)
                                    (string-append "#" (car (rgb->hex (car (getmostused pixmap)))) (cadr (rgb->hex (car (getmostused pixmap))))
                                        (car (rgb->hex (cadr (getmostused pixmap)))) (cadr (rgb->hex (cadr (getmostused pixmap))))
                                        (car (rgb->hex (caddr (getmostused pixmap)))) (cadr (rgb->hex (caddr (getmostused pixmap))))
                                        )))

;-----------------------------------------------------------------------------------------------------------------------------------------------------


;-------------------------------------------------- Otras funciones ----------------------------------------------------------------------------------


;Las siguientes 2 funciones son para saber el most-used-color en una imagen de tipo bitmap:

;Funcion que dice que bit se esta usando más en un bitmap
;Entrada: image
;Salida: int(0|1)
(define mostusedbit (lambda (image)
                      (if (> (countbit1 (getpixels image)) (/ (* (getwidth image) (getheight image)) 2))
                          1
                          0
                          )))

;Funcion que dice cuantos bit 1 hay en una lista de pixbit-d
;Recursión: natural
;Entrada: pixbit-dlist
;Salida: int
(define countbit1 (lambda (pixels)
                         (if (not (equal? pixels null))
                          (+ (getpixbit.bit (car pixels)) (countbit1 (cdr pixels)))
                          0
                          )))



;Las siguientes 2 funciones son para saber el color más usado en un pixmap

;Funcion que devuelve una lista con el color de tipo rgb más usado y la cantidad de veces que se usa en una lista de pixeles
;Entrada: pixrgblist
;Salida: list= '(list(r g b), int)
(define mostusedrgb (lambda (pixels)
                      (if (not (equal? pixels null))
                          (if (> (countfirstpixrgbcolor pixels) (cadr (mostusedrgb (cdr pixels))))
                              (list (list (getpixrgb.r (car pixels)) (getpixrgb.g (car pixels)) (getpixrgb.b (car pixels))) (countfirstpixrgbcolor pixels))
                              (mostusedrgb (cdr pixels))
                              )
                          (list (list -1 -1 -1) 0)
                          )))

;Funcion que cuenta cuantas veces se repite el color del primer pixrgb-d en la lista de pixeles
;Entrada: pixrgblist
;Salida: int
(define countfirstpixrgbcolor (lambda (pixels)
                             (if (not (equal? pixels null))
                                 (length (filter (lambda (pixrgb-d) (and (= (getpixrgb.r (car pixels)) (getpixrgb.r pixrgb-d)) (and (= (getpixrgb.g (car pixels)) (getpixrgb.g pixrgb-d)) (= (getpixrgb.b (car pixels)) (getpixrgb.b pixrgb-d))))) pixels))  ;Revisamos cuantas veces se repite el color del primer pixel en la lista
                                         0
                                         )
                                 ))

;Las siguientes 2 funciones nos permiten transformar un un número entero entre 0 y 255 a un string hexadecimal



;Función que transforma un número de 0 a 255 a una lista con 2 decimales listos para ser transformados a 2 digitos hexadecimales
;Entrada: int
;Salida: list: '(int, int)
(define rgb->hex (lambda (num)
                         (if (> num 15)
                             (list (num->hex (/ (- num (modulo num 16)) 16)) (num->hex (modulo num 16)))
                             (list "0" (num->hex (modulo num 16)))
                             )
                         ))

;Toma una lista de 2 digitos en hexadecimal y los junta en un string hexadecimal
;Entrada: list: '(int, int)
;Salida: string
(define num->hex (lambda (num)
                   (if (< num 10)
                       (number->string num)
                       (if (= num 10) "A"
                           (if (= num 11) "B"
                               (if (= num 12) "C"
                                   (if (= num 13) "D"
                                       (if (= num 14) "E"
                                           (if (= num 15) "F"
                                           "?"
                                           )
                                       )
                                   )
                               )
                           )
                       )
                   )))

;-----------------------------------------------------------------------------------------------------------------------------------------------------


