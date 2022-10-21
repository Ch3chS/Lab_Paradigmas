:- module(pixbit,[pixbit/5, pixbit_list/1]).

% ---------------------------------------------- Documentación ------------------------------------------------

% ----- Dominios -------
% Posición x:  Número >= 0
% Posición y:  Número >= 0
% Bit:         Número == 0 ; Número == 1
% Profundidad: Número >= 0
% Pixel:       Lista [Posición x, Posición y, Bit, Profundidad]
% Lista:       Lista [] ; Lista [Pixel|Lista]

% ----- Predicados -----
% pixbit(Posición x, Posición y, Bit, Profundidad, Pixel)         aridad: 5
% pixbit_list(Lista)                                              aridad: 1


% ----- Metas ----------
%     Primarias
% pixbit(X,Y,Bit,Depth,[X,Y,Bit,Depth])

%    Secundarias
% pixbit_list([Pixel|Pixels])

% -------------------------------------------------------------------------------------------------------------


% -------------------------------------------- Clausulas de Horn ----------------------------------------------

% ----- Reglas -----
pixbit(X,Y,Bit,Depth,[X,Y,Bit,Depth]) :- integer(X), integer(Y), integer(Bit), integer(Depth),     % Constructor de pixbit
 0 @=< X, 0 @=< Y, (Bit==0;Bit==1), 0 @=< Depth.

pixbit_list([]).
pixbit_list([Pixel|Pixels]):- pixbit(_,_,_,_,Pixel), pixbit_list(Pixels).     % Comprueba que una lista sea una lista de pixbit

