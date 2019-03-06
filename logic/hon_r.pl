
honorific(older_brother, child, chan).
honorific(older_brother, child, kun).
honorific(older_brother, child, chan).
honorific(child, older_brother, oniisan).
honorific(underclassman, upperclassman, senpai).
honorific(upperclassman, underclassman, kohai).
honorific(_, royalty, sama).
honorific(child, uncle, ojisan).
honorific(uncle, child, chan).
honorific(child, father, otosan).
honorific(father, child, chan).
honorific(X, X, san).

% ?- correct_honorific([father, sung], [royalty, queen], X).
% X = [queen, sama]
% ?- correct_honorific([father, yung], [child, gong], X).
% X = [gong, chan]


% Base case for the moment the honorific is chosen.
correct_honorific([],P2N,[P2N|_]).

% Initial case that gets the parameters to conclude which honorific should
% be used.
correct_honorific([P1H|_], [P2H,P2N|_], ReferSentece):-
  get_honorific(P1H, P2H, P2N, ReferSentece).

% Rule that helps correct honorific to determine which honorific must be
% used and calls the base case.
get_honorific(P1H, P2H, P2N, NewList):-
  % As soon as it finds the correct honorific it stops looking for more.
  honorific(P1H, P2H, Honorific),
  append([P2N],[Honorific],NewList),
  correct_honorific([],P2N,NewList).


% Tool to help adding an element to the end of a list.
addend(X, [], [X]).
addend(X, [X|T], [_|NewList]):-
  addend(X, T, NewList).
