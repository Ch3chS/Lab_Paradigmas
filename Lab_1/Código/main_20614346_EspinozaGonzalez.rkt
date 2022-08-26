#lang racket


;-------------------------------------------------- Importaciones ------------------------------------------------------------------------------------

(require "TDAs/TDA_pixbit-d_20614346_EspinozaGonzalez.rkt")  ;TDA pixbit-d
(require "TDAs/TDA_pixrgb-d_20614346_EspinozaGonzalez.rkt")  ;TDA pixrgb-d
(require "TDAs/TDA_pixhex-d_20614346_EspinozaGonzalez.rkt")  ;TDA pixhex-d
(require "TDAs/TDA_pixels_20614346_EspinozaGonzalez.rkt")  ;TDA pixels
(require "TDAs/TDA_image_20614346_EspinozaGonzalez.rkt")  ;TDA image

;-----------------------------------------------------------------------------------------------------------------------------------------------------


;--------------------------------------------------------------------------------------------------------------------------------------------------
;----------------------------------------------------------- TDA ----------------------------------------------------------------------------------
;-----------------------------------------------------------image----------------------------------------------------------------------------------
;--------------------------------------------------------------------------------------------------------------------------------------------------

;La representación estará dada por una lista la cual constara con el formato (int x int x int x list x int) de la siguiente forma:

;(compressed?(0|1) ,x>0, y>0, pixels, muc(most-used-color))

;--------------------------------------------------------------------------------------------------------------------------------------------------


;-------------------------------------------------- 2.TDA image - constructor ------------------------------------------------------------------------

