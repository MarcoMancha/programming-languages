:- use_module(library(jpl)).
:- consult('db.pl').

start:-
  output('Think on a Marvel-DC hero-villain, I will try to guess it.'),
  guess(X),
  atom_concat('Your character is ', X, A),
  output(A),
  play_again.

:- dynamic yes/1,no/1.

ask(P) :-
  atom_concat('Your character ', P, A),
  atom_concat(A, '?: (y/n)', Q),
  input(Q,N),
  (N == y -> assert(yes(P)); assert(no(P)), fail).

sex(S) :- (yes(S) -> true , !; (no(S) -> fail ; ask(S))).
eye_color(S) :- (yes(S) -> true , !; (no(S) -> fail ; ask(S))).
race(S) :- (yes(S) -> true , !; (no(S) -> fail ; ask(S))).
hair_color(S) :- (yes(S) -> true , !; (no(S) -> fail ; ask(S))).
publisher(S) :- (yes(S) -> true , !; (no(S) -> fail ; ask(S))).
skin_color(S) :- (yes(S) -> true , !; (no(S) -> fail ; ask(S))).
alignment(S) :- (yes(S) -> true , !; (no(S) -> fail ; ask(S))).
check(S) :- (yes(S) -> true , !; (no(S) -> fail ; ask(S))).

play_again:-
  input('Play again? (y/n)',N),
  (N == y -> restart, start; jpl_call('java.lang.System', exit, [0], _)).

output(A):-
  window(W),
  jpl_call('javax.swing.JOptionPane', showMessageDialog, [W,A], _),
  jpl_call(W, dispose, [], _).

input(Q,N):-
  window(W),
  jpl_call('javax.swing.JOptionPane', showInputDialog, [W,Q,y], N),
  jpl_call(W, dispose, [], _).

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


restart :- retractall(yes(_)), fail.
restart :- retractall(no(_)), fail.
restart.
