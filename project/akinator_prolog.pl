%      Prolog application that guess the hero/villain
%      Copyright (C) 2019 Marco Antonio Mancha Alfaro
%
%      This program is free software: you can redistribute it and/or modify
%      it under the terms of the GNU General Public License as published by
%      the Free Software Foundation, either version 3 of the License, or
%      (at your option) any later version.
%
%      This program is distributed in the hope that it will be useful,
%      but WITHOUT ANY WARRANTY; without even the implied warranty of
%      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%      GNU General Public License for more details.
%
%      You should have received a copy of the GNU General Public License
%      along with this program.  If not, see <https://www.gnu.org/licenses/>

% Consult the knowledge base
:- consult('db.pl').

% Function to start the game and output solution
start:-
  write('Think on a Marvel-DC hero-villain, I will try to guess it.'),
  nl,guess(X),
  write('Your character is '),
  write(X),nl,
  restart.
% Dynamic functions
:- dynamic yes/1,no/1.

% Function to display a question and obtain the input
ask(P) :-
  write('Your character '),
  write(P), write('?: '),
  read(Input), nl,
  (Input == y -> assert(yes(P)); assert(no(P)), fail).

% Functions to check if a fact is already asserted
sex(S) :- (yes(S) -> true , !; (no(S) -> fail ; ask(S))).
eye_color(S) :- (yes(S) -> true , !; (no(S) -> fail ; ask(S))).
race(S) :- (yes(S) -> true , !; (no(S) -> fail ; ask(S))).
hair_color(S) :- (yes(S) -> true , !; (no(S) -> fail ; ask(S))).
publisher(S) :- (yes(S) -> true , !; (no(S) -> fail ; ask(S))).
skin_color(S) :- (yes(S) -> true , !; (no(S) -> fail ; ask(S))).
alignment(S) :- (yes(S) -> true , !; (no(S) -> fail ; ask(S))).
check(S) :- (yes(S) -> true , !; (no(S) -> fail ; ask(S))).

% Restart game, undo all assertions
restart :-
    retractall(yes(_));
    retractall(no(_)).
restart.
