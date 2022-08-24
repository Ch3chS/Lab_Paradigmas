#lang racket

;-------------------------------------------------- Exportaciones ---------------------------------------------------------------------------------

(provide (all-defined-out))

;--------------------------------------------------------------------------------------------------------------------------------------------------



;--------------------------------------------------------------------------------------------------------------------------------------------------
;----------------------------------------------------------- TDA ----------------------------------------------------------------------------------
;---------------------------------------------------------Pixhex-d---------------------------------------------------------------------------------
;--------------------------------------------------------------------------------------------------------------------------------------------------

;La representación estará dada por una lista la cual constara con el formato (int x int x int x string x int) de la siguiente forma:

;(3, coordenada x>0, coordenada y>0, hex, profundidad>0)            ;El primer 3 indica que el pixel se trata de un pixhex.

;--------------------------------------------------------------------------------------------------------------------------------------------------


;-------------------------------------------------- Constructor -----------------------------------------------------------------------------------

;Función contenedora que antes de crear el pixhex-d confirma que este vaya a ser efectivamente lo que corresponde
;Dominio: int x int x string x int
;Recorrido: pixhex-d
(define pixhex-d (lambda (x y hex depth)
                   (if (pixhex-d? (pixhexcont x y hex depth))
                       (pixhexcont x y hex depth)
                       (list -1 -1 -1 "" -1)               ;Esta será la representación de un pixhex erroneo (para cumplir con el recorrido)
                       )))

;Función que crea una lista a partir de ciertos parametros (idealmente un pixhex-d)
;Dominio: int x int x string x int
;Recorrido: lista
(define pixhexcont (lambda (x y hex depth) (list 3 x y hex depth)))

;--------------------------------------------------------------------------------------------------------------------------------------------------


;-------------------------------------------------- Pertenencia -----------------------------------------------------------------------------------

;Función que verifica que un pixhex-d cumpla con la representación
;Dominio: pixhex-d
;Recorrido: booleano
(define pixhex-d? (lambda (pixhex-d)
                    ;Comprobar que la entrada sea una lista y que no corresponda a la representación de un pixhex erroneo
                    (if (and (list? pixhex-d) (not (equal? pixhex-d (list -1 -1 -1 "" -1))))
                        (if (= (length pixhex-d) 5)
                            ;Comprobar que x,y,depth sean números y hex sea un string
                            (if (and (number? (car pixhex-d)) (and (number? (cadr pixhex-d)) (and (number? (caddr pixhex-d)) (and (string? (cadddr pixhex-d)) (number? (car (cddddr pixhex-d)))))))
                                ;Comprobar que x,y,depth sean mayores o iguales a 0
                                (if (and (= 3 (car pixhex-d)) (and (<= 0 (cadr pixhex-d)) (and (<= 0 (caddr pixhex-d)) (<= 0 (car (cddddr pixhex-d))))))
                                    #t
                                    #f
                                    )
                                #f
                                )
                            #f
                            )
                        #f
                        )))

;Función que verifica que una lista contenga solo pixbit-d
;Recursión
;Entrada: Lista de pixhex-ds
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

;Función que obtiene el valor x de un pixhex-d
;Dominio: pixhex-d
;Recorrido: int
(define getpixhex.x (lambda (pixhex-d)
                      (if (pixhex-d? pixhex-d)      ;Comprobamos que la entrada sea un pixhex-d
                          (cadr pixhex-d)            ;Si lo es, entregamos lo requerido
                          -1                        ;Caso contrario entregamos un -1
                          )))                       ;Esto se repite en las funciones getpixhex.y y getpixhex.depth

;Función que obtiene el valor y de un pixhex-d
;Dominio: pixhex-d
;Recorrido: int
(define getpixhex.y (lambda (pixhex-d)
                      (if (pixhex-d? pixhex-d)
                          (caddr pixhex-d)
                          -1
                          )))

