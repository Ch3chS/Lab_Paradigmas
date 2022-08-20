#lang racket

;-------------------------------------------------- Exportaciones ---------------------------------------------------------------------------------

(provide (all-defined-out))

;--------------------------------------------------------------------------------------------------------------------------------------------------




;-------------------------------------------------- Constructor -----------------------------------------------------------------------------------

;Función constructora que antes de crear el pixbit-d confirma que este vaya a ser efectivamente lo que corresponde
(define pixhex-d (lambda (x y hex depth)
                   (if (pixhex-d? (pixhexcont x y hex depth))
                       (pixhexcont x y hex depth)
                       (list -1 -1 "" -1)               ;Esta será la representación de un pixhex erroneo (para cumplir con el recorrido)
                       )))

;Función que crea una lista a partir de ciertos parametros (idealmente un pixbit-d)
(define pixhexcont (lambda (x y hex depth) (list x y hex depth)))

;--------------------------------------------------------------------------------------------------------------------------------------------------


;-------------------------------------------------- Pertenencia -----------------------------------------------------------------------------------

(define pixhex-d? (lambda (pixhex-d)
                   (if (and (list? pixhex-d) (not (equal? pixhex-d (list -1 -1 "" -1))))
                   (if (and (number? (car pixhex-d)) (and (number? (cadr pixhex-d)) (and (string? (caddr pixhex-d)) (number? (cadddr pixhex-d)))))
                   #t
                   #f
                   )
                   #f
                   )))

;--------------------------------------------------------------------------------------------------------------------------------------------------


;-------------------------------------------------- Selectores ------------------------------------------------------------------------------------

(define getpixhex.x (lambda (pixhex-d)
                      (if (pixhex-d? pixhex-d)
                          (car pixhex-d)
                          -1
                          )))

(define getpixhex.y (lambda (pixhex-d)
                      (if (pixhex-d? pixhex-d)
                          (cadr pixhex-d)
                          -1
                          )))

(define getpixhex.hex (lambda (pixhex-d)
                      (if (pixhex-d? pixhex-d)
                          (caddr pixhex-d)
                          ""
                          )))

(define getpixhex.depth (lambda (pixhex-d)
                      (if (pixhex-d? pixhex-d)
                          (cadddr pixhex-d)
                          -1
                          )))

;--------------------------------------------------------------------------------------------------------------------------------------------------


;-------------------------------------------------- Modificadores ---------------------------------------------------------------------------------

(define changepixhex.x (lambda (pixhex-d x)
                         (if (pixhex-d? pixhex-d)
                             (if (number? x)
                                 (list x (getpixhex.y pixhex-d) (getpixhex.hex pixhex-d) (getpixhex.depth pixhex-d))
                                 pixhex-d
                                 )
                             (list -1 -1 "" -1)
                             )))

(define changepixhex.y (lambda (pixhex-d y)
                         (if (pixhex-d? pixhex-d)
                             (if (number? y)
                                 (list (getpixhex.x pixhex-d) y (getpixhex.hex pixhex-d) (getpixhex.depth pixhex-d))
                                 pixhex-d
                                 )
                             (list -1 -1 "" -1)
                             )))

(define changepixhex.hex (lambda (pixhex-d hex)
                         (if (pixhex-d? pixhex-d)
                             (if (string? hex)
                                 (list (getpixhex.x pixhex-d) (getpixhex.y pixhex-d) hex (getpixhex.depth pixhex-d))
                                 pixhex-d
                                 )
                             (list -1 -1 "" -1)
                             )))

(define changepixhex.depth (lambda (pixhex-d depth)
                         (if (pixhex-d? pixhex-d)
                             (if (number? depth)
                                 (list (getpixhex.x pixhex-d) (getpixhex.y pixhex-d) (getpixhex.hex pixhex-d) depth)
                                 pixhex-d
                                 )
                             (list -1 -1 "" -1)
                             )))


;--------------------------------------------------------------------------------------------------------------------------------------------------