#lang racket

(provide (all-defined-out))

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
                                (list 0 Width Height pixels (car (mostusedhex pixels)))
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
                   (list 0 (+ 1(- x2 x1)) (+ 1 (- y2 y1)) (discardpixels x2 x1 y2 y1 (getpixels image)) (mostused (getwidth image) (getheight image) (discardpixels x2 x1 y2 y1 (getpixels image))))
                   image
                   )))

;-----------------------------------------------------------------------------------------------------------------------------------------------------


;-------------------------------------------------- 10.TDA image - imgRGB->imgHex --------------------------------------------------------------------

;Función que transforma un pixmap a hexmap
;Entrada: image
;Salida: image
(define imgRGB->imgHex (lambda (image)
                         (if (not (compressed? image))
                             (list 0 (getwidth image) (getheight image) (pixelsrgb->pixelshex (getpixels image)) (mostusedrgb->mostusedhex image))
                             image  ;Si la imagen esta comprimida entonces no podemos operar sobre esta
                             )))

;-----------------------------------------------------------------------------------------------------------------------------------------------------


;-------------------------------------------------- 11.TDA image - histogram -------------------------------------------------------------------------

;Función que crea un histograma de frecuencias a partir de los colores de cada imagen
;Entrada: image
;Salida: histogram
(define histogram (lambda (image)
                    (filtrorep (histogramcont (getwidth image) (getheight image) (getpixels image))) ;Creamos el histograma en sí y filtramos los colores repetidos para una versión pulida del mismo
                    ))

(define filtrorep (lambda (histogram)
                    (if (not (equal? histogram null))
                        (cons (car (filtrorepfirst histogram)) (filtrorep (cdr (filtrorepfirst histogram))))
                        null
                        )
                    ))

;Función que descarta los elementos donde se repite el color del primero y retorna una lista sin estos
;Entrada: histogram
;Salida: histogram
(define filtrorepfirst (lambda (histogram)
                    (if (not (equal? histogram null))
                        (cons (car histogram) (filter (lambda (element) (not (equal? (car (car histogram)) (car element)))) (cdr histogram)))
                        null
                        )
                    ))


;Función que crea el histograma en si contando cuantas veces se repite un pixel de un color (Pero vuelve a contar el mismo con un elemento menos si este se repite)
;Entrada:
(define histogramcont (lambda (width height pixels)
                             (if (not (equal? pixels null))
                                 (if (pixbit-dlist? pixels)
                                     (list (list 0 (- (* width height) (countbit1 pixels))) (list 1 (countbit1 pixels)))
                                     (if (pixrgb-dlist? pixels)
                                         (cons (list (list (getpixrgb.r (car pixels)) (getpixrgb.g (car pixels)) (getpixrgb.b (car pixels))) (countfirstpixrgbcolor pixels)) (histogramcont width height (cdr pixels)))
                                         (cons (list (getpixhex.hex (car pixels)) (countfirstpixhexcolor pixels)) (histogramcont width height (cdr pixels)))
                                         )
                                     )
                                 null
                                 )
                             ))



;-----------------------------------------------------------------------------------------------------------------------------------------------------


;-------------------------------------------------- 12.TDA image - rotate90 --------------------------------------------------------------------------

;Función que permite rotar una imagen 90° a la derecha
;Entrada: image
;Salida: image
;Haciendo reiterados ejemplos en papel llegue a la conclusión de que los pixeles se rotan a la derecha de la forma x = y antigua invertida  e  y = x(antigua)
;Por supuesto el width y el height se invierten entre si al rotar 90 grados.
(define rotate90 (lambda (image)
                   (list 0 (getheight image) (getwidth image) (rotatepixels (getpixels (flipV image))) (getmostused image))  ;Notar que se invirtieron width y height; además la coordenada y se invirtio antes de pasar los pixeles a la siguiente función
                   ))

;Función que invierte las coordenadas x e y de los pixeles
;Entrada: pixels (puede ser pixbit-dlist, pixrgb-dlist o pixhex-dlist dependiendo de la imagen)
;Salida: pixels
(define rotatepixels (lambda (pixels)
                       (if (not (equal? pixels null))
                       (cons (rotatepixel (car pixels)) (rotatepixels (cdr pixels)))
                       null
                       )))

;Función que intercambia las coordenadas x e y de un pixel
;Entrada: pixel (pixbit-d, pixrgb-d o pixhex-d)
;Salida: pixel (del mismo tipo)
(define rotatepixel (lambda (pixel)
                      (if (pixbit-d? pixel)
                          (pixbit-d (getpixbit.y pixel) (getpixbit.x pixel) (getpixbit.bit pixel) (getpixbit.depth pixel))
                          (if (pixrgb-d? pixel)
                              (pixrgb-d (getpixrgb.y pixel) (getpixrgb.x pixel) (getpixrgb.r pixel) (getpixrgb.g pixel) (getpixrgb.b pixel) (getpixrgb.depth pixel))
                              (pixhex-d (getpixhex.y pixel) (getpixhex.x pixel) (getpixhex.hex pixel) (getpixhex.depth pixel))
                              )
                          )
                      ))

