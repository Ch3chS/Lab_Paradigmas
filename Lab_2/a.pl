male(rodrigo).
female(leonor).
parent(rodrigo, leonor).
father(X):-parent(X,Y),male(X).
