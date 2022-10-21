:- module(pixrgb,[pixrgb/7, pixrgb_list/1]).

% ---------------------------------------------- Documentación ------------------------------------------------

% ----- Dominios -------
% Posición x:  Número >= 0
% Posición y:  Número >= 0
% R:      0 <= Número <= 255
% G:      0 <= Número <= 255
% B:      0 <= Número <= 255
% Profundidad: Número >= 0
% Color:       Lista [R,G,B]
% Pixel:       Lista [Posición x, Posición y, Color, Profundidad]
% Lista:       Lista [] ; Lista [Pixel|Lista]

% ----- Predicados -----
% pixrgb(Posición x, Posición y, R, G, B, Profundidad, Pixel)         aridad: 7
% pixrgb_list(Lista)                                                  aridad: 1


% ----- Metas ----------
%     Primarias
% pixrgb(X,Y,R,G,B,Depth,[X,Y,[R,G,B],Depth])

%    Secundarias
% pixrgb_list([Pixel|Pixels])

% -------------------------------------------------------------------------------------------------------------


% -------------------------------------------- Clausulas de Horn ----------------------------------------------

% ----- Reglas -----
pixrgb(X,Y,R,G,B,Depth,[X,Y,[R,G,B],Depth]) :- integer(X), integer(Y), integer(R), integer(G), integer(B), integer(Depth),     % Constructor de pixrgb
 0 @=< X, 0 @=< Y, 0 @=< R, R @=< 255, 0 @=< G, G @=< 255, 0 @=< B, B @=< 255, 0 @=< Depth.

pixrgb_list([]).
pixrgb_list([A|Pixels]):- pixrgb(_,_,_,_,_,_,A), pixrgb_list(Pixels).     % Comprueba que una lista sea una lista de pixrgb
