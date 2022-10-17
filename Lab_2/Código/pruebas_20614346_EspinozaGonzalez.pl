:- use_module('./TDAs/TDA_histogram_20614346_EspinozaGonzalez.pl').
:- use_module('./TDAs/TDA_pixbit_20614346_EspinozaGonzalez.pl').
:- use_module('./TDAs/TDA_pixhex_20614346_EspinozaGonzalez.pl').
:- use_module('./TDAs/TDA_pixrgb_20614346_EspinozaGonzalez.pl').
:- use_module('./main_20614346_EspinozaGonzalez.pl').

% 2. Image
image1(I):- pixbit( 0, 0,1, 1, PA), pixbit( 0, 1, 0, 2, PB), pixbit( 1, 0, 0, 3, PC), pixbit( 1, 1, 1, 4, PD), image(2,2,[PA,PB,PC,PD],I),!.
image2(I):- pixrgb( 0, 0, 0, 0, 0, 1, PA), pixrgb( 0, 1, 255, 255, 255, 2, PB), pixrgb( 1, 0, 200, 100, 50, 3, PC), pixrgb( 1, 1, 255, 0, 120, 4, PD), image(2,2,[PA,PB,PC,PD],I),!.
image3(I):- pixhex( 0, 0,"a", 1, PA), pixhex( 0, 1, "b", 2, PB), pixhex( 1, 0, "c", 3, PC), pixhex( 1, 1, "d", 4, PD), image(2,2,[PA,PB,PC,PD],I),!.


% 3. imageIsBitmap
imageIsBitmap1(I):- image1(I) ,imageIsBitmap(I).


% 4. imageIsPixmap

% 5. imageIsHexmap

% 6. imageIsCompressed

% 7. imageFlipH

% 8. imageFlipV

% 9. imageCrop

% 10. imageRGBToHex

% 11. imageToHistogram

% 12. imageRotate90

% 13. imageCompress

% 14. changePixel

% 15. imageInvertColorRGB

% 16. imageToString

% 17. imageDepthLayers

% 18. imageDecompress