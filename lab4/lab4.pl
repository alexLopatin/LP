sum('+').
res('-').
pow('^').
div('/').
mult('*').

append([], L, L).
append([X|L1], L2, [X|L3]):-append(L1, L2, L3).

calc_zero([X], X).
calc_zero([X, Y, Z|T], C):-
    sum(Y), R is X + Z, calc_zero([R|T], C).
calc_zero([X, Y, Z|T], C):-
    res(Y), R is X - Z, calc_zero([R|T], C).

calc_pows(L, [X,Y,Z|T], C):-
    %pow(Y), pow(X, Z, R), calc_pows(L, [R|T], C).
    div(Y), R is X/Z, calc_pows(L, [R|T], C).
    %pow(Y), calc_pows([], [Z|T], L), pow(X, Z, R), append(L, [X, Y], L1).
calc_pows(L, [X, Y, Z|T], C):-
    append(L, [X, Y], L1), calc_pows(L1, [Z|T], C).
calc_pows(L, [X], L1):- 
	append(L, [X], L1).

calc_divs(L, [X,Y,Z|T], C):-
    div(Y), R is X/Z, calc_divs(L, [R|T], C).
calc_divs(L, [X, Y, Z|T], C):-
    append(L, [X, Y], L1), calc_divs(L1, [Z|T], C).
calc_divs(L, [X], L1):- 
	append(L, [X], L1).

calc_mults(L, [X,Y,Z|T], C):-
    mult(Y), R is X * Z, calc_mults(L, [R|T], C).
calc_mults(L, [X, Y, Z|T], C):-
    append(L, [X, Y], L1), calc_mults(L1, [Z|T], C).
calc_mults(L, [X], L1):- 
	append(L, [X], L1).

calculate(L, X):-
    calc_divs([], L, L1), calc_mults([], L1, L2), calc_zero(L2, X).

pow(X, 1, X).
pow(X, Y, Z):-
    NY is Y - 1, 
    pow(X, NY, NZ), 
    Z is X * NZ.