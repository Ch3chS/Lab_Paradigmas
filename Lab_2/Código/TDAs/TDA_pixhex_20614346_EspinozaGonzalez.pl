:- module(pixhex, [pixhex/5, pixhex_list/1]).

% ---------------------------------------------- Documentación ------------------------------------------------

% ----- Dominios -------
% Posición x:  Número >= 0
% Posición y:  Número >= 0
% Hexadecimal: String, formato: '#XXXXXX' donde las X pueden tomar un valor entre 0 y 9, además de loc caracteres A,B,C,D,E,F
% Profundidad: Número >= 0
% Pixel:       Lista [Posición x, Posición y, Hexadecimal, Profundidad]
% Lista:       Lista [] ; Lista [Pixel|Lista]

% ----- Predicados -----
% pixhex(Posición x, Posición y, Hexadecimal, Profundidad, Pixel)         aridad: 5
% pixhex_list(Lista)                                                      aridad: 1


% ----- Metas ----------
%     Primarias
% pixhex(X,Y,Hex,Depth,[X,Y,Hex,Depth])

%    Secundarias
% pixhex_list([Pixel|Pixels])

% -------------------------------------------------------------------------------------------------------------


% -------------------------------------------- Clausulas de Horn ----------------------------------------------

% ----- Reglas -----
pixhex(X,Y,Hex,Depth,[X,Y,Hex,Depth]):- integer(X), integer(Y), string(Hex), integer(Depth),     % Constructor de pixhex
 0 @=< X, 0 @=< Y, 0 @=< Depth.


pixhex_list([]).
pixhex_list([A|Pixels]):- pixhex(_,_,_,_,A), pixhex_list(Pixels).     % Comprueba que una lista sea una lista de pixhex