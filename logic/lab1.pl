% Marco Mancha A01206194
% LAB 1 PROLOG

% BK of hobbies
hobby(juan,kaggle). 
hobby(luis,hack). 
hobby(elena,tennis). 
hobby(midori,videogame). 
hobby(simon,sail).
hobby(simon,kaggle).
hobby(laura,hack).
hobby(hans,videogame).

%Function that consults if X share a hobby with Y
compatible(X,Y):-
  hobby(X,Z),
  hobby(Y,Z).

% BK of roads to roma
road(placentia, ariminum).
road(placentia, genua).
road(genua, pisae).
road(genua, roma).
road(pisae, roma).
road(ariminum, ancona).
road(ariminum,roma).
road(ancona, roma).
road(ancona, castrum).
road(castrum, roma).
road(capua, roma).
road(brundisium, capua).
road(messana, capua).
road(rhegium ,messana).
road(lilibeum, messana).
road(catina, rhegium).
road(syracusae, catina).

% Function that consults if there is a path from Origin to Destination
can_get_to(Origin, Destination):-
  road(Origin, Destination);
  road(Origin, Next),
  can_get_to(Next, Destination).

% Function that consults the size of a path where X is origin, Y is destination and Z is size of path
size(X,Y,Z):-
  road(X,Y),
  Z is 1;
  road(X,W),
  size(W,Y,V),
  Z is V + 1.

% Function that consults the smallest number between A,B and C, Z is the smallest of the 3.
min(A,B,C,Z):-
  A = B, B = C, Z is A;
  A = B, B < C, Z is A;
  A = B, B > C, Z is C;
  A = C, C < B, Z is A;
  A = C, C > B, Z is B;
  B = C, B < A, Z is B;
  B = C, B > A, Z is A;
  A < B, A < C, Z is A;
  B < A, B < C, Z is B;
  C < A, C < B, Z is C.

%Base Case of gcd
gcd(Z,0,Z):-!.

% Function that consults the greatest common denominator of A and B, where Z is the GCD
gcd(A,B,Z):-
  C is A mod B,
  gcd(B,C,Z).
