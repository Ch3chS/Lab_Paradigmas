:- module(histogram,[histogram/2, mostUsed/2]).

% ---------------------------------------------- Documentación ------------------------------------------------

% ----- Dominios -------
% Pixel:                    Lista [X,Y,Color,Depth]
% Pixeles:                  Lista [Pixel|Pixeles]
% Histograma:               [[Color,Contador]|Histograma]
% Color:                    Bit, Hexadecimal, Lista [R,G,B]           (Para este, ver los TDAs pixbit, pixhex y pixrgb)
% Contador:                 Número >= 0                               (Este lo reciclaré un poco para no tener muchas cosas iguales)
% Lista de cantidades:      Lista [] ; Lista [Contador|Lista de cantidades]

% ----- Predicados -----
% histogram(Pixeles, Histograma)                    aridad: 2
% countColor(Color, Pixeles, Contador, Contador)    aridad: 4
% mostUsed(Pixeles, Color)                          aridad: 2
% cantList(Histograma, Lista de cantidades)         aridad: 2

% ----- Metas ----------
%     Primarias
% histogram(Pixels, Histogram)

%    Secundarias
% countColor(Color, Pixels, 1, Repeats)
% mostUsed(Pixels,Color)
% cantList(Histogram, Cants)

% -------------------------------------------------------------------------------------------------------------


% -------------------------------------------- Clausulas de Horn ----------------------------------------------

% ----- Reglas -----

% Constructor

histogram([],[]):-!.
histogram([[_,_,Color,_]|Pixels],[[Color,Repeats]|H1]):- countColor(Color, Pixels, 1, Repeats),
delete(Pixels, [_,_,Color,_], SubPixels),histogram(SubPixels, H1),!.

countColor(Color,Pixels,CountIn,CountOut):- select([_,_,Color,_], Pixels, NewPixels),        % Se saca un pixel con ese color de la lista (Esta clausula será false si ya no esta el color)
CountIn2 is CountIn + 1, countColor(Color,NewPixels,CountIn2,CountOut).                      % Se aumenta el contador en 1 y se aplica recursión de cola

countColor(_,_,CountIn,CountIn).                                                             % En caso de que no se encontrase el color en la lista el contador no aumenta


% Most Used (extra)

mostUsed(Pixels,Color):- histogram(Pixels, Histogram), cantList(Histogram, Cants), 
max_member(@=<, X, Cants), once(member([Color,X],Histogram)),!.

cantList([],[]).
cantList([[_,Cant]|H1],[Cant|C1]):- cantList(H1,C1).

