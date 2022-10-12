:- module(pixbit,[pixbit/5, pixbit_list/1]).

pixbit(X,Y,Bit,Depth,[X,Y,Bit,Depth]) :- integer(X), integer(Y), integer(Bit), integer(Depth),
 0 @=< X, 0 @=< Y, (Bit==0;Bit==1), 0 @=< Depth.

pixbit_list([]).
pixbit_list([A|Pixels]):- pixbit(_,_,_,_,A), pixbit_list(Pixels).

