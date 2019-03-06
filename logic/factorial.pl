
% HEAD RECURSION
factorial(1,1).

factorial(X,R):-
  X1 is X - 1,
  factorial(X1,R1),
  R is R1 * X.

%TAIL RECURSION
factT(X,R):-
  factT(X,0,1,R).

factT(0,_,R,R):-!. % SAME AS R is NR

factT(X,C,A,R):-
  X1 is X - 1,
  NC is C + 1,
  NA is NC * A,
  factT(X1,NC,NA,R).
