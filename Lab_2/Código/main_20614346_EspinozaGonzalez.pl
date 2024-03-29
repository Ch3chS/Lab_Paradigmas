:- module(main, [image/4, imageIsBitmap/1, imageIsPixmap/1, imageIsHexmap/1, imageIsCompressed/1, imageFlipH/2, imageFlipV/2, imageCrop/6, imageRGBToHex/2, imageToHistogram/2, imageRotate90/2, imageCompress/2, imageChangePixel/3, imageInvertColorRGB/2, imageToString/2, imageDepthLayers/2, imageDecompress/2]).
:- use_module('./TDAs/TDA_histogram_20614346_EspinozaGonzalez.pl').
:- use_module('./TDAs/TDA_pixbit_20614346_EspinozaGonzalez.pl').
:- use_module('./TDAs/TDA_pixhex_20614346_EspinozaGonzalez.pl').
:- use_module('./TDAs/TDA_pixrgb_20614346_EspinozaGonzalez.pl').

% ---------------------------------------------- Documentación ------------------------------------------------

% ----- Dominios -------
% Natural:                  Número >= 0
% Bit:                      Número == 0 ; Número == 1
% RGB:                      Lista [0 <= Número <= 255, 0 <= Número <= 255, 0 <= Número <= 255]
% Color:                    Bit ; String ; RGB
% Pixel:                    Lista [Natural,Natural,Color,Natural]
% Pixrgb:                   Lista [Natural,Natural,RGB,Natural]
% PixHex:                   Lista [Natural,Natural,String,Natural]
% Pixeles:                  Lista [Pixel|Pixeles]
% Image:                    Lista [Bit, Natural, Natural, Pixels, Color]
% Histogram:                Lista [] ; Lista [[Color,Natural]|Histogram]
% Image_list:               Lista [] ; Lista [Image, Image_list]
% String:                   String


% ----- Predicados -----
% image(Natural, Natural, Pixels, Image)                                   aridad: 4
% imageIsBitmap(Image)                                                     aridad: 1
% imageIsPixmap(Image)                                                     aridad: 1
% imageIsHexmap(Image)                                                     aridad: 1
% imageIsCompressed(Image)                                                 aridad: 1
% imageFlipH(Image, Image)                                                 aridad: 2
% imageFlipV(Image, Image)                                                 aridad: 2
% imageCrop(Image, Natural, Natural, Natural, Natural, Image)              aridad: 6
% imageRGBToHex(Image, Image)                                              aridad: 2
% imageToHistogram(Image, Histogram)                                       aridad: 2
% imageRotate90(Image, Image)                                              aridad: 2
% imageCompress(Image, Image)                                              aridad: 2
% imageChangePixel(Image, Pixel, Image)                                    aridad: 3
% imageInvertColorRGB(Pixrgb, Pixrgb)                                      aridad: 2
% imageToString(Image, String)                                             aridad: 2
% imageDepthLayers(Image, Image_list)                                      aridad: 2
% imageDecompress(Image, Image)                                            aridad: 2
% discardPixels(Pixeles, X1, Y1, X2, Y2, Pixeles)                          aridad: 6
% pixrgbToPixhex(Pixrgb, Pixhex)                                           aridad: 2
% pixelsrgbToPixelshex(Pixeles, Pixeles)                                   aridad: 2
% swapXY(Pixeles, Pixeles)                                                 aridad: 2
% discardPixelsOutRow(Pixeles, Natural, Pixeles)                           aridad: 3
% colToString(Pixeles, String)                                             aridad: 2
% rowToString(Natural, Natural, Pixeles, String)                           aridad: 4
% discardPixelsOutDepth(Pixeles, Natural, Pixeles)                         aridad: 3
% restoreRow(Natural, Natural, Natural, Pixeles, Color, Pixeles)           aridad: 6
% restorePixels(Natural, Natural, Natural, Pixeles, Color, Pixeles)        aridad: 6


