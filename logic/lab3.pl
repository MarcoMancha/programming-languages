% Marco Mancha A01206194
% LAB 3 PROLOG

%sort - Function that divides a list on 2 lists, left and right
%       depending on the pivot, if less put on left, if not on right.

% Base case, empty list
sort([],_,[],[]).

% Recursive case, head element is less or equal than pivot
sort([H|T],Pivot,[H|Left],Right):-
  H =< Pivot,
  sort(T, Pivot, Left, Right).

% Recursive case, head element is bigger than pivot
sort([H|T],Pivot,Left, [H|Right]):-
  sort(T,Pivot,Left,Right).

%quick_sort - Function that sorts a list using quick sort algorithm
% ?- quick_sort([13, 46, 25, 12, 27, 1], X). should return X = [1, 12, 13, 25, 27, 46]
%Base case, empty list
quick_sort([], []).

%Recursive case, sort left and right part and join them
quick_sort([H|T],S):-
  sort(T,H,Left,Right),
  quick_sort(Left,LS),
  quick_sort(Right,RS),
  append(LS,[OH],SH),
  append(SH,RS,S).

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

%Helper function that checks if an element is present on a list
%Base case, head is the element
in(H, [H|_]).
%Recursive case, loop with tail of the list
in(H, [_|T]):-
  in(H, T).

path(Origin, Limit, Path):-
  route(Origin, Limit, [Origin], Path).

route(_, 0, Route, Route).

route(Origin, Limit, Route, Path):-
  road(Origin, Stop),
  not(is_in(Stop, Route)),
  addend(Stop, Route, Helper),
  Count is Limit-1,
  route(Stop, Count, Helper, Path).
