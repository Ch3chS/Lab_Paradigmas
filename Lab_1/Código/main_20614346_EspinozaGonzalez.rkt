#lang racket

;-------------------------------------------------- Importaciones ------------------------------------------------------------------------------------

(require "TDAs/TDA_pixbit-d_20614346_EspinozaGonzalez.rkt")  ;TDA pixbit-d
(require "TDAs/TDA_pixrgb-d_20614346_EspinozaGonzalez.rkt")  ;TDA pixrgb-d
(require "TDAs/TDA_pixhex-d_20614346_EspinozaGonzalez.rkt")  ;TDA pixhex-d
(require "TDAs/TDA_image_20614346_EspinozaGonzalez.rkt")  ;TDA image

;-----------------------------------------------------------------------------------------------------------------------------------------------------


;-------------------------------------------------- 2.TDA image - constructor ------------------------------------------------------------------------

;Crea una imagen a partir de sus dimensiones y una serie de pixeles
;Entrada: int x int x [pixbit-d / pixrgb-d / pixhex-d] (Se pueden ingresar n del mismo tipo)
;Salida: image
(define image (lambda (Width Height . pixels)
                (if (and (number? Width) (number? Height))
                    (if (equal? pixels null)
                        (list Width Height pixels)
                        (if (pixbit-dlist? pixels)
                            (list Width Height pixels)   
                            (if (pixhex-dlist? pixels)
                                (list Width Height pixels)
                                (if (pixrgb-dlist? pixels)
                                    (list Width Height pixels)
                                    (list -1 -1 null)    ;Esta será la representación de una imagen erronea '(-1 -1 ())
                                    )
                                )
                            )
                        )
                    (list -1 -1 null)
                    )))

;-----------------------------------------------------------------------------------------------------------------------------------------------------


;-------------------------------------------------- 3.TDA image - bitmap? ----------------------------------------------------------------------------

;Función que dice si una imagen es o no u  bitmap
;Entrada: image
;Salida: booleano
(define bitmap? (lambda (image)
                  (if (image? image)
                      (if (not (equal? (getpixels image) null))
                          (pixbit-dlist? (getpixels image))
                          #f
                          )
                      #f
                      )))

;-----------------------------------------------------------------------------------------------------------------------------------------------------


;-------------------------------------------------- 4.TDA image - pixmap? ----------------------------------------------------------------------------

;Función que dice si una imagen es o no u  bitmap
;Entrada: image
;Salida: booleano
(define pixmap? (lambda (image)
                  (if (image? image)
                      (if (not (equal? (getpixels image) null))
                          (pixrgb-dlist? (getpixels image))
                          #f
                          )
                      #f
                      )))

;-----------------------------------------------------------------------------------------------------------------------------------------------------


;-------------------------------------------------- 5.TDA image - hexmap? ----------------------------------------------------------------------------

;Función que dice si una imagen es o no u  bitmap
;Entrada: image
;Salida: booleano
(define hexmap? (lambda (image)
                  (if (image? image)
                      (if (not (equal? (getpixels image) null))
                          (pixhex-dlist? (getpixels image))
                          #f
                          )
                      #f
                      )))

;-----------------------------------------------------------------------------------------------------------------------------------------------------