% ----- Metas ----------
%     Primarias
% image(Width, Height, Pixels, Image)
% imageIsBitmap(Image)
% imageIsPixmap(Image)
% imageIsHexmap(Image)
% imageIsCompressed(Image)
% imageFlipH(ImageIn, ImageOut)
% imageFlipV(ImageIn, ImageOut)
% imageCrop(ImageIn, X1, Y1, X2, Y2, CroppedImage)
% imageRGBToHex(Pixmap, Hexmap)
% imageToHistogram(Image, Histogram)
% imageRotate90(ImageIn, RotatedImage)
% imageCompress(ImageIn, CompressedImage)
% imageChangePixel(ImageIn, Pixel, ImageOut)
% imageInvertColorRGB(Pixrgb, Pixrgb)
% imageToString(Image, String)
% imageDepthLayers(ImageIn, List_of_layers)
% imageDecompress(CompressedImage, Image)

%    Secundarias
% discardPixels(PixelsIn, X1, Y1, X2, Y2, PixelsOut)
% pixrgbToPixhex(Pixrgb, Pixhex)
% pixelsrgbToPixelshex(RGB_Pixels, Hex_Pixels)
% swapXY(PixelsIn, PixelsOut)
% discardPixelsOutRow(PixelsIn, Row, PixelsOut)
% colToString(Pixels, String)
% rowToString(Row,Height,Pixels,StringOut)
% discardPixelsOutDepth(PixelsIn, Depth, PixelsOut)
% restoreRow(Column, Row, Width, Pixels_in_row, MostUsed, PixelsOut)
% restorePixels(Row, Width, Height, PixelsIn, MostUsed, PixelsOut)
 
% -------------------------------------------------------------------------------------------------------------


% --------------------------------------------------------------------- Clausulas de Horn ------------------------------------------------------------------------

% ------------------------------------------------------ Reglas ----------------------------------------------------------------

% ---------------------------------- 2. Constructor Image -----------------------------------------------

image(Width, Height, Pixels, [0, Width, Height, Pixels1, MostUsed]):- number(Width), number(Height), is_list(Pixels),
 0 @=< Width, 0 @=< Height, mostUsed(Pixels, MostUsed), sort(Pixels, Pixels1),
 (pixbit_list(Pixels);pixrgb_list(Pixels);pixhex_list(Pixels)),!.

% -------------------------------------------------------------------------------------------------------


% ------------------------------------- 3. IsBitmap? ----------------------------------------------------

imageIsBitmap([_,_,_,Pixels,_]):- pixbit_list(Pixels).

% -------------------------------------------------------------------------------------------------------


% ------------------------------------- 4. IsPixmap? ----------------------------------------------------

imageIsPixmap([_,_,_,Pixels,_]):- pixrgb_list(Pixels).

% -------------------------------------------------------------------------------------------------------


% ------------------------------------- 5. IsHexmap? ----------------------------------------------------

imageIsHexmap([_,_,_,Pixels,_]):- pixhex_list(Pixels).

% -------------------------------------------------------------------------------------------------------

% ---------------------------------- 6. imageIsCompressed -----------------------------------------------

imageIsCompressed([1,_,_,_,_]).

% -------------------------------------------------------------------------------------------------------


% ------------------------------------- 7. flipH --------------------------------------------------------

imageFlipH0([0,Width,Height,[],MostUsed], [0,Width,Height,[],MostUsed]).
imageFlipH0([0,Width,Height,[[X,Y,Color,Depth]|Pixels],MostUsed],[0,Width,Height,[[NewX,Y,Color,Depth]|P1],MostUsed]):- 
NewX is Width-1-X,imageFlipH0([0,Width,Height,Pixels,MostUsed],[0,Width, Height, P1,MostUsed]).

imageFlipH(I, [0,Width,Height,Pixels1,MostUsed]):- imageFlipH0(I,[0,Width,Height,Pixels,MostUsed]), sort(Pixels, Pixels1).

% -------------------------------------------------------------------------------------------------------


% ------------------------------------- 8. flipV --------------------------------------------------------

