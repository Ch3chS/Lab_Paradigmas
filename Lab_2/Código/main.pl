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

image(Width, Height, Pixels, [Width, Height, Pixels]).


imageIsBitmap([Width,Height,Pixels]):- pixbit_list(Pixels).

imageIsPixmap([Width,Height,Pixels]):- pixbit_list(Pixels).

imageIsHexmap([Width,Height,Pixels]):- pixbit_list(Pixels).