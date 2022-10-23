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