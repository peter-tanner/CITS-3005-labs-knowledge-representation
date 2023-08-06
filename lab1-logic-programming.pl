% Lab 1 - logic programming
% LABSHEET:
% https://teaching.csse.uwa.edu.au/units/CITS3005/labs/lab01-logic-programming.pdf

student(jane).
student(tim).
student(cris).

unit(cits3005).
unit(cits2211).

prerequisite(cits2211,cits3005).

mark(cits3005,jane,Result) :- Result is 50.
mark(cits2211,jane,Result) :- Result is 57.

mark(cits2211,tim,Result) :- Result is 30.

mark(cits2211,cris,Result) :- Result is 60.

eligible(Student,Unit) :- 
    student(Student),
    unit(Unit),
    (
        % CASE 1: Unit has no prerequisites
        \+ prerequisite(_, Unit),
        !;
        
        % CASE 2: Unit has prerequisites AND Student's mark in the prerequisite unit >= 50
        prerequisite(PreUnit,Unit),
        mark(PreUnit,Student,Result),
        Result >= 50
    ).
