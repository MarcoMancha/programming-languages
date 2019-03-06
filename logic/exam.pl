%Marco Mancha A01206194
%EXAM 3 PROLOG


%Knowledge base for the artists
%album("hide", "bonnie", "uk", "cbs", "9.90", "1988").
%album("empire", "bob", "usa", "columbia", "10.9", "1985").

cost("cost").
album("album").
artist("artist").
country("country").
channel("channel").
year("year").
album("bonnie", "hide").
album("bob","empire").
artist("hide","bonnie").
artist("empire","bob").
country("empire","usa").
country("hide","uk").
channel("empire","columbia").
channel("hide","cbs").
cost("hide","9.90").
cost("empire","10.9").

% Function that gives information about a query
% Usage: ?- query(["cost", "of", "hide"],A).
% Result: A = 9.90

query([], _).

query([H | T], X):-
  cost(H),
  query_cost([H | T], X);
  album(H),
  query_album([H | T], X);
  artist(H),
  query_artist([H | T], X);
  country(H),
  query_country([H | T], X);
  channel(H),
  query_channel([H | T], X);
  year(H),
  query_year([H | T], X).

% query([H | T], A, B, C, D, E):-
%   album(H,A,B,C,D,E);
%   album(A,H,B,C,D,E);
%   album(A,B,H,C,D,E);
%   album(A,B,C,H,D,E);
%   album(A,B,C,D,H,E);
%   album(A,B,C,D,E,H);
%   query(T,A,B,C,D,E).

query_cost([_, H2, H3| T],X):-
  cost(H2,X);
  cost(H3,X);
  query_cost([H2, H3 | T],X).

query_album([_, H2, H3| T],X):-
  album(H2,X);
  album(H3,X);
  query_album([H2, H3 | T],X).

query_artist([_, H2, H3| T],X):-
  artist(H2,X);
  artist(H3,X);
  query_artist([H2, H3 | T],X).

query_country([_, H2, H3| T],X):-
  country(H2,X);
  country(H3,X);
  query_country([H2, H3 | T],X).

query_channel([_, H2, H3| T],X):-
  channel(H2,X);
  channel(H3,X);
  query_channel([H2, H3 | T],X).

query_year([_, H2, H3| T],X):-
  year(H2,X);
  year(H3,X);
  query_year([H2, H3 | T],X).