;Crea una imagen a partir de sus dimensiones y una serie de pixeles
;Entrada: int x int x [pixbit-d / pixrgb-d / pixhex-d] (Se pueden ingresar n del mismo tipo)
;Salida: image
(define image (lambda (Width Height . pixels)
                (if (and (number? Width) (number? Height))
                    (if (equal? pixels null)
                        (list 0 Width Height pixels 0)
                        (if (pixbit-dlist? pixels)
                            (list 0 Width Height pixels (mostusedbit Width Height pixels))   
                            (if (pixhex-dlist? pixels)
                                (list 0 Width Height pixels 0)
                                (if (pixrgb-dlist? pixels)
                                    (list 0 Width Height pixels (car (mostusedrgb pixels)))
                                    (list -1 -1 -1 null -1)    ;Esta será la representación de una imagen erronea '(-1 -1 () -1)
                                    )
                                )
                            )
                        )
                    (list -1 -1 -1 null -1)
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

;Función que dice si una imagen es o no u  pixmap
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

;Función que dice si una imagen es o no u  hexmap
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


;-------------------------------------------------- 6.TDA image - compressed? ------------------------------------------------------------------------

;Función que determina si una imagen esta comprimida (Por la especificación del TDA imagen se vuelve bastante sencilla)
;Entrada: image
;Salida: booleano
(define compressed? (lambda (image)
                      (if (= 1 (getcompressed image))   ;Si el primer elemento de la imagen (compressed) es 1 significa que la imagen esta comprimida
                          #t
                          #f                            ;Si este fuera 0 o -1 significa que la imagen no esta comprimida o que nisiquiera es una imagen por lo que tampoco lo estaría
                          )
                      ))

;-----------------------------------------------------------------------------------------------------------------------------------------------------


;-------------------------------------------------- 7.TDA image - flipH ------------------------------------------------------------------------------

;Función que permite invertir una imagen horizontalmente
;Entrada: image
;Salida: image
(define flipH (lambda (image)
                (if (not (compressed? image))
                    (list 0 (getwidth image) (getheight image) (flippixels 1 (getwidth image) (getpixels image)) (getmostused image))
                    image
                    )
                ))

;-----------------------------------------------------------------------------------------------------------------------------------------------------


;-------------------------------------------------- 8.TDA image - flipV ------------------------------------------------------------------------------

;Función que permite invertir una imagen verticalmente
;Entrada: image
;Salida: image
(define flipV (lambda (image)
                (if (not (compressed? image))
                    (list 0 (getwidth image) (getheight image) (flippixels 2 (getheight image) (getpixels image)) (getmostused image))
                    image
                    )
                ))

;-----------------------------------------------------------------------------------------------------------------------------------------------------


;-------------------------------------------------- 9.TDA image - crop -------------------------------------------------------------------------------

;Función que permite recortar una imagen a partir de un cuadrante
;Entrada: image x X1(int) x Y1(int) x X2(int) x Y2(int) 
;Salida: image
(define crop (lambda (image x1 y1 x2 y2)
               (if (not (compressed? image))
                   (list 0 (- x2 x1) (- y2 y1) (discardpixels x2 x1 y2 y1 (getpixels image)) (mostused (discardpixels x2 x1 y2 y1 (getpixels image))))
                   image
                   )))

;-----------------------------------------------------------------------------------------------------------------------------------------------------


;-------------------------------------------------- 10.TDA image - imgRGB->imgHEX --------------------------------------------------------------------

;Función que transforma un pixmap a hexmap
;Entrada: image
;Salida: image
(define imgRGB->imgHEX (lambda (image)
                         (if (not (compressed? image))
                             (list 0 (getwidth image) (getheight image) (pixelsrgb->pixelshex (getpixels image)) (mostusedrgb->mostusedhex image))
                             image  ;Si la imagen esta comprimida entonces no podemos operar sobre esta
                             )))

;-----------------------------------------------------------------------------------------------------------------------------------------------------


;-------------------------------------------------- 11.TDA image - histogram -------------------------------------------------------------------------

;Función que crea un histograma de frecuencias a partir de los colores de cada imagen
;Entrada: image
;Salida: histogram
#|
(define histogram (lambda (image)
                    
                    ))
|#
;-----------------------------------------------------------------------------------------------------------------------------------------------------


;-------------------------------------------------- 12.TDA image - rotate90 --------------------------------------------------------------------------

;Función que permite rotar una imagen 90° a la derecha
;Entrada: image
;Salida: image


;-----------------------------------------------------------------------------------------------------------------------------------------------------


;-------------------------------------------------- 13.TDA image - compress --------------------------------------------------------------------------

;Función que permite comprimir una imagen eliminando los pixeles con el color más frecuente
;Entrada: image
;Salida: image  (Esta imagen debe ser descomprimida antes de poder ser manipulada)


;-----------------------------------------------------------------------------------------------------------------------------------------------------


;-------------------------------------------------- 14.TDA image - edit ------------------------------------------------------------------------------

;Función que permite aplicar otras funciones especiales
;Entrada: f x image
;Salida: image


;-----------------------------------------------------------------------------------------------------------------------------------------------------


;-------------------------------------------------- 15.TDA image - invertColorBit --------------------------------------------------------------------

;Función que cambia el valor del bit de un pixbit-d por el opuesto
;Entrada: pixbit-d
;Salida: pixbit-d


;-----------------------------------------------------------------------------------------------------------------------------------------------------


;-------------------------------------------------- 16.TDA image - invertColorRGB --------------------------------------------------------------------

;Función que cambia el valor rgb por el simetricamente opuesto en cada canal(r, g y b)
;Entrada: pixrgb-d
;Salida: pixrgb-d


;----------------------------------------------------------------------------------------------------------------------------------------------------


;-------------------------------------------------- 17.TDA image - adjustChannel --------------------------------------------------------------------

;Función que permite ajustar un canal de un pixel rgb a través de su funcion selectora, modificadora y la función con el cambio a aplicar en este
;Entrada: f1 x f2 x f3 x pixrgb-d
;Salida: pixrgb-d


;-----------------------------------------------------------------------------------------------------------------------------------------------------


;-------------------------------------------------- 18.TDA image - image->string ---------------------------------------------------------------------

;Función que transforma una imagen a su representación en string dependiendo de su tipo de pixeles
;Entrada: image x f  (f puede ser pixbit->string, pixrgb->string, pixhex->string)
;Salida: string


;-----------------------------------------------------------------------------------------------------------------------------------------------------


;-------------------------------------------------- 19.TDA image - depthLayers --------------------------------------------------------------------

;Función que separa la imagen en capas a partir de la profundidad (los pixeles faltantes en una capa son reemplazados por pixeles blancos)
;Entrada: image
;Salida: image list


;-----------------------------------------------------------------------------------------------------------------------------------------------------


;-------------------------------------------------- 20.TDA image - decompress --------------------------------------------------------------------

;Función que permite descomprimir una imagen comprimida tomando como referencia el valor que era más frecuente
;Entrada: image
;Salida: image


;-----------------------------------------------------------------------------------------------------------------------------------------------------