;Función que obtiene el valor hex de un pixhex-d
;Dominio: pixhex-d
;Recorrido: string
(define getpixhex.hex (lambda (pixhex-d)
                      (if (pixhex-d? pixhex-d)      ;Comprobamos que la entrada sea un pixhex-d
                          (cadddr pixhex-d)          ;Si lo es, entregamos lo requerido
                          ""                        ;Caso contrario entregamos un string vacio
                          )))

;Función que obtiene el valor depth de un pixhex-d
;Dominio: pixhex-d
;Recorrido: int
(define getpixhex.depth (lambda (pixhex-d)
                      (if (pixhex-d? pixhex-d)
                          (car (cddddr pixhex-d))
                          -1
                          )))

;--------------------------------------------------------------------------------------------------------------------------------------------------


;-------------------------------------------------- Modificadores ---------------------------------------------------------------------------------

;Función que cambia el valor x de un pixhex-d
;Dominio: pixhex-d x int
;Recorrido: pixhex-d
(define changepixhex.x (lambda (pixhex-d x)
                         (if (pixhex-d? pixhex-d)      ;Comprobamos que la entrada 1 sea un pixhex-d
                             (if (number? x)           ;Comprobamos que la entrada 2 sea un número para no agregar algo que no debe agregarse
                                 (if (<= 0 x)          ;Comprobamos que además este número sea mayor o igual a 0
                                     (list 3 x (getpixhex.y pixhex-d) (getpixhex.hex pixhex-d) (getpixhex.depth pixhex-d))   ;Si todo se cumple retornamos el pixhex-d con el valor cambiado
                                     pixhex-d
                                     )
                                 pixhex-d           ;Si el valor o no es un número o, de serlo, no es mayor o igual a 0, entonces se retorna el mismo pixhex-d que entro
                                 )
                             (list -1 -1 -1 "" -1)     ;Si lo que entro no es un pixhex-d entonces retornamos la representación de pixhex-d erroneo
                             )))                    ;Todo lo anterior se repite en las funciones changepixhex.y y changepixhex.depth

;Función que cambia el valor y de un pixhex-d
;Dominio: pixhex-d x int
;Recorrido: pixhex-d
(define changepixhex.y (lambda (pixhex-d y)
                         (if (pixhex-d? pixhex-d)
                             (if (number? y)
                                 (if (<= 0 y)
                                     (list 3 (getpixhex.x pixhex-d) y (getpixhex.hex pixhex-d) (getpixhex.depth pixhex-d))
                                     pixhex-d
                                     )
                                 pixhex-d
                                 )
                             (list -1 -1 -1 "" -1)
                             )))

;Función que cambia el valor hex de un pixhex-d
;Dominio: pixhex-d x string
;Recorrido: pixhex-d
(define changepixhex.hex (lambda (pixhex-d hex)
                         (if (pixhex-d? pixhex-d)      ;Comprobamos que la entrada 1 sea un pixhex-d
                             (if (string? hex)         ;Comprobamos que la entrada 2 sea un string para no agregar algo que no debe agregarse
                                 (list 3 (getpixhex.x pixhex-d) (getpixhex.y pixhex-d) hex (getpixhex.depth pixhex-d))   ;Si todo se cumple retornamos el pixhex-d con el valor cambiado
                                 pixhex-d              ;Si la parte hexadecimal no es un string se retorna el pixhex-d sin cambiar
                                 )
                             (list -1 -1 -1 "" -1)        ;Si lo que entro no es un pixhex-d entonces retornamos la representación de pixhex-d erroneo
                             )))

;Función que cambia el valor depth de un pixhex-d
;Dominio: pixhex-d x int
;Recorrido: pixhex-d
(define changepixhex.depth (lambda (pixhex-d depth)
                         (if (pixhex-d? pixhex-d)
                             (if (number? depth)
                                 (if (<= 0 depth)
                                     (list 3 (getpixhex.x pixhex-d) (getpixhex.y pixhex-d) (getpixhex.hex pixhex-d) depth)
                                     pixhex-d
                                     )
                                 pixhex-d
                                 )
                             (list -1 -1 -1 "" -1)
                             )))


;--------------------------------------------------------------------------------------------------------------------------------------------------