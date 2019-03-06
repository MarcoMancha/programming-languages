% Marco Mancha A01206194
% LAB 2 PROLOG

%Function that consults if there is a positive number on a list.
any_positive([H | T]):-
  H > 0, !;
  any_positive(T).

%Function that substitutes all occurrences of X with Y
%Base case for substitute
substitute(_,_,[],[]).

%Case for HEAD is X
substitute(X, Y,[ X | T ],[ Y | TRes]):-
  substitute(X,Y,T,TRes).

%Case for HEAD != X
substitute(X, Y,[ H | T ], [ H | TRes]):-
    substitute(X,Y,T,TRes).

%Helper function that checks if an element is present on a list
%Base case, head is the element
in(H, [H|_]).
%Recursive case, loop with tail of the list
in(H, [_|T]):-
  in(H, T).

%Function that eliminates duplicates on a list
%Base case for eliminate_duplicates
eliminate_duplicates([],[]).

%Recursive case, add element if Head not on NT
eliminate_duplicates([H | T ], [ H | NT]):-
  not(in(H,T)), !,
  eliminate_duplicates(T,NT).

%Recursive case, add element if Head not on NT
eliminate_duplicates([_| T ], NT):-
  eliminate_duplicates(T,NT).

%Function that adds the elements that are on both lists
%Base case, first list is empty
intersect([],_,[]):- !.

%Recursive case, the head of the 2 lists is the same
intersect([H1 | T1],[H1 | T2], [H1 | T3]):-
  intersect(T1, T2, T3).

%Recursive case, different heads but head of first list is on second list.
intersect([H1 | T1],L2, [H1 | T3]):-
  in(H1,L2),
  intersect(T1, L2, T3).

%Final case, head is not on the second list, just ignore it.
intersect([_ | T1],L2, T3):-
  intersect(T1, L2, T3).

%Function that reverses a list.
%Base case, first list empty.
invert([],[]).

%Recursive case, append head at the end of the list
invert([H | T], X):-
  append(NL,[H],X),
  invert(T, NL).

%Function that adds the elements that are less than X
%Base case, empty list
less_than(_,[],[]).

%Recursive case, Head is less than X, add head to the list
less_than(X,[H | T], [H | NT]):-
  H < X,
  less_than(X, T, NT).

%Recursive case, Head is greater - equal to X, ignore it
less_than(X,[_ | T], NT):-
  less_than(X, T, NT).

%Function that adds the elements that are more or equal to X
%Base case, empty list
more_than(_,[],[]).

%Recursive case Head is greate - equal to X
more_than(X,[H | T], [H | NT]):-
  H >= X,
  more_than(X, T, NT).

%Head is small than X, ignore it.
more_than(X,[_ | T], NT):-
  more_than(X, T, NT).

%Function that rotates the elements of a list N positions
%Base case, list already shifted
rotate(List,0,List).

%Recursive case, move the HEAD to the last position of the list
rotate([H|T], N, Result):-
  N > 0,
  M is N-1,
  append(T, [H], NL),
  rotate(NL, M, Result).

%Case for negative rotations, change the order of the lists
rotate(List, N, Result):-
    N < 0,
    M is -N,
    rotate(Result, M, List).

%Italy BK with bidirectional directions
road(genua, placentia).
road(placentia, genua).
road(genua, pisae).
road(pisae, genua).
road(genua, roma).
road(roma, genua).
road(placentia, ariminum).
road(ariminum, placentia).
road(pisae, roma).
road(roma, pisae).
road(ariminum, roma).
road(roma, ariminum).
road(ariminum, ancona).
road(ancona, ariminum).
road(ancona, roma).
road(roma, ancona).
road(ancona, castrum).
road(castrum, ancona).
road(castrum, roma).
road(roma, castrum).
road(capua, roma).
road(roma, capua).
road(brundisium, capua).
road(capua, brundisium).
road(rhegium ,capua).
road(capua, rhegium).
road(messana, rhegium).
road(rhegium, messana).
road(lilibeum, messana).
road(messana, lilibeum).
road(catina, messana).
road(messana, catina).
road(syracusae, catina).
road(catina, syracusae).

%Function that returns the path from an origin to destination
%Call to helper function, adding the first element, the origin.
path(Origin, Destiny, Path):-
  path_to(Origin, Destiny, [Origin], Path).

%Recursive call, existent path of origin to destination, faster case.
path_to(Origin, Destiny, Route, Route):-
  road(Origin, Destiny).

%Recursive call, append next path from the origin
path_to(Origin, Destiny, Route, Path):-
  road(Origin, AnotherDestiny),
  not(in(AnotherDestiny, Route)),
  append(Route,[AnotherDestiny], NewRoute),
  path_to(AnotherDestiny, Destiny, NewRoute, Path).