imageFlipV0([0,Width,Height,[],MostUsed], [0,Width,Height,[],MostUsed]).
imageFlipV0([0,Width,Height,[[X,Y,Color,Depth]|Pixels],MostUsed],[0,Width,Height,[[X,NewY,Color,Depth]|P1],MostUsed]):- 
NewY is Height-1-Y,imageFlipV0([0,Width,Height,Pixels,MostUsed],[0,Width, Height, P1,MostUsed]).

imageFlipV(I, [0,Width,Height,Pixels1,MostUsed]):- imageFlipV0(I,[0,Width,Height,Pixels,MostUsed]), sort(Pixels, Pixels1).

% -------------------------------------------------------------------------------------------------------


% ----------------------------------------- 9. crop -----------------------------------------------------

discardPixels([],_,_,_,_,[]).

discardPixels([[X,Y,_,_]|Pixels],X1,Y1,X2,Y2,P1):- ((X2 < X; X < X1); (Y2 < Y; Y < Y1)),
discardPixels(Pixels,X1,Y1,X2,Y2,P1).

discardPixels([[X,Y,Color,Depth]|Pixels],X1,Y1,X2,Y2,[[X3,Y3,Color,Depth]|P1]):- X1 @=< X, X @=< X2, Y1 @=< Y, Y @=< Y2,
 X3 is X - X1, Y3 is Y - Y1, discardPixels(Pixels,X1,Y1,X2,Y2,P1).

imageCrop([0,_,_,Pixels,_],X1,Y1,X2,Y2,I2):- Width2 is X2 - X1 + 1, Height2 is Y2 - Y1 + 1,
discardPixels(Pixels,X1,Y1,X2,Y2,Pixels2), image(Width2,Height2,Pixels2,I2).

% -------------------------------------------------------------------------------------------------------


% ------------------------------------- 10. imageRGBToHex -----------------------------------------------

pixrgbToPixhex([X,Y,Color,Depth],[X,Y,NewColor,Depth]):- hex_bytes(Hex, Color), 
string_concat('#',Hex,NewColor).

pixelsrgbToPixelshex([],[]).
pixelsrgbToPixelshex([Pixel|Pixels],[P1|P2]):- pixrgbToPixhex(Pixel,P1),
pixelsrgbToPixelshex(Pixels,P2).

imageRGBToHex([0,Width,Height,Pixels,_], I2):- pixelsrgbToPixelshex(Pixels,NewPixels),
image(Width,Height,NewPixels,I2).

% -------------------------------------------------------------------------------------------------------


% ------------------------------------ 11. imageToHistogram ---------------------------------------------

imageToHistogram([0,_,_,Pixels,_],Histogram):- histogram(Pixels, Histogram).

% -------------------------------------------------------------------------------------------------------


% ------------------------------------- 12. rotate90 ----------------------------------------------------

swapXY([],[]).
swapXY([[X,Y,Color,Depth]|Pixels],[[Y,X,Color,Depth]|P1]):- swapXY(Pixels,P1).

imageRotate90(Image, RotatedImage):- imageFlipV(Image,[0,Width,Height,Pixels,_]), 
swapXY(Pixels, RotatedPixels), image(Height,Width,RotatedPixels,RotatedImage).

% -------------------------------------------------------------------------------------------------------


% ------------------------------------ 13. Compress -----------------------------------------------------

imageCompress([0,Width,Height,Pixels,MostUsed], [1,Width,Height,NewPixels,MostUsed]):-
delete(Pixels,[_,_,MostUsed,_],NewPixels).

% -------------------------------------------------------------------------------------------------------


% ------------------------------------- 14. changePixel -------------------------------------------------

imageChangePixel([0,Width,Height,Pixels,_],[X,Y,Color,Depth],NewImage):- delete(Pixels,[X,Y,_,_],Pixels2),
append(Pixels2,[[X,Y,Color,Depth]],Pixels3),sort(Pixels3,NewPixels) ,image(Width,Height,NewPixels,NewImage).

% -------------------------------------------------------------------------------------------------------


% ------------------------------------- 15. invertColorRGB ----------------------------------------------

imageInvertColorRGB([X,Y,[R,G,B],Depth],[X,Y,[NewR,NewG,NewB],Depth]):- NewR is 255 - R,
NewG is 255 - G,NewB is 255 - B.

