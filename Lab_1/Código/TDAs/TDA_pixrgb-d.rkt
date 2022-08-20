#lang racket


;-------------------------------------------------- Exportaciones ---------------------------------------------------------------------------------

(provide (all-defined-out))

;--------------------------------------------------------------------------------------------------------------------------------------------------




;-------------------------------------------------- Constructor -----------------------------------------------------------------------------------

;Función constructora que antes de crear el pixbit-d confirma que este vaya a ser efectivamente lo que corresponde
(define pixrgb-d (lambda (x y r g b depth)
                   (if (pixrgb-d? (pixrgbcont x y r g b depth))
                       (pixrgbcont x y r g b depth)
                       (list -1 -1 -1 -1 -1 -1)               ;Esta será la representación de un pixrgb erroneo (para cumplir con el recorrido)
                       )))

;Función que crea una lista a partir de ciertos parametros (idealmente un pixbit-d)
(define pixrgbcont (lambda (x y r g b depth) (list x y r g b depth)))

;--------------------------------------------------------------------------------------------------------------------------------------------------


;-------------------------------------------------- Pertenencia -----------------------------------------------------------------------------------

(define pixrgb-d? (lambda (pixrgb-d)
                    ;Comprobar que sea una lista y que no sea igual a la representación de un pixrgb erroneo
                   (if (and (list? pixrgb-d) (not (equal? pixrgb-d (list -1 -1 -1 -1 -1 -1))))
                       
                       ;Comprobar que todos sean números
                       (if (and (number? (car pixrgb-d)) (and (number? (cadr pixrgb-d)) (and (number? (caddr pixrgb-d)) (and (number? (cadddr pixrgb-d)) (and (number? (car(cddddr pixrgb-d))) (number? (cadr(cddddr pixrgb-d))))))))

                           ;Comprobar que r,g,b esten entre 0 y 255 y que x,y,depth sean iguales o mayores que 0
                           (if (and (and (and (<= 0 (car pixrgb-d)) (<= 0 (cadr pixrgb-d))) (and (<= 0 (caddr pixrgb-d)) (>= 255 (caddr pixrgb-d)))) (and (and (<= 0 (cadddr pixrgb-d)) (>= 255 (cadddr pixrgb-d))) (and (and (<= 0 (car(cddddr pixrgb-d))) (>= 255 (car(cddddr pixrgb-d)))) (<= 0 (cadr(cddddr pixrgb-d))))))
                            #t
                            #f
                            )
                           #f
                           )
                       #f
                   )))

;--------------------------------------------------------------------------------------------------------------------------------------------------


;-------------------------------------------------- Selectores ------------------------------------------------------------------------------------

(define getpixrgb.x (lambda (pixrgb-d)
                      (if (pixrgb-d? pixrgb-d)
                          (car pixrgb-d)
                          -1
                          )))

(define getpixrgb.y (lambda (pixrgb-d)
                      (if (pixrgb-d? pixrgb-d)
                          (cadr pixrgb-d)
                          -1
                          )))

(define getpixrgb.r (lambda (pixrgb-d)
                      (if (pixrgb-d? pixrgb-d)
                          (caddr pixrgb-d)
                          -1
                          )))

(define getpixrgb.g (lambda (pixrgb-d)
                      (if (pixrgb-d? pixrgb-d)
                          (cadddr pixrgb-d)
                          -1
                          )))

(define getpixrgb.b (lambda (pixrgb-d)
                      (if (pixrgb-d? pixrgb-d)
                          (car(cddddr pixrgb-d))
                          -1
                          )))

(define getpixrgb.depth (lambda (pixrgb-d)
                      (if (pixrgb-d? pixrgb-d)
                          (cadr(cddddr pixrgb-d))
                          -1
                          )))

;--------------------------------------------------------------------------------------------------------------------------------------------------


;-------------------------------------------------- Modificadores ---------------------------------------------------------------------------------

(define changepixrgb.x (lambda (pixrgb-d x)
                         (if (pixrgb-d? pixrgb-d)
                             (if (number? x)
                                 (if (<= 0 x)
                                     (list x (getpixrgb.y pixrgb-d) (getpixrgb.r pixrgb-d) (getpixrgb.g pixrgb-d) (getpixrgb.b pixrgb-d) (getpixrgb.depth pixrgb-d))
                                     pixrgb-d
                                 )
                                 pixrgb-d
                                 )
                             (list -1 -1 -1 -1 -1 -1)
                             )))

(define changepixrgb.y (lambda (pixrgb-d y)
                         (if (pixrgb-d? pixrgb-d)
                             (if (number? y)
                                 (if (<= 0 y)
                                     (list (getpixrgb.x pixrgb-d) y (getpixrgb.r pixrgb-d) (getpixrgb.g pixrgb-d) (getpixrgb.b pixrgb-d) (getpixrgb.depth pixrgb-d))
                                     pixrgb-d
                                 )
                                 pixrgb-d
                                 )
                             (list -1 -1 -1 -1 -1 -1)
                             )))

(define changepixrgb.r (lambda (pixrgb-d r)
                         (if (pixrgb-d? pixrgb-d)
                             (if (number? r)
                                 (if (and (<= 0 r) (>= 255 r))
                                     (list (getpixrgb.x pixrgb-d) (getpixrgb.y pixrgb-d) r (getpixrgb.g pixrgb-d) (getpixrgb.b pixrgb-d) (getpixrgb.depth pixrgb-d))
                                     pixrgb-d
                                 )
                                 pixrgb-d
                                 )
                             (list -1 -1 -1 -1 -1 -1)
                             )))

(define changepixrgb.g (lambda (pixrgb-d g)
                         (if (pixrgb-d? pixrgb-d)
                             (if (number? g)
                                 (if (and (<= 0 g) (>= 255 g))
                                     (list (getpixrgb.x pixrgb-d) (getpixrgb.y pixrgb-d) (getpixrgb.r pixrgb-d) g (getpixrgb.b pixrgb-d) (getpixrgb.depth pixrgb-d))
                                     pixrgb-d
                                 )
                                 pixrgb-d
                                 )
                             (list -1 -1 -1 -1 -1 -1)
                             )))

(define changepixrgb.b (lambda (pixrgb-d b)
                         (if (pixrgb-d? pixrgb-d)
                             (if (number? b)
                                 (if (and (<= 0 b) (>= 255 b))
                                     (list (getpixrgb.x pixrgb-d) (getpixrgb.y pixrgb-d) (getpixrgb.r pixrgb-d) (getpixrgb.g pixrgb-d) b (getpixrgb.depth pixrgb-d))
                                     pixrgb-d
                                 )
                                 pixrgb-d
                                 )
                             (list -1 -1 -1 -1 -1 -1)
                             )))

(define changepixrgb.depth (lambda (pixrgb-d depth)
                         (if (pixrgb-d? pixrgb-d)
                             (if (number? depth)
                                 (if (<= 0 depth)
                                     (list (getpixrgb.x pixrgb-d) (getpixrgb.y pixrgb-d) (getpixrgb.r pixrgb-d) (getpixrgb.g pixrgb-d) (getpixrgb.b pixrgb-d) depth)
                                     pixrgb-d
                                 )
                                 pixrgb-d
                                 )
                             (list -1 -1 -1 -1 -1 -1)
                             )))

;--------------------------------------------------------------------------------------------------------------------------------------------------



