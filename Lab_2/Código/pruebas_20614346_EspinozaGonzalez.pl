:- use_module('./TDAs/TDA_histogram_20614346_EspinozaGonzalez.pl').
:- use_module('./TDAs/TDA_pixbit_20614346_EspinozaGonzalez.pl').
:- use_module('./TDAs/TDA_pixhex_20614346_EspinozaGonzalez.pl').
:- use_module('./TDAs/TDA_pixrgb_20614346_EspinozaGonzalez.pl').
:- use_module('./main_20614346_EspinozaGonzalez.pl').

% 2. Image
image1(I):- pixbit( 0, 0,1, 1, PA), pixbit( 0, 1, 0, 2, PB), pixbit( 1, 0, 0, 3, PC), pixbit( 1, 1, 1, 4, PD), image(2,2,[PA,PB,PC,PD],I),!.
image2(I):- pixrgb( 0, 0, 0, 0, 0, 1, PA), pixrgb( 0, 1, 255, 255, 255, 2, PB), pixrgb( 1, 0, 200, 100, 50, 3, PC), pixrgb( 1, 1, 255, 0, 120, 4, PD), image(2,2,[PA,PB,PC,PD],I),!.
image3(I):- pixhex( 0, 0,"a", 1, PA), pixhex( 0, 1, "b", 2, PB), pixhex( 1, 0, "c", 3, PC), pixhex( 1, 1, "d", 4, PD), image(2,2,[PA,PB,PC,PD],I),!.


image4(I):- pixrgb( 0, 0, 100, 100, 100, 1, PA), pixrgb( 0, 1, 200, 200, 200, 2, PB), pixrgb( 1, 0, 0, 0, 0, 3, PC), pixrgb( 1, 1, 255, 255, 255, 4, PD), image(2,2,[PA,PB,PC,PD],I),!.  % Estas 2 imagenes son para las 
image5(I):- pixrgb( 0, 0, 10, 10, 10, 1, PA), pixrgb( 0, 1, 20, 25, 30, 2, PB), pixrgb( 1, 0, 0, 255, 0, 3, PC), pixrgb( 1, 1, 125, 150, 170, 4, PD), image(2,2,[PA,PB,PC,PD],I),!.   % Pruebas de imageRGBToHex


% 3. imageIsBitmap
imageIsBitmap1():- image1(I) ,imageIsBitmap(I),!.
imageIsBitmap2():- image2(I) ,imageIsBitmap(I),!.
imageIsBitmap3():- image3(I) ,imageIsBitmap(I),!.


% 4. imageIsPixmap
imageIsPixmap1():- image1(I) ,imageIsPixmap(I),!.
imageIsPixmap2():- image2(I) ,imageIsPixmap(I),!.
imageIsPixmap3():- image3(I) ,imageIsPixmap(I),!.

% 5. imageIsHexmap
imageIsHexmap1():- image1(I) ,imageIsHexmap(I),!.
imageIsHexmap2():- image2(I) ,imageIsHexmap(I),!.
imageIsHexmap3():- image3(I) ,imageIsHexmap(I),!.

% 6. imageIsCompressed
imageIsCompressed1():- image1(I),imageIsCompressed(I),!.
imageIsCompressed2():- image2(I),imageIsCompressed(I),!.
imageIsCompressed3():- image3(I),imageIsCompressed(I),!.

% 7. imageFlipH
imageFlipH1(I2):- image1(I1),imageFlipH(I1,I2),!.
imageFlipH2(I2):- image2(I1),imageFlipH(I1,I2),!.
imageFlipH3(I2):- image3(I1),imageFlipH(I1,I2),!.

% 8. imageFlipV
imageFlipV1(I2):- image1(I1),imageFlipV(I1,I2),!.
imageFlipV2(I2):- image2(I1),imageFlipV(I1,I2),!.
imageFlipV3(I2):- image3(I1),imageFlipV(I1,I2),!.

% 9. imageCrop
imageCrop1(I2):- image1(I1), imageCrop(I1, 0, 0, 1, 1, I2),!.
imageCrop2(I2):- image2(I1), imageCrop(I1, 0, 1, 1, 1, I2),!.
imageCrop3(I2):- image3(I1), imageCrop(I1, 1, 0, 1, 1, I2),!.

% 10. imageRGBToHex
imageRGBToHex1(I2):- image2(I1), imageRGBToHex(I1,I2).
imageRGBToHex2(I2):- image4(I1), imageRGBToHex(I1,I2).
imageRGBToHex3(I2):- image5(I1), imageRGBToHex(I1,I2).

% 11. imageToHistogram
imageToHistogram1(H):- image1(I), imageToHistogram(I,H).
imageToHistogram2(H):- image2(I), imageToHistogram(I,H).
imageToHistogram3(H):- image3(I), imageToHistogram(I,H).