% -------------------------------------------------------------------------------------------------------


% ------------------------------------- 16. image->string------------------------------------------------

discardPixelsOutRow([],_,[]):-!.

discardPixelsOutRow([[X,Y,Color,Depth]|Pixels],Row,[[X,Y,Color,Depth]|P1]):- Y == Row,
discardPixelsOutRow(Pixels,Row,P1),!.

discardPixelsOutRow([[_,_,_,_]|Pixels],Row,P1):- discardPixelsOutRow(Pixels,Row,P1),!.

colToString([],""):-!.
colToString([[X,Y,[R, G, B],Depth]|Pixels], StringOut):- pixrgb(X,Y,R,G,B,Depth,_), colToString(Pixels,String), 
atomics_to_string(["[",R," ",G," ",B,"]","\t",String],StringOut),!.
colToString([[_,_,Color,_]|Pixels], StringOut):- colToString(Pixels,String), atomics_to_string([Color,"\t",String],StringOut),!.

rowToString(Height,Height,_,""):-!.
rowToString(Row,Height,Pixels,StringOut):- Row < Height, Row2 is Row + 1, discardPixelsOutRow(Pixels,Row,PixelsInRow),
colToString(PixelsInRow,RowString), rowToString(Row2,Height,Pixels,String), atomics_to_string([RowString,"\n" ,String],StringOut),!.

imageToString([0,_,Height,Pixels,_],String):- rowToString(0,Height,Pixels,String),!.

% -------------------------------------------------------------------------------------------------------


% ------------------------------------- 17. depthLayers--------------------------------------------------

discardPixelsOutDepth([],_,[]):-!.
discardPixelsOutDepth([[X,Y,Color,Depth]|Pixels],D1,[[X,Y,Color,Depth]|P1]):- Depth == D1,
discardPixelsOutDepth(Pixels,D1,P1).
discardPixelsOutDepth([[_,_,_,_]|Pixels],D1,P1):- discardPixelsOutDepth(Pixels,D1,P1).

imageDepthLayers([0,_,_,[],_],[]):-!.
imageDepthLayers([0,Width,Height,[[X,Y,Color,Depth]|Pixels],_], [Image|ImageList]):- discardPixelsOutDepth(Pixels,Depth,DPixels),
image(Width,Height,[[X,Y,Color,Depth]|DPixels],Image), subtract(Pixels,DPixels,RestPixels),
imageDepthLayers([0,Width,Height,RestPixels,_],ImageList),!.

% -------------------------------------------------------------------------------------------------------


% ------------------------------------- 18. decompress --------------------------------------------------

restoreRow(Col,_,Width,_,_,[]):- Width == Col,!.
restoreRow(Col,Row,Width,RowPixels,MostUsed,[[Col,Row,Color,Depth]|P1]):- Col < Width, Col2 is Col + 1, select([Col,Row,Color,Depth],RowPixels,RowPixels2),
restoreRow(Col2,Row,Width,RowPixels2,MostUsed,P1),!.
restoreRow(Col,Row,Width,RowPixels,MostUsed,[[Col,Row,MostUsed,0]|P1]):- Col < Width, Col2 is Col + 1,
restoreRow(Col2,Row,Width,RowPixels,MostUsed,P1),!.

restorePixels(Row,_,Height,_,_,[]):- Height == Row,!.
restorePixels(Row,Width,Height,PixelsIn,MostUsed,PixelsOut):- Row < Height,Row2 is Row + 1, discardPixelsOutRow(PixelsIn,Row,RowPixels),
restoreRow(0,Row,Width,RowPixels,MostUsed,PixelsCol), append(PixelsCol,P1,PixelsOut), restorePixels(Row2,Width,Height,PixelsIn,MostUsed,P1),!.

imageDecompress([1,Width,Height,Pixels,MostUsed], Image):- restorePixels(0, Width,Height,Pixels,MostUsed,FullPixels),
image(Width,Height,FullPixels,Image),!.

% -------------------------------------------------------------------------------------------------------

