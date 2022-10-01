
pixbit-d(X,Y,Bit,Depth,[X,Y,Bit,Depth]) :- integer(X), integer(Y), integer(Bit), integer(Depth),
 0 @=< X, 0 @=< Y, (Bit==0;Bit==1), 0 @=< Depth.
