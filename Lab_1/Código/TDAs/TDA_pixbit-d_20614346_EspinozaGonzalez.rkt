#lang racket

;-------------------------------------------------- Exportaciones ---------------------------------------------------------------------------------

(provide (all-defined-out))

;--------------------------------------------------------------------------------------------------------------------------------------------------



;--------------------------------------------------------------------------------------------------------------------------------------------------
;----------------------------------------------------------- TDA ----------------------------------------------------------------------------------
;---------------------------------------------------------Pixbit-d---------------------------------------------------------------------------------
;--------------------------------------------------------------------------------------------------------------------------------------------------

;La representación estará dada por una lista la cual constara con el formato (int x int x int x int x int) de la siguiente forma:

;(1 ,coordenada x>0, coordenada y>0, bit(0|1), profundidad>0)   ;El primer 1 indica que el pixel se trata de un pixbit.

;--------------------------------------------------------------------------------------------------------------------------------------------------


;-------------------------------------------------- Constructor -----------------------------------------------------------------------------------

;Función contenedora que antes de crear el pixbit-d confirma que este vaya a ser efectivamente lo que corresponde
;Dominio: int x int x int x int
;Recorrido: pixbit-d
(define pixbit-d (lambda (x y bit depth)
                   ;Comprobar que lo que se vaya a construir de verdad sea un pixbit-d
                   (if (pixbit-d? (pixbitcont x y bit depth))
                       ;Si lo es entonces lo construimos
                       (pixbitcont x y bit depth)
                       ;Si no lo es entonces lo representaremos de alguna manera respetando el recorrido de la función
                       (list -1 -1 -1 -1 -1)               ;Esta será la representación de un pixbit erroneo
                       )))

;Función que crea una lista a partir de ciertos parametros (idealmente un pixbit-d)
;Dominio: int x int x int x int
;Recorrido: lista
(define pixbitcont (lambda (x y bit depth) (list 1 x y bit depth)))  ;Esta función contenida es donde se construye como tal la representación

;--------------------------------------------------------------------------------------------------------------------------------------------------


;-------------------------------------------------- Pertenencia -----------------------------------------------------------------------------------

;Función que verifica que un pixbit-d cumpla con la representación
;Dominio: pixbit-d
;Recorrido: booleano
(define pixbit-d? (lambda (pixbit-d)
                    ;Comprobar que la entrada sea una lista y que no corresponda a la representación de un pixbit erroneo
                    (if (and (list? pixbit-d) (not (equal? pixbit-d (list -1 -1 -1 -1 -1))))
                        (if (= (length pixbit-d) 5)
                            ;Comprobar que todos sean números
                            (if (and (number? (car pixbit-d)) (and (number? (cadr pixbit-d)) (and (number? (caddr pixbit-d)) (and (number? (cadddr pixbit-d)) (number? (car (cddddr pixbit-d)))))))
                                ;Comprobar que x,y,depth sean mayores o iguales a 0 y que el bit sea 0 o 1
                                (if (and (= 1 (car pixbit-d)) (and (<= 0 (cadr pixbit-d)) (and (<= 0 (caddr pixbit-d)) (and (or (= 0 (cadddr pixbit-d)) (= 1 (cadddr pixbit-d))) (<= 0 (car (cddddr pixbit-d)))))))
                                    #t
                                    #f
                                    )
                                #f
                                )
                            #f
                            )
                        #f
                        )))

;--------------------------------------------------------------------------------------------------------------------------------------------------


;-------------------------------------------------- Selectores ------------------------------------------------------------------------------------

;Función que obtiene el valor x de un pixbit-d
;Dominio: pixbit-d
;Recorrido: int
(define getpixbit.x (lambda (pixbit-d)
                      (if (pixbit-d? pixbit-d)      ;Comprobamos que la entrada sea un pixbit-d
                          (cadr pixbit-d)            ;Si lo es, entregamos lo requerido
                          -1                        ;Caso contrario entregamos un -1
                          )))                       ;Lo anterior se repite a todas las funciones selectoras
;Función que obtiene el valor y de un pixbit-d
;Dominio: pixbit-d
;Recorrido: int
(define getpixbit.y (lambda (pixbit-d)
                      (if (pixbit-d? pixbit-d)
                          (caddr pixbit-d)
                          -1
                          )))
