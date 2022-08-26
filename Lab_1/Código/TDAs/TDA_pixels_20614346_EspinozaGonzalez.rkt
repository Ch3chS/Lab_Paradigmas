#lang racket

;-------------------------------------------------- Importaciones y exportaciones --------------------------------------------------------------------

(require "TDA_pixbit-d_20614346_EspinozaGonzalez.rkt")  ;TDA pixbit-d
(require "TDA_pixrgb-d_20614346_EspinozaGonzalez.rkt")  ;TDA pixrgb-d
(require "TDA_pixhex-d_20614346_EspinozaGonzalez.rkt")  ;TDA pixhex-d
(require "TDA_image_20614346_EspinozaGonzalez.rkt")  ;TDA image

(provide (all-defined-out))

;-----------------------------------------------------------------------------------------------------------------------------------------------------

;--------------------------------------------------------------------------------------------------------------------------------------------------
;----------------------------------------------------------- TDA ----------------------------------------------------------------------------------
;-----------------------------------------------------------pixels----------------------------------------------------------------------------------
;--------------------------------------------------------------------------------------------------------------------------------------------------

;Este TDA consiste en una lista de pixeles de un solo tipo, pudiendo ser pixbit-dlist, pixrgb-dlist o pixhex-dlist

;Como se ingresa en el argumento de la función image no requiere constructor

;--------------------------------------------------------------------------------------------------------------------------------------------------


;-------------------------------------------------- Pertenencia -----------------------------------------------------------------------------------

;Función que verifica que una lista contenga solo pixbit-d (sea un pixbit-dlist)
;Recursión
;Entrada: lista
;Salida: booleano
(define pixbit-dlist? (lambda (list)
                        (if (equal? list null)
                            #t
                         (if (and (pixbit-d? (car list)) (pixbit-dlist? (cdr list)))
                             #t
                             #f
                             )
                         )))

;Función que verifica que una lista contenga solo pixbit-d (sea un pixrgb-dlist)
;Recursión
;Entrada: lista
;Salida: booleano
(define pixrgb-dlist? (lambda (list)
                        (if (equal? list null)
                            #t
                         (if (and (pixrgb-d? (car list)) (pixrgb-dlist? (cdr list)))
                             #t
                             #f
                             )
                         )))

;Función que verifica que una lista contenga solo pixbit-d (sea un pixhex-dlist)
;Recursión
;Entrada: lista
;Salida: booleano
(define pixhex-dlist? (lambda (list)
                        (if (equal? list null)
                            #t
                         (if (and (pixhex-d? (car list)) (pixhex-dlist? (cdr list)))
                             #t
                             #f
                             )
                         )))

;--------------------------------------------------------------------------------------------------------------------------------------------------

;-------------------------------------------------- Selectores ------------------------------------------------------------------------------------


;--------------------------------------------------------------------------------------------------------------------------------------------------

;-------------------------------------------------- Modificadores ---------------------------------------------------------------------------------

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

;Función que toma el color más usado en una imagen de tipo pixmap y lo convierte en un color de tipo hexadecimal
;Entrada: image(pixmap)
;Salida: string
(define mostusedrgb->mostusedhex (lambda (pixmap)
                                    (string-append "#" (car (rgb->hex (car (getmostused pixmap)))) (cadr (rgb->hex (car (getmostused pixmap))))
                                        (car (rgb->hex (cadr (getmostused pixmap)))) (cadr (rgb->hex (cadr (getmostused pixmap))))
                                        (car (rgb->hex (caddr (getmostused pixmap)))) (cadr (rgb->hex (caddr (getmostused pixmap))))
                                        )))

;-----------------------------------------------------------------------------------------------------------------------------------------------------


;-------------------------------------------------- Otras funciones ----------------------------------------------------------------------------------

;Retorna el color más usado en una lista de pixeles
(define mostused (lambda (width height pixels)
                   (if (pixbit-dlist? pixels)
                       (mostusedbit width height pixels)
                       (if (pixrgb-dlist? pixels)
                           (car (mostusedrgb pixels))
                           (if (pixhex-dlist? pixels)
                               (car (mostusedhex pixels))
                               0
                               )
                           )
                       )
                   ))

;Las siguientes 2 funciones son para saber el most-used-color en una imagen de tipo bitmap:

