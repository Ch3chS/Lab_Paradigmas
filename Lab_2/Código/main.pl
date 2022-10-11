:- use_module('./TDAs/TDA_histogram_20614346_EspinozaGonzalez.pl').

%pixbit

pixbit-d(X,Y,Bit,Depth,[X,Y,Bit,Depth]) :- integer(X), integer(Y), integer(Bit), integer(Depth),
 0 @=< X, 0 @=< Y, (Bit==0;Bit==1), 0 @=< Depth.

pixbit_list([]).
pixbit_list([A|Pixels]):- pixbit-d(_,_,_,_,A), pixbit_list(Pixels).



%pixhex

% Falta comprobar que Hex sea un string
pixhex-d(X,Y,Hex,Depth,[X,Y,Hex,Depth]):- integer(X), integer(Y), integer(Depth),
 0 @=< X, 0 @=< Y, 0 @=< Depth.


pixhex_list([]).
pixhex_list([A|Pixels]):- pixhex-d(_,_,_,_,A), pixhex_list(Pixels).



%pixrgb

pixrgb-d(X,Y,R,G,B,Depth,[X,Y,[R,G,B],Depth]) :- integer(X), integer(Y), integer(R), integer(G), integer(B), integer(Depth),
 0 @=< X, 0 @=< Y, 0 @=< R, R @=< 255, 0 @=< G, G @=< 255, 0 @=< B, B @=< 255, 0 @=< Depth.

pixrgb_list([]).
pixrgb_list([A|Pixels]):- pixrgb-d(_,_,_,_,_,_,A), pixrgb_list(Pixels).





% Funciones principales

% ---------------------------------- 2. Constructor Image -----------------------------------------------

image(Width, Height, Pixels, [0, Width, Height, Pixels, MostUsed]):- mostUsed(Pixels, MostUsed).

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

imageCrop([0,_,_,Pixels,MostUsed],X1,Y1,X2,Y2,I2):- Width2 is X2 - X1 + 1, Height2 is Y2 - Y1 + 1,
discardPixels(Pixels,X1,Y1,X2,Y2,Pixels2), image(Width2,Height2,Pixels2,I2).

% -------------------------------------------------------------------------------------------------------


% ------------------------------------- 10. imageRGBToHex -----------------------------------------------

pixrgbToPixhex([X,Y,Color,Depth],[X,Y,NewColor,Depth]):- hex_bytes(Hex, Color), 
string_concat('#',Hex,NewColor).

pixelsrgbToPixelshex([],[]).
pixelsrgbToPixelshex([Pixel|Pixels],[P1|P2]):- pixrgbToPixhex(Pixel,P1),
pixelsrgbToPixelshex(Pixels,P2).

imageRGBToHex([0,Width,Height,Pixels,MostUsed], I2):- pixelsrgbToPixelshex(Pixels,NewPixels),
image(Width,Height,NewPixels,I2).

% -------------------------------------------------------------------------------------------------------


% ------------------------------------ 11. imageToHistogram ---------------------------------------------

imageToHistogram([0,_,_,Pixels,_],Histogram):- histogram(Pixels, Histogram).

% -------------------------------------------------------------------------------------------------------


% ------------------------------------- 12. rotate90 ----------------------------------------------------



% -------------------------------------------------------------------------------------------------------


% ------------------------------------ 13. Compress -----------------------------------------------------



% -------------------------------------------------------------------------------------------------------


% ------------------------------------- 14. changePixel -------------------------------------------------



% -------------------------------------------------------------------------------------------------------


% ------------------------------------- 15. invertColorRGB ----------------------------------------------



% -------------------------------------------------------------------------------------------------------


% ------------------------------------- 16. image->string------------------------------------------------



% -------------------------------------------------------------------------------------------------------


% ------------------------------------- 17. depthLayers--------------------------------------------------



% -------------------------------------------------------------------------------------------------------


% ------------------------------------- 18. decompress --------------------------------------------------



% -------------------------------------------------------------------------------------------------------

