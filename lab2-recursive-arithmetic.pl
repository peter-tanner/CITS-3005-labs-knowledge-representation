% Lab 2 - Recursive Arithmetic in Prolog
% LABSHEET:
% https://teaching.csse.uwa.edu.au/units/CITS3005/labs/lab02-arithmetic.pdf

% Build a Prolog program to do recursive arithmetic. It should have

% 1. a constant, zero, to represent zero.
zero.

% 2. a function, next(X), that represents the next number (so next(zero) represents one).
next(X) :- X.

% 3. a predicate, sum(X,Y,Z), which is true if X + Y = Z.
% sum(zero,zero,Z) :- Z is zero.
% sum(zero,Y,Z) :- Z is Y.
% sum(next(zero),Y,Z) :- Z is next(Y).
sum(zero,zero,zero).                    % CASE 1 : 0 + 0 == 0
sum(zero,X,X).                          % CASE 2 : 0 + X == X
sum(next(X),Y,next(Z)) :- sum(X,Y,Z).   % CASE 3 : (X+1) + Y == (Z+1) (Works based on previous two cases???)
% TEST 1:
% sum(next(zero),next(zero),next(next(zero)))
%=sum(zero,next(zero),next(zero))   [ TRUE ]
% TEST 2:
% sum(next(next(zero)),zero,next(zero))
%=sum(next(zero),zero,zero)         [ FALSE ]

% 4. a predicate, mult(X,Y,Z) which is true if X × Y = Z.
mult(zero,zero,zero).
mult(zero,_,zero).
mult(next(zero),X,X).
mult(next(X),Y,Z) :- mult(X,Y,Zp), sum(Y,Zp,Z). % (x+1)*y == x*y+y

% 5. a predicate, equals(X,Y) which is true if X = Y .
equals(X,X).

% 6. a predicate, lessThan(X,Y) which is true if X < Y ¿
lessThan(zero,next(_)).
lessThan(next(X),next(Y)) :- lessThan(X,Y).     % X+1 < Y+1 => X < Y. As X->0, Y->N => 0 < N.

% binary_(zero,0).
% binary_(next(X),IntValue) :- binary_(X,PrevIntValue), write(PrevIntValue), IntValue is PrevIntValue+1.
% binary(X) :- binary_(X,Buffer), write(Buffer).


% Test your program and consider the efficinecy of the implementations. Is there a way to get faster annswers?
% Next, add additional functions:
% 1. Write a program binary(X) that will print the binary representation of X out, so for example, binary(next(next(zero)
% will print out 10.
% NOTE: Binary array is in reverse!
increment_b([],[]).
increment_b([ODigit | ORest],[Digit | Rest]) :- 
    ODigit =:= 0 -> Digit is 1,
    equals(Rest,ORest);
    ODigit =:= 1 -> Digit is 0,
    (
        equals(ORest,[]) -> equals(Rest,[1]);
        increment_b(ORest,Rest)
    ).

% NOTE: Binary array is in reverse!
binary_arr(zero,[0]).
binary_arr(next(X),NextBinary) :- 
    binary_arr(X,Binary),
    increment_b(Binary,NextBinary).

binary_arr_print([]).
binary_arr_print([Digit|Rest]) :- write(Digit), binary_arr_print(Rest).

binary(X) :-
    binary_arr(X,BinaryArrRev),
    reverse(BinaryArrRev, BinaryArr),
    binary_arr_print(BinaryArr).

% 2. Implement predicates for odd, even and prime numbers.
even(zero).
even(next(X)) :- \+even(X).

odd(X) :- \+even(X).

% Cheating a bit here ... would be harder doing the whole primality test in the above notation, since I don't have a modulo predicate defined
to_integer(zero,0).
to_integer(next(X),Integer) :- to_integer(X,OInteger), Integer is OInteger + 1.

not_prime_i(I,Comp) :- 
    Comp*Comp < I+1,
    (I mod Comp =:= 0; I mod (Comp + 2) =:= 0;
    not_prime_i(I,Comp+6)).

prime_i_entry(I) :- 
    I > 1, (I =:= 2; I =:= 3;
    I mod 2 =\= 0, I mod 3 =\= 0,
    \+not_prime_i(I, 5)).


prime(X) :- to_integer(X,I), prime_i_entry(I).