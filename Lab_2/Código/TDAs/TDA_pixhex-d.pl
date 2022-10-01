:- module(pixhex, []).


pixhex-d(X,Y,Hex,Depth,[X,Y,Hex,Depth]) :- integer(X), integer(Y), integer(Depth),
 0 @=< X, 0 @=< Y, 0 @=< Depth.