% 12. imageRotate90
imageRotate901(I2):- image1(I1), imageRotate90(I1,I2).
imageRotate902(I2):- image2(I1), imageRotate90(I1,I2).
imageRotate903(I2):- image3(I1), imageRotate90(I1,I2).

% 13. imageCompress
imageCompress1(I2):- image1(I1), imageCompress(I1,I2).
imageCompress2(I2):- image2(I1), imageCompress(I1,I2).
imageCompress3(I2):- image3(I1), imageCompress(I1,I2).

% 14. imageChangePixel
imageChangePixel1(I2):- image1(I1), pixbit(0,0,0,0,MP), imageChangePixel(I1,MP,I2).
imageChangePixel2(I2):- image2(I1), pixrgb(0,0,100,100,100,0,MP), imageChangePixel(I1,MP,I2).
imageChangePixel3(I2):- image3(I1), pixhex(0,0,"z",0,MP), imageChangePixel(I1,MP,I2).

% 15. imageInvertColorRGB
imageInvertColorRGB1(MP):- pixrgb( 0, 0, 0, 0, 0, 1, P), imageInvertColorRGB(P, MP).
imageInvertColorRGB2(MP):- pixrgb( 0, 1, 255, 255, 255, 2, P), imageInvertColorRGB(P, MP).
imageInvertColorRGB3(MP):- pixrgb( 1, 0, 200, 100, 50, 3, P), imageInvertColorRGB(P, MP).
imageInvertColorRGB4(MP):- pixrgb( 1, 1, 255, 0, 120, 4, P), imageInvertColorRGB(P, MP).

% 16. imageToString
imageToString1(String):- image1(I), imageToString(I,String).
imageToString2(String):- image2(I), imageToString(I,String).
imageToString3(String):- image3(I), imageToString(I,String).

% 17. imageDepthLayers
imageDepthLayers1(Img_list):- image1(I), imageDepthLayers(I,Img_list).
imageDepthLayers2(Img_list):- image2(I), imageDepthLayers(I,Img_list).
imageDepthLayers3(Img_list):- image3(I), imageDepthLayers(I,Img_list).

% 18. imageDecompress
imageDecompress1(I3):- image1(I1), imageCompress(I1,I2), imageDecompress(I2,I3).
imageDecompress2(I3):- image2(I1), imageCompress(I1,I2), imageDecompress(I2,I3).
imageDecompress3(I3):- image3(I1), imageCompress(I1,I2), imageDecompress(I2,I3).



