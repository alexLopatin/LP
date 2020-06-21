check([X, Y]):-
    not(X = Y), !.
check([_]):- !.
check([]).
check([X, Y|T]):-
   check([Y|T]),
   not(X = Y).