;-----------------------------------------------------------------------------------------------------------------------------------------------------


;-------------------------------------------------- 13.TDA image - compress --------------------------------------------------------------------------

;Función que permite comprimir una imagen eliminando los pixeles con el color más frecuente
;Entrada: image
;Salida: image  (Esta imagen debe ser descomprimida antes de poder ser manipulada)
(define compress (lambda (image)
                   (list 1 (getwidth image) (getheight image) (filter (lambda (pixel) ;Comienza la función de filtro
                                                                        (if (pixrgb-d? pixel)
                                                                            (not (and (and (= (car (getmostused image)) (getpixrgb.r pixel)) (= (cadr (getmostused image)) (getpixrgb.g pixel))) (= (caddr (getmostused image)) (getpixrgb.b pixel))))
                                                                            (if (pixbit-d? pixel)
                                                                                (not (= (getpixbit.bit pixel) (getmostused image)))
                                                                                (not (equal? (getpixhex.hex pixel) (getmostused image)))
                                                                                ))
                                                                        ) ;Aquí termina la función de filtro
                                                                      (getpixels image)) (getmostused image))
                   ))

;-----------------------------------------------------------------------------------------------------------------------------------------------------


;-------------------------------------------------- 14.TDA image - edit ------------------------------------------------------------------------------

;;FALTA MEJORAR PARA FILTRAR LA APLICACION DE LA FUNCION

;Función que permite aplicar otras funciones especiales
;Entrada: f x image
;Salida: image
(define edit (lambda (f image)
               (if (not (compressed? image))
               (list 0 (getwidth image) (getheight image) (apply f (getpixels image)) (getmostused image)) ;Falta actualizar el most used
               image
               )))

;Función que hace la aplicación en sí del filtro a los pixeles
;Recursión:
;Entrada: f x pixels
;Salida: pixels
(define apply (lambda (f pixels)
                (if (not (equal? pixels null))
                    (cons (f (car pixels)) (apply f (cdr pixels)))
                    null
                    )
                ))

;-----------------------------------------------------------------------------------------------------------------------------------------------------


;-------------------------------------------------- 15.TDA image - invertColorBit --------------------------------------------------------------------

;Función que cambia el valor del bit de un pixbit-d por el opuesto
;Entrada: pixbit-d
;Salida: pixbit-d
(define invertColorBit (lambda (pixbit-d)
                         (if (= (getpixbit.bit pixbit-d) 0)
                             (changepixbit.bit pixbit-d 1)
                             (changepixbit.bit pixbit-d 0)
                             )
                         ))

;-----------------------------------------------------------------------------------------------------------------------------------------------------


;-------------------------------------------------- 16.TDA image - invertColorRGB --------------------------------------------------------------------

;Función que cambia el valor rgb por el simetricamente opuesto en cada canal(r, g y b)
;Entrada: pixrgb-d
;Salida: pixrgb-d
(define invertColorRGB (lambda (pixrgb-d)
                         (changepixrgb.b (changepixrgb.g (changepixrgb.r pixrgb-d (- 255 (getpixrgb.r pixrgb-d))) (- 255 (getpixrgb.g pixrgb-d))) (- 255 (getpixrgb.b pixrgb-d)))
                         ))

;----------------------------------------------------------------------------------------------------------------------------------------------------


;-------------------------------------------------- 17.TDA image - adjustChannel --------------------------------------------------------------------

;Función que permite ajustar un canal de un pixel rgb a través de su funcion selectora, modificadora y la función con el cambio a aplicar en este
;Entrada: f1 x f2 x f3 x pixrgb-d
;Salida: pixrgb-d
(define adjustChannel (curry (lambda (f1 f2 f3  pixrgb-d)
                        (f2 pixrgb-d (f3 (f1 pixrgb-d)))
                        )))

;Función que incrementa el valor de un canal en una unidad
;Entrada: int
;Salida: int
(define incCh (lambda (int)
                 (if (= int 255)
                     0          ;Esto suponiendo que de 255 pase a 0 al incrementarse (no nos debe quedar 256 ya que no sería correcto)
                     (+ 1 int)
                     )))

;-----------------------------------------------------------------------------------------------------------------------------------------------------


;-------------------------------------------------- 18.TDA image - image->string ---------------------------------------------------------------------

;Función que transforma una imagen a su representación en string dependiendo de su tipo de pixeles
;Entrada: image x f  (f puede ser pixbit->string, pixrgb->string, pixhex->string)
;Salida: string
(define image->string (lambda (image f)
                       (string-append (organicerow (mappingrow (- (getwidth image) 1) (- (getheight image) 1) (getpixels image) f)))
                        ))

(define organicerow (lambda (stringlist)
                      (if (not (equal? stringlist null))
                       (string-append (organicerow (cdr stringlist)) (car stringlist) "\n")
                       ""
                       )
                      ))

