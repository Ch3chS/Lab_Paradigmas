pixrgb-d(X,Y,R,G,B,Depth,[X,Y,[R,G,B],Depth]) :- integer(X), integer(Y), integer(R), integer(G), integer(B), integer(Depth),
 0 @=< X, 0 @=< Y, 0 @=< R, R @=< 255, 0 @=< G, G @=< 255, 0 @=< B, B @=< 255, 0 @=< Depth.
