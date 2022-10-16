:- use_module('./TDAs/TDA_histogram_20614346_EspinozaGonzalez.pl').
:- use_module('./TDAs/TDA_pixbit-d.pl').
:- use_module('./TDAs/TDA_pixhex-d.pl').
:- use_module('./TDAs/TDA_pixrgb-d.pl').



% ---------------------------------- 2. Constructor Image -----------------------------------------------

image(Width, Height, Pixels, [0, Width, Height, Pixels1, MostUsed]):- mostUsed(Pixels, MostUsed), sort(Pixels, Pixels1),!.

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

imageFlipH([0,Width,Height,[],MostUsed], [0,Width,Height,[],MostUsed]).
imageFlipH([0,Width,Height,[[X,Y,Color,Depth]|Pixels],MostUsed],[0,Width,Height,[[NewX,Y,Color,Depth]|P1],MostUsed]):- 
NewX is Width-1-X,imageFlipH([0,Width,Height,Pixels,MostUsed],[0,Width, Height, P1,MostUsed]).

% -------------------------------------------------------------------------------------------------------


% ------------------------------------- 8. flipV --------------------------------------------------------

imageFlipV([0,Width,Height,[],MostUsed], [0,Width,Height,[],MostUsed]).
imageFlipV([0,Width,Height,[[X,Y,Color,Depth]|Pixels],MostUsed],[0,Width,Height,[[X,NewY,Color,Depth]|P1],MostUsed]):- 
NewY is Height-1-Y,imageFlipV([0,Width,Height,Pixels,MostUsed],[0,Width, Height, P1,MostUsed]).

% -------------------------------------------------------------------------------------------------------


% ----------------------------------------- 9. crop -----------------------------------------------------

discardPixels([],_,_,_,_,[]).

discardPixels([[X,Y,_,_]|Pixels],X1,Y1,X2,Y2,P1):- ((X2 < X; X < X1); (Y2 < Y; Y < Y1)),
discardPixels(Pixels,X1,Y1,X2,Y2,P1).

discardPixels([[X,Y,Color,Depth]|Pixels],X1,Y1,X2,Y2,[[X,Y,Color,Depth]|P1]):- X1 @=< X, X @=< X2, Y1 @=< Y, Y @=< Y2,
discardPixels(Pixels,X1,Y1,X2,Y2,P1).

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

