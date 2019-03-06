%
% insertion_sort(List, Sorted):-
%   i_sort(List, [], Sorted).
%
% i_sort([], Acc, Acc).
%
% i_sort([H|T],Acc,Sorted):-
%   insertion(H,T,NT,Max),
%   i_sort(NT, [Max | Acc], Sorted).
%
% insertion(X,[],[],X).
%
% insertion(X,[Y|T],[Y|NT],Max):-
%   X>Y,
%   insertion(X,T,NT,Max).
%
% insertion(X,[Y|T],[X|NT],Max):-
%   X =< Y,
%   insertion(Y,T,NT,Max).

insert(X, [], [X]).
insert(X, [X1|L1], [X, X1|L1]):-
    X=<X1.
insert(X, [X1|L1], [X1|L]):- insert(X, L1, L).
insertionSort([], []):- !.
insertionSort([X|L], S):- insertionSort(L, S1), insert(X, S1, S).
