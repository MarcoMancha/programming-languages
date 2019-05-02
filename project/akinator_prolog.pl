:- consult('db.pl').

start:-
  write('Think on a Marvel-DC hero-villain, I will try to guess it.'),
  nl,guess(X),
  write('Your character is '),
  write(X),nl,
  restart.

:- dynamic yes/1,no/1.

ask(P) :-
  write('Your character '),
  write(P), write('?: '),
  read(Input), nl,
  (Input == y -> assert(yes(P)); assert(no(P)), fail).

sex(S) :- (yes(S) -> true , !; (no(S) -> fail ; ask(S))).
eye_color(S) :- (yes(S) -> true , !; (no(S) -> fail ; ask(S))).
race(S) :- (yes(S) -> true , !; (no(S) -> fail ; ask(S))).
hair_color(S) :- (yes(S) -> true , !; (no(S) -> fail ; ask(S))).
publisher(S) :- (yes(S) -> true , !; (no(S) -> fail ; ask(S))).
skin_color(S) :- (yes(S) -> true , !; (no(S) -> fail ; ask(S))).
alignment(S) :- (yes(S) -> true , !; (no(S) -> fail ; ask(S))).
check(S) :- (yes(S) -> true , !; (no(S) -> fail ; ask(S))).

restart :-
    retractall(yes(_));
    retractall(no(_)).
restart.
