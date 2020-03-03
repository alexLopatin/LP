print_list([X|Y]):-
    write(X), write(' '), print_list(Y).
print_list(_).

reverse([],Z,Z).
 reverse([H|T],Z,Acc) :- reverse(T,Z,[H|Acc]).

max([X], X).
max([X|Y], X):-
    max(Y, M), X >= M.
max([X|Y], Z):-
    max(Y, Z), X < Z.