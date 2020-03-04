sum('+').
res('-').
pow('^').
div('/').
mult('*').

append([], L, L).
append([X|L1], L2, [X|L3]):-append(L1, L2, L3).

reverse([],Z,Z).
 reverse([H|T],Z,Acc) :- reverse(T,Z,[H|Acc]).

%считаю все операции нулевого порядка: сложение/вычитание.
calc_zero([X], X).
calc_zero([X, Y, Z|T], C):-
    sum(Y), R is X + Z, calc_zero([R|T], C).
calc_zero([X, Y, Z|T], C):-
    res(Y), R is X - Z, calc_zero([R|T], C).


%считаю все возведения в степень (справа налево) и заменяю их в исходном выражении на числа
calc_pows(L, [X,Y,Z|T], C):-
    % Z^X, так как проходим справа налево
    pow(Y), R is Z**X, calc_pows(L, [R|T], C).
calc_pows(L, [X, Y, Z|T], C):-
    append(L, [X, Y], L1), calc_pows(L1, [Z|T], C).
calc_pows(L, [X], L1):- 
	append(L, [X], L1).


%считаю все частные и заменяю их в исходном выражении на числа
calc_divs(L, [X,Y,Z|T], C):-
    div(Y), R is X/Z, calc_divs(L, [R|T], C).
calc_divs(L, [X, Y, Z|T], C):-
    append(L, [X, Y], L1), calc_divs(L1, [Z|T], C).
calc_divs(L, [X], L1):- 
	append(L, [X], L1).


%считаю все произведения и заменяю их в исходном выражении на числа
calc_mults(L, [X,Y,Z|T], C):-
    mult(Y), R is X * Z, calc_mults(L, [R|T], C).
calc_mults(L, [X, Y, Z|T], C):-
    append(L, [X, Y], L1), calc_mults(L1, [Z|T], C).
calc_mults(L, [X], L1):- 
	append(L, [X], L1).

%считаю по порядку приоритетов: сначала возведение в степень, потом деление/умножение, и потом сложение/вычитание.
calculate(L, X):-
    reverse(L, L1, []),
    calc_pows([], L1, L2),
    reverse(L2, L3, []),
    calc_divs([], L3, L4),
    calc_mults([], L4, L5), 
    calc_zero(L5, X).