/*   A CONTINUACION ESTAN LAS CONSULTAS ASOCIADAS AL SCRIPT DE PRUEBAS DEL ENUNCIADO

Probar que se puede generar una imagen pixbit
pixbit( 0, 0, 1, 10, PA), pixbit( 0, 1, 0, 20, PB), pixbit( 1, 0, 0, 30, PC), pixbit( 1, 1, 1, 4, PD), image( 2, 2, [PA, PB, PC, PD], I), imageIsBitmap(I), imageToString(I, Str),write(Str).

Probar que imageIsBitMap detecta cuando se tiene una imagen en hex o en rgb.
pixbit( 0, 0, 1, 10, PA), pixbit( 0, 1, 0, 20, PB), pixbit( 1, 0, 0, 30, PC), pixbit( 1, 1, 1, 4, PD), image( 2, 2, [PA, PB, PC, PD], I), imageIsBitmap( I ).

Estos casos deben dar false:
pixhex( 0, 0, "#FF0000", 10, PA), pixhex( 0, 1, "#FF0000", 20, PB), pixhex( 1, 0, "#0000FF", 30, PC), pixhex( 1, 1, "#0000FF", 4, PD), image( 2, 2, [PA, PB, PC, PD], I), imageIsBitmap( I ).
pixrgb( 0, 0, 200, 200, 200, 10, PA), pixrgb( 0, 1, 200, 200, 200, 20, PB), pixrgb( 1, 0, 190, 190, 190, 30, PC), pixrgb( 1, 1, 190, 190, 190, 4, PD), image( 2, 2, [PA, PB, PC, PD], I), imageIsBitmap( I ).

Probar que se puede generar una imagen pixhex
pixhex( 0, 0, "#FF0000", 10, PA), pixhex( 0, 1, "#FF0000", 20, PB), pixhex( 1, 0, "#0000FF", 30, PC), pixhex( 1, 1, "#0000FF", 4, PD), image( 2, 2, [PA, PB, PC, PD], I), imageToString(I, Str),write(Str).

Probar que imageIsHexmap detecta cuando se tiene una imagen en bit o en rgb.
pixhex( 0, 0, "#FF0000", 10, PA), pixhex( 0, 1, "#FF0000", 20, PB), pixhex( 1, 0, "#0000FF", 30, PC), pixhex( 1, 1, "#0000FF", 4, PD), image( 2, 2, [PA, PB, PC, PD], I), imageIsHexmap( I ).

Estos casos deben dar false:
pixbit( 0, 0, 1, 10, PA), pixbit( 0, 1, 0, 20, PB), pixbit( 1, 0, 0, 30, PC), pixbit( 1, 1, 1, 4, PD), image( 2, 2, [PA, PB, PC, PD], I), imageIsHexmap( I ).
pixrgb( 0, 0, 200, 200, 200, 10, PA), pixrgb( 0, 1, 200, 200, 200, 20, PB), pixrgb( 1, 0, 190, 190, 190, 30, PC), pixrgb( 1, 1, 190, 190, 190, 4, PD), image( 2, 2, [PA, PB, PC, PD], I), imageIsHexmap( I ).

Probar que se puede generar una imagen pixrgb
pixrgb( 0, 0, 255, 0, 0, 10, PA), pixrgb( 0, 1, 255, 0, 0, 20, PB), pixrgb( 1, 0, 0, 0, 255, 30, PC), pixrgb( 1, 1, 0, 0, 255, 4, PD), image( 2, 2, [PA, PB, PC, PD], I), imageToString(I, Str),write(Str).

Probar que imageIsPixmap detecta cuando se tiene una imagen en hex o en bit.
pixrgb( 0, 0, 200, 200, 200, 10, PA), pixrgb( 0, 1, 200, 200, 200, 20, PB), pixrgb( 1, 0, 190, 190, 190, 30, PC), pixrgb( 1, 1, 190, 190, 190, 4, PD), image( 2, 2, [PA, PB, PC, PD], I), imageIsPixmap( I ).

Estos casos deben dar false:
pixbit( 0, 0, 1, 10, PA), pixbit( 0, 1, 0, 20, PB), pixbit( 1, 0, 0, 30, PC), pixbit( 1, 1, 1, 4, PD), image( 2, 2, [PA, PB, PC, PD], I), imageIsPixmap( I ).
pixhex( 0, 0, "#FF0000", 10, PA), pixhex( 0, 1, "#FF0000", 20, PB), pixhex( 1, 0, "#0000FF", 30, PC), pixhex( 1, 1, "#0000FF", 4, PD), image( 2, 2, [PA, PB, PC, PD], I), imageIsPixmap( I ).

Convierte una imagen RGB a HEX y comprueba con los predicados de pertenencia, luego convierte a string y muestra por pantalla:
pixrgb( 0, 0, 200, 200, 200, 10, PA), pixrgb( 0, 1, 200, 200, 200, 20, PB), pixrgb( 1, 0, 190, 190, 190, 30, PC), pixrgb( 1, 1, 190, 190, 190, 4, PD), image( 2, 2, [PA, PB, PC, PD], I), imageIsPixmap( I ), imageRGBToHex(I, I2), imageIsHexmap(I2), imageToString(I2, Str), write(Str).

Comprime una imagen, luego descomprime y debe resultar la misma imagen original:
pixbit( 0, 0, 1, 10, PA), pixbit( 0, 1, 0, 20, PB), pixbit( 1, 0, 0, 30, PC), pixbit( 1, 1, 1, 4, PD), image( 2, 2, [PA, PB, PC, PD], I), imageCompress(I, I2), imageDecompress(I2, I3).
En el ejemplo anterior “I” debería ser igual a “I3”

Si se rota una imagen 4 veces en 90°, debería resultar la imagen original:
pixhex( 0, 0, "#FF0000", 10, PA), pixhex( 0, 1, "#FF0000", 20, PB), pixhex( 1, 0, "#0000FF", 30, PC), pixhex( 1, 1, "#0000FF", 4, PD), image( 2, 2, [PA, PB, PC, PD], I), imageRotate90(I, I2), imageRotate90(I2, I3), imageRotate90(I3, I4), imageRotate90(I4, I5).
En el ejemplo anterior “I” debería ser igual a “I5”

Si se rota una imagen en 90° que tiene el mismo color y profundidad en todos sus píxeles, entonces la imagen resultante debería ser la misma imagen original.
pixhex( 0, 0, "#FF0000", 30, PA), pixhex( 0, 1, "#FF0000", 30, PB), pixhex( 1, 0, "#FF0000", 30, PC), pixhex( 1, 1, "#FF0000", 30, PD), image( 2, 2, [PA, PB, PC, PD], I), imageRotate90(I, I2).
En el ejemplo anterior “I” debería ser igual a “I2”

Si se hace imageFlipV dos veces de una imagen, debería resultar la imagen original:
pixhex( 0, 0, "#FF0000", 10, PA), pixhex( 0, 1, "#FF0000", 20, PB), pixhex( 1, 0, "#0000FF", 30, PC), pixhex( 1, 1, "#0000FF", 4, PD), image( 2, 2, [PA, PB, PC, PD], I), imageFlipV(I, I2), imageFlipV(I2, I3).
En el ejemplo anterior “I” debería ser igual a “I3”

Si se hace imageFlipH dos veces de una imagen, debería resultar la imagen original:
pixhex( 0, 0, "#FF0000", 10, PA), pixhex( 0, 1, "#FF0000", 20, PB), pixhex( 1, 0, "#0000FF", 30, PC), pixhex( 1, 1, "#0000FF", 4, PD), image( 2, 2, [PA, PB, PC, PD], I), imageFlipH(I, I2), imageFlipH(I2, I3).
En el ejemplo anterior “I” debería ser igual a “I3”

Si se hace imageFlipH a una imagen que tiene el mismo color y profundidad en todos sus pixeles, entonces la imagen resultante debería ser la misma imagen original.
pixhex( 0, 0, "#FF0000", 30, PA), pixhex( 0, 1, "#FF0000", 30, PB), pixhex( 1, 0, "#FF0000", 30, PC), pixhex( 1, 1, "#FF0000", 30, PD), image( 2, 2, [PA, PB, PC, PD], I), imageFlipH(I, I2).
En el ejemplo anterior “I” debería ser igual a “I2”

Se crea una imagen de 3x3 pixeles y se corta en una de 2x2 con solo la esquina inferior izquierda:
pixhex( 0, 0, "#FF0000", 20, PA), pixhex( 0, 1, "#FF0000", 20, PB), pixhex( 0, 2, "#FF0000", 20, PC), pixhex( 1, 0, "#0000FF", 30, PD), pixhex( 1, 1, "#0000FF", 4, PE), pixhex( 1, 2, "#0000FF", 4, PF), pixhex( 2, 0, "#0000FF", 4, PG), pixhex( 2, 1, "#0000FF", 4, PH), pixhex( 2, 2, "#0000FF", 4, PI), image( 3, 3, [PA, PB, PC, PD, PE, PF, PG, PH, PI], I), imageCrop( I, 1, 1, 2, 2, I2), pixhex( 0, 0, "#0000FF", 4, PE2), pixhex( 0, 1, "#0000FF", 4, PF2), pixhex( 1, 0, "#0000FF", 4, PH2), pixhex( 1, 1, "#0000FF", 4, PI2), image( 2, 2, [PE2, PF2, PH2, PI2], I3).
En el ejemplo anterior, “I2” debería ser una imagen con los mismos pixeles y dimensiones que “I3”

Toma el píxel de la posición (0,1) que en la imagen original tiene los valores RGB (20, 20, 20) y lo reemplaza por otro píxel con valor RGB (54, 54, 54).
pixrgb( 0, 0, 10, 10, 10, 10, P1), pixrgb( 0, 1, 20, 20, 20, 20, P2), pixrgb( 1, 0, 30, 30, 30, 30, P3), pixrgb( 1, 1, 40, 40, 40, 40, P4), image( 2, 2, [P1, P2, P3, P4], I1), pixrgb( 0, 1, 54, 54, 54, 20, P2_modificado), imageChangePixel(I1, P2_modificado, I2).

Se construye imagen de 2x2 con los primeros 2 pixeles con profundidad 10 y los otros 2 con profundidad de 30, entonces al consultar “imageDepthLayers” se debería obtener una lista con dos imágenes.
pixrgb( 0, 0, 33, 33, 33, 10, PA), pixrgb( 0, 1, 44, 44, 44, 10, PB), pixrgb( 1, 0, 55, 55, 55, 30, PC), pixrgb( 1, 1, 66, 66, 66, 30, PD), image( 2, 2, [PA, PB, PC, PD], I), imageDepthLayers(I, [PRIMERA, SEGUNDA]), pixrgb( 0, 0, 33, 33, 33, 10, PA2), pixrgb( 0, 1, 44, 44, 44, 10, PB2), pixrgb( 1, 0, 255, 255, 255, 10, PC2), pixrgb( 1, 1, 255, 255, 255, 10, PD2), image( 2, 2, [PA2, PB2, PC2, PD2], I2), pixrgb( 0, 0, 255, 255, 255, 30, PA3), pixrgb( 0, 1, 255, 255, 255, 30, PB3), pixrgb( 1, 0, 55, 55, 55, 30, PC3), pixrgb( 1, 1, 66, 66, 66, 30, PD3), image( 2, 2, [PA3, PB3, PC3, PD3], I3).
En el ejemplo anterior, “I2” debería ser una imagen con los mismos pixeles y dimensiones que “PRIMERA”. “I3” debería ser una imagen con los mismos pixeles y dimensiones que “SEGUNDA”.


*/