;Función que obtiene el valor bit de un pixbit-d
;Dominio: pixbit-d
;Recorrido: int
(define getpixbit.bit (lambda (pixbit-d)
                      (if (pixbit-d? pixbit-d)
                          (cadddr pixbit-d)
                          -1
                          )))
;Función que obtiene el valor depth de un pixbit-d
;Dominio: pixbit-d
;Recorrido: int
(define getpixbit.depth (lambda (pixbit-d)
                      (if (pixbit-d? pixbit-d)
                          (car (cddddr pixbit-d))
                          -1
                          )))

;--------------------------------------------------------------------------------------------------------------------------------------------------


;-------------------------------------------------- Modificadores ---------------------------------------------------------------------------------

;Función que cambia el valor x de un pixbit-d
;Dominio: pixbit-d x int
;Recorrido: pixbit-d
(define changepixbit.x (lambda (pixbit-d x)
                         (if (pixbit-d? pixbit-d)      ;Comprobamos que la entrada 1 sea un pixbit-d
                             (if (number? x)           ;Comprobamos que la entrada 2 sea un número para no agregar algo que no debe agregarse
                                 (if (<= 0 x)          ;Comprobamos que además este número sea mayor o igual a 0
                                     (list 1 x (getpixbit.y pixbit-d) (getpixbit.bit pixbit-d) (getpixbit.depth pixbit-d))   ;Si todo se cumple retornamos el pixbit-d con el valor cambiado
                                     pixbit-d           
                                 )
                                 pixbit-d           ;Si el valor o no es un número o, de serlo, no es mayor o igual a 0, entonces se retorna el mismo pixbit-d que entro
                              )
                             (list -1 -1 -1 -1 -1)     ;Si lo que entro no es un pixbit-d entonces retornamos la representación de pixbit-d erroneo
                             )))                    ;Todo lo anterior se repite en las funciones changepixbit.y y changepixbit.depth

;Función que cambia el valor y de un pixbit-d
;Dominio: pixbit-d x int
;Recorrido: pixbit-d
(define changepixbit.y (lambda (pixbit-d y)
                         (if (pixbit-d? pixbit-d)
                             (if (number? y)
                                 (if (<= 0 y)
                                     (list 1 (getpixbit.x pixbit-d) y (getpixbit.bit pixbit-d) (getpixbit.depth pixbit-d))
                                     pixbit-d
                                     )
                                 pixbit-d
                                 )
                             (list -1 -1 -1 -1 -1)
                             )))

;Función que cambia el valor bit de un pixbit-d
;Dominio: pixbit-d x int
;Recorrido: pixbit-d
(define changepixbit.bit (lambda (pixbit-d bit)
                         (if (pixbit-d? pixbit-d)      ;Comprobamos que la entrada 1 corresponda a un pixbit-d
                             (if (number? bit)         ;Comprobamos que la entrada 2 corresponda a un número
                                 (if (or (= 0 bit) (= 1 bit))  ;Comprobamos que este número sea 0 o 1 (es un bit ciertamente)
                                     (list 1 (getpixbit.x pixbit-d) (getpixbit.y pixbit-d) bit (getpixbit.depth pixbit-d))  ;De cumplirse todo retornamos el pixbit-d con el cambio
                                     pixbit-d           
                                  )
                                 pixbit-d           ;Caso contrario si no es un número la segunda entrada o si no es 0 o 1 entonces retornamos el mismo pixbit-d sin cambios
                              )
                             (list -1 -1 -1 -1 -1)     ;Si lo que entro no es un pixbit-d entonces retornamos la representación de pixbit-d erroneo
                             )))

;Función que cambia el valor depth de un pixbit-d
;Dominio: pixbit-d x int
;Recorrido: pixbit-d
(define changepixbit.depth (lambda (pixbit-d depth)
                         (if (pixbit-d? pixbit-d)
                             (if (number? depth)
                                 (if (<= 0 depth)
                                     (list 1 (getpixbit.x pixbit-d) (getpixbit.y pixbit-d) (getpixbit.bit pixbit-d) depth)
                                     pixbit-d
                                 )
                                 pixbit-d
                             )
                             (list -1 -1 -1 -1 -1)
                             )))


;--------------------------------------------------------------------------------------------------------------------------------------------------



