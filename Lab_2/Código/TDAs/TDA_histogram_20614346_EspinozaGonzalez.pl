:- module(histogram,[histogram/2, mostUsed/2]).


% Constructor

histogram([],[]):-!.
histogram([[_,_,Color,_]|Pixels],[[Color,Repeats]|H1]):- countColor(Color, Pixels, 1, Repeats),
delete(Pixels, [_,_,Color,_], SubPixels),histogram(SubPixels, H1).

countColor(Color,Pixels,CountIn,CountOut):- select([_,_,Color,_], Pixels, NewPixels),
CountIn2 is CountIn + 1, countColor(Color,NewPixels,CountIn2,CountOut).

countColor(_,_,CountIn,CountIn).


% Most Used (extra)

mostUsed(Pixels,Color):- histogram(Pixels, Histogram), cantList(Histogram, Cants), 
max_member(@=<, X, Cants), once(member([Color,X],Histogram)),!.

cantList([],[]).
cantList([[_,Cant]|H1],[Cant|C1]):- cantList(H1,C1).

