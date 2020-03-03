print_list([X|Y]):-
    write(X), write(' '), print_list(Y).
print_list(_).

length([], 0).
length([_|L], N):-length(L, M), N is M + 1.

member(X, [X|_]).
member(X, [_|T]):-member(X, T).

append([], L, L).
append([X|L1], L2, [X|L3]):-append(L1, L2, L3).

remove(X, [X|T], T).
remove(X, [Y|T], [Y|Z]):-remove(X, T, Z).

permute([], []).
permute(L, [X|T]):-remove(X, L, Y), permute(Y, T).

sublist(S, L):-append(_, L1, L), append(S, _, L1).

reverse([],Z,Z).
 reverse([H|T],Z,Acc) :- reverse(T,Z,[H|Acc]).

max([X], X).
max([X|Y], X):-
    max(Y, M), X >= M.
max([X|Y], Z):-
    max(Y, Z), X < Z.