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

% Import JPL library
:- use_module(library(jpl)).

% Consult the knowledge base
:- consult('db.pl').

% Function to start the game and output solution
start:-
  output('Think on a Marvel-DC hero-villain, I will try to guess it.'),
  guess(X),
  atom_concat('Your character is ', X, A),
  output(A),
  play_again.

% Dynamic functions
:- dynamic yes/1,no/1.

% Function to display a question and obtain the input
ask(P) :-
  atom_concat('Your character ', P, A),
  atom_concat(A, '?: (y/n)', Q),
  input(Q,N),
  (N == y -> assert(yes(P)); assert(no(P)), fail).

% Functions to check if a fact is already asserted
sex(S) :- (yes(S) -> true , !; (no(S) -> fail ; ask(S))).
eye_color(S) :- (yes(S) -> true , !; (no(S) -> fail ; ask(S))).
race(S) :- (yes(S) -> true , !; (no(S) -> fail ; ask(S))).
hair_color(S) :- (yes(S) -> true , !; (no(S) -> fail ; ask(S))).
publisher(S) :- (yes(S) -> true , !; (no(S) -> fail ; ask(S))).
skin_color(S) :- (yes(S) -> true , !; (no(S) -> fail ; ask(S))).
alignment(S) :- (yes(S) -> true , !; (no(S) -> fail ; ask(S))).
check(S) :- (yes(S) -> true , !; (no(S) -> fail ; ask(S))).

% Display the play again menu and obtain input
play_again:-
  input('Play again? (y/n)',N),
  (N == y -> restart, start; jpl_call('java.lang.System', exit, [0], _)).

% Display a message using JPL
output(A):-
  window(W),
  jpl_call('javax.swing.JOptionPane', showMessageDialog, [W,A], _),
  jpl_call(W, dispose, [], _).

% Display a question and obtain input
input(Q,N):-
  window(W),
  jpl_call('javax.swing.JOptionPane', showInputDialog, [W,Q,y], N),
  jpl_call(W, dispose, [], _).

% General facts to use JPL
window(W):-
  jpl_new('javax.swing.JFrame', ['Guess Who'], W),
  jpl_new('javax.swing.JLabel',['Before playing, I suggest to consult your character information here:  https://www.superherodb.com/search/'],L),
  jpl_new('javax.swing.JPanel',[],Pn),
  jpl_call(Pn,add,[L],_),
  jpl_call(W,add,[Pn],_),
  jpl_call(W, setLocation, [0,0], _),
  jpl_call(W, setSize, [1920,1080], _),
  jpl_call(W, setVisible, [@(true)], _),
  jpl_call(W, toFront, [], _).

% Restart game, undo all assertions
restart :- retractall(yes(_)), fail.
restart :- retractall(no(_)), fail.
restart.
