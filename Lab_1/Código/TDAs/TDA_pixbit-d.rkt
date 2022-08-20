#lang racket

;-------------------------------------------------- Exportaciones ---------------------------------------------------------------------------------

(provide (all-defined-out))

;--------------------------------------------------------------------------------------------------------------------------------------------------




;-------------------------------------------------- Constructor -----------------------------------------------------------------------------------

;Función constructora que antes de crear el pixbit-d confirma que este vaya a ser efectivamente lo que corresponde
(define pixbit-d (lambda (x y bit depth)
                   (if (pixbit-d? (pixbitcont x y bit depth))
                       (pixbitcont x y bit depth)
                       (list -1 -1 -1 -1)               ;Esta será la representación de un pixbit erroneo (para cumplir con el recorrido)
                       )))

;Función que crea una lista a partir de ciertos parametros (idealmente un pixbit-d)
(define pixbitcont (lambda (x y bit depth) (list x y bit depth)))

;--------------------------------------------------------------------------------------------------------------------------------------------------


;-------------------------------------------------- Pertenencia -----------------------------------------------------------------------------------

(define pixbit-d? (lambda (pixbit-d)
                   (if (and (list? pixbit-d) (not (equal? pixbit-d (list -1 -1 -1 -1))))
                   (if (and (number? (car pixbit-d)) (and (number? (cadr pixbit-d)) (and (number? (caddr pixbit-d)) (number? (cadddr pixbit-d)))))
                   #t
                   #f
                   )
                   #f
                   )))

;--------------------------------------------------------------------------------------------------------------------------------------------------


;-------------------------------------------------- Selectores ------------------------------------------------------------------------------------

(define getpixbit.x (lambda (pixbit-d)
                      (if (pixbit-d? pixbit-d)
                          (car pixbit-d)
                          -1
                          )))

(define getpixbit.y (lambda (pixbit-d)
                      (if (pixbit-d? pixbit-d)
                          (cadr pixbit-d)
                          -1
                          )))

(define getpixbit.bit (lambda (pixbit-d)
                      (if (pixbit-d? pixbit-d)
                          (caddr pixbit-d)
                          -1
                          )))

(define getpixbit.depth (lambda (pixbit-d)
                      (if (pixbit-d? pixbit-d)
                          (cadddr pixbit-d)
                          -1
                          )))

;--------------------------------------------------------------------------------------------------------------------------------------------------


;-------------------------------------------------- Modificadores ---------------------------------------------------------------------------------

(define changepixbit.x (lambda (pixbit-d x)
                         (if (pixbit-d? pixbit-d)
                             (if (number? x)
                                 (list x (getpixbit.y pixbit-d) (getpixbit.bit pixbit-d) (getpixbit.depth pixbit-d))
                                 pixbit-d
                                 )
                             (list -1 -1 -1 -1)
                             )))

(define changepixbit.y (lambda (pixbit-d y)
                         (if (pixbit-d? pixbit-d)
                             (if (number? y)
                                 (list (getpixbit.x pixbit-d) y (getpixbit.bit pixbit-d) (getpixbit.depth pixbit-d))
                                 pixbit-d
                                 )
                             (list -1 -1 -1 -1)
                             )))

(define changepixbit.bit (lambda (pixbit-d bit)
                         (if (pixbit-d? pixbit-d)
                             (if (number? bit)
                                 (list (getpixbit.x pixbit-d) (getpixbit.y pixbit-d) bit (getpixbit.depth pixbit-d))
                                 pixbit-d
                                 )
                             (list -1 -1 -1 -1)
                             )))

(define changepixbit.depth (lambda (pixbit-d depth)
                         (if (pixbit-d? pixbit-d)
                             (if (number? depth)
                                 (list (getpixbit.x pixbit-d) (getpixbit.y pixbit-d) (getpixbit.bit pixbit-d) depth)
                                 pixbit-d
                                 )
                             (list -1 -1 -1 -1)
                             )))


;--------------------------------------------------------------------------------------------------------------------------------------------------



