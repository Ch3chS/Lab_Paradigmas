:- module(pixhex, [pixhex/5, pixhex_list/1]).

% Falta comprobar que Hex sea un string
pixhex(X,Y,Hex,Depth,[X,Y,Hex,Depth]):- integer(X), integer(Y), string(Hex), integer(Depth),
 0 @=< X, 0 @=< Y, 0 @=< Depth.


pixhex_list([]).
pixhex_list([A|Pixels]):- pixhex(_,_,_,_,A), pixhex_list(Pixels).