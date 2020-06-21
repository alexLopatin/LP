writebook(astronomy).
writebook(poetry).
writebook(prose).
writebook(piece).

unique([]):-!.
unique([Head|Tail]):-
   member(Head, Tail), !, fail;
   unique(Tail).

check([]):-!.
check([passenger(_, XRead, XBuy, XWrite)|T]):-
  !, \+ XRead = XWrite, \+ XBuy = XWrite, check(T).

solve(S):-
  S = [passenger(alekseev, XRead, XBuy, XWrite), passenger(borisov, YRead, YBuy, YWrite),
          passenger(konstantinov, ZRead, ZBuy, ZWrite), passenger(dmitriev, WRead, WBuy, WWrite)],
  % каждый написал книгу
  writebook(XWrite), writebook(YWrite),
  writebook(ZWrite), writebook(WWrite),
  unique([XWrite, YWrite, ZWrite, WWrite]),
  % каждый купил книгу
  writebook(XBuy), writebook(YBuy),
  writebook(ZBuy), writebook(WBuy),
  unique([XBuy, YBuy, ZBuy, WBuy]),
  % каждый читает книгу
  writebook(XRead), writebook(YRead),
  writebook(ZRead), writebook(WRead),
  unique([XRead, YRead, ZRead, WRead]),
  % поэт читает пьесу
  member(passenger(_, piece, _, poetry), S),
  % прозаик читает не астрономию
  not(member(passenger(_, astronomy, _, prose), S)),
  % прозаик не покупал астрономию
  not(member(passenger(_, _, astronomy, prose), S)),
  % никто не читает и не покупал свою книгу
  check(S),
  % алексеев и борисов обменялись книгами
  member(passenger(alekseev, AlekseevRead, AlekseevBuy, _), S),
  member(passenger(borisov, AlekseevBuy, AlekseevRead, _), S),
  % Борисов купил произведение Дмитриева
  member(passenger(dmitriev, _, _, DmitrievWrite), S),
  member(passenger(borisov, _, DmitrievWrite, _), S).