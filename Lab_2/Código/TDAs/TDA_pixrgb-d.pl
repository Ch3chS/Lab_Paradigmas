:- module(pixrgb,[pixrgb/7, pixrgb_list/1]).

pixrgb(X,Y,R,G,B,Depth,[X,Y,[R,G,B],Depth]) :- integer(X), integer(Y), integer(R), integer(G), integer(B), integer(Depth),
 0 @=< X, 0 @=< Y, 0 @=< R, R @=< 255, 0 @=< G, G @=< 255, 0 @=< B, B @=< 255, 0 @=< Depth.

pixrgb_list([]).
pixrgb_list([A|Pixels]):- pixrgb(_,_,_,_,_,_,A), pixrgb_list(Pixels).