;Ordena y convierte en string una fila de pixeles
;Entrada: int x int x image x f
;Salida: string-list
(define mappingrow (lambda (width height pixels f)
                     (if (not (= height -1))
                         (cons (organicecol (mappingcol width (filter (lambda (pixel) (= height (getpixel.y pixel))) pixels) f)) (mappingrow width (- height 1) pixels f))
                         null
                         )
                  ))

(define organicecol (lambda (stringlist)
                   (if (not (equal? stringlist null))
                       (string-append (organicecol (cdr stringlist)) (car stringlist) "\t")
                       ""
                       )
                   ))

;Ordena y convierte en string una columna de pixeles
;Entrada: int x int x image x f
;Salida: string-list
(define mappingcol (lambda (width pixels f)
                     (if (not (= width -1))
                         (if (not (equal? (filter (lambda (pixel) (= width (getpixel.x pixel))) pixels) null))
                         (cons (f (car (filter (lambda (pixel) (= width (getpixel.x pixel))) pixels))) (mappingcol (- width 1) pixels f))
                         (cons (f null) (mappingcol (- width 1) pixels f))
                         )
                         null
                         )
                  ))

(define pixbit->string (lambda (pixbit-d)
                         (if (not (equal? pixbit-d null))
                             (number->string (getpixbit.bit pixbit-d))
                             "0"
                             )))

(define pixrgb->string (lambda (pixrgb-d)
                         (if (not (equal? pixrgb-d null))
                             (string-append "(" (number->string (getpixrgb.r pixrgb-d)) " " (number->string (getpixrgb.g pixrgb-d)) " " (number->string (getpixrgb.b pixrgb-d)) ")")
                             "(255 255 255)"
                             )))


(define pixhex->string (lambda (pixhex-d)
                         (if (not (equal? pixhex-d null))
                         (getpixhex.hex pixhex-d)
                         "#FFFFFF"
                         )))

;-----------------------------------------------------------------------------------------------------------------------------------------------------


;-------------------------------------------------- 19.TDA image - depthLayers --------------------------------------------------------------------

;Función que separa la imagen en capas a partir de la profundidad (los pixeles faltantes en una capa son reemplazados por pixeles blancos)
;Entrada: image
;Salida: image list
(define depthLayers (lambda (image)
                      (layerpixels image (getpixels image) (getmaxdepth (getpixels image)))
                      ))

(define getmaxdepth (lambda (pixels)
                      (if (not (equal? pixels null))
                          (if (> (getpixel.depth (car pixels)) (getmaxdepth (cdr pixels)))
                              (getpixel.depth (car pixels))
                              (getmaxdepth (cdr pixels))
                              )
                          0
                          )
                      ))

(define layerpixels (lambda (image pixels maxdepth)
                      (if (not (= maxdepth -1))
                      (cons (list 0 (getwidth image) (getheight image) (getlayer pixels maxdepth) 0) (layerpixels image pixels (- maxdepth 1)))
                      null
                      )))

(define getlayer (lambda (pixels depth)
                   (filter (lambda (pixel) (= depth (getpixel.depth pixel))) pixels)
                   ))

(define getpixel.depth (lambda (pixel) (car (cddddr pixel))))
;-----------------------------------------------------------------------------------------------------------------------------------------------------


;-------------------------------------------------- 20.TDA image - decompress --------------------------------------------------------------------

;Función que permite descomprimir una imagen comprimida tomando como referencia el valor que era más frecuente
;Entrada: image
;Salida: image
(define decompress (lambda (image)
                     (if (compressed? image)
                         (list 0 (getwidth image) (getheight image) (fillwithcolor (getwidth image) (getheight image) (getpixels image) (getmostused image)) (getmostused image))
                         image ;Si la imagen no esta comprimida la retornamos tal como está
                         )))

(define fillwithcolor (lambda (width height pixels color)
                         (if (not (= height -1))
                         (append (fillwithcolor2 width height pixels color) (fillwithcolor width (- height 1) pixels color))
                         null
                         )
                        ))

(define fillwithcolor2 (lambda (width height pixels color)
                         (if (not (= width -1))
                             (if (equal? (filter (lambda (pixel) (and (= width (getpixel.x pixel)) (= height (getpixel.y pixel)))) pixels) null)
                                         (if (string? color)
                                             (cons (pixhex-d width height color 0) (fillwithcolor2 (- width 1) height pixels color))
                                             (if (number? color)
                                                 (cons (pixbit-d width height color 0) (fillwithcolor2 (- width 1) height pixels color))
                                                 (cons (pixrgb-d width height (car color) (cadr color) (caddr color) 0) (fillwithcolor2 (- width 1) height pixels color))
                                                 )
                                             )
                                         (cons (car (filter (lambda (pixel) (and (= width (getpixel.x pixel))) (= height (getpixel.y pixel))) pixels)) (fillwithcolor2 (- width 1) height pixels color))
                                         )
                                 null
                                 )
                             ))

;-----------------------------------------------------------------------------------------------------------------------------------------------------