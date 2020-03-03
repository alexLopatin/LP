sum('+').
res('-').
pow('^').

append([], L, L).
append([X|L1], L2, [X|L3]):-append(L1, L2, L3).

calc_zero([X], X).
calc_zero([X, Y, Z|T], C):-
    sum(Y), R is X + Z, calc_zero([R|T], C).
calc_zero([X, Y, Z|T], C):-
    res(Y), R is X - Z, calc_zero([R|T], C).

calc_pows(L, [X,Y,Z|T], C):-
    pow(Y), pow(X, Z, R), append(L, [R], L1), calc_pows(L1, [T], C).
calc_pows(L, [X, Y, Z|T], C):-
    append(L, [X, Y], L1), calc_pows(L1, [Z|T], C).
calc_pows(L, [X], L1):- 
    write(X),append(L, [X], L1).


pow(X, 1, X).
pow(X, Y, Z):-
    NY is Y - 1, 
    pow(X, NY, NZ), 
    Z is X * NZ.