;Funcion que dice que bit se esta usando más en un bitmap
;Entrada: image
;Salida: int(0|1)
(define mostusedbit (lambda (width height pixels)
                      (if (> (countbit1 pixels) (/ (* width height) 2))
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
;Entrada: pixrgb-dlist
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
;Entrada: pixrgb-dlist
;Salida: int
(define countfirstpixrgbcolor (lambda (pixels)
                             (if (not (equal? pixels null))
                                 (length (filter (lambda (pixrgb-d) (and (= (getpixrgb.r (car pixels)) (getpixrgb.r pixrgb-d)) (and (= (getpixrgb.g (car pixels)) (getpixrgb.g pixrgb-d)) (= (getpixrgb.b (car pixels)) (getpixrgb.b pixrgb-d))))) pixels))  ;Revisamos cuantas veces se repite el color del primer pixel en la lista
                                         0
                                         )
                                 ))

;Funcion que devuelve el hex más común entre los pixeles
;Entrada: pixhex-dlist
;Salida: list= '(string, int)
(define mostusedhex (lambda (pixels)
                      (if (not (equal? pixels null))
                          (if (> (countfirstpixhexcolor pixels) (cadr (mostusedhex (cdr pixels))))
                              (list (getpixhex.hex (car pixels)) (countfirstpixrgbcolor pixels))
                              (mostusedhex (cdr pixels))
                              )
                          (list "" 0)
                          )
                      ))

(define countfirstpixhexcolor (lambda (pixels)
                             (if (not (equal? pixels null))
                                 (length (filter (lambda (pixhex-d) (equal? (getpixhex.hex (car pixels)) (getpixhex.hex pixhex-d))) pixels))  ;Revisamos cuantas veces se repite el color del primer pixel en la lista
                                         0
                                         )
                                 ))


;Función que invierte una lista de pixeles respecto al ancho
;Entrada: int(fliph = 1/ flipv = 2) x int(width o height dependiendo del caso) x pixels
;Salida: pixels
(define flippixels (lambda (op valor pixels)
                           (if (not (equal? pixels null))
                           (if (= op 1)
                               (cons (fliphpixel valor (car pixels)) (flippixels op valor (cdr pixels))) ;Si op es 1 fliph
                               (cons (flipvpixel valor (car pixels)) (flippixels op valor (cdr pixels))) ;Sino flipv
                               )
                           
                           null
                           )))

;Función que invierte la x de un pixel horizontalmente (dependiendo del ancho de la imagen)
;Entrada: pixel  (pudiendo ser pixbit-d, pixrgb-d o pixhex-d)
;Salida: pixel   (del mismo tipo que ingreso)
(define fliphpixel (lambda (width pixel)
                     (if (pixbit-d? pixel)
                         (changepixbit.x pixel (- width (getpixbit.x pixel)))
                         (if (pixrgb-d? pixel)
                             (changepixrgb.x pixel (- width (getpixrgb.x pixel)))
                             (changepixhex.x pixel (- width (getpixhex.x pixel)))
                             )
                         )
                     ))

;Función que invierte la x de un pixel horizontalmente (dependiendo del ancho de la imagen)
;Entrada: pixel  (pudiendo ser pixbit-d, pixrgb-d o pixhex-d)
;Salida: pixel   (del mismo tipo que ingreso)
(define flipvpixel (lambda (height pixel)
                     (if (pixbit-d? pixel)
                         (changepixbit.y pixel (- height (getpixbit.y pixel)))
                         (if (pixrgb-d? pixel)
                             (changepixrgb.y pixel (- height (getpixrgb.y pixel)))
                             (changepixhex.y pixel (- height (getpixhex.y pixel)))
                             )
                         )
                     ))

;Funcion que descarta los pixeles que no esten entre los límites
;Entrada: pixels
;Salida: pixels
(define discardpixels (lambda (x2 x1 y2 y1 pixels)
                        (if (not (equal? pixels null))
                            (if (validpixel? x2 x1 y2 y1 (car pixels))
                                (cons (car pixels) (discardpixels x2 x1 y2 y1 (cdr pixels)))
                                (discardpixels x2 x1 y2 y1 (cdr pixels))
                                )
                            null
                            )
                        ))

;Función que retorna si un pixel está en los limites establecidos
(define validpixel? (lambda (x2 x1 y2 y1 pixel)
                      (if (pixbit-d? pixel)
                          (if (and (and (<= x1 (getpixbit.x pixel)) (<= (getpixbit.x pixel) x2)) (and (<= y1 (getpixbit.y pixel)) (<= (getpixbit.y pixel) y2)))
                          #t
                          #f
                          )
                          (if (pixrgb-d? pixel)
                              (if (and (and (<= x1 (getpixrgb.x pixel)) (<= (getpixrgb.x pixel) x2)) (and (<= y1 (getpixrgb.y pixel)) (<= (getpixrgb.y pixel) y2)))
                                  #t
                                  #f
                                  )
                              (if (pixhex-d? pixel)
                                  (if (and (and (<= x1 (getpixhex.x pixel)) (<= (getpixhex.x pixel) x2)) (and (<= y1 (getpixhex.y pixel)) (<= (getpixhex.y pixel) y2)))
                                      #t
                                      #f
                                      )
                                  #f
                                  )
                              )
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
