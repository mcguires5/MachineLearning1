%%Monty Hall Problem
%Pb = Proability of B = your pick of door 1
ProbB = 1/3;

%Pa = Probability of A = probability monty shows a goat behind door 2
ProbA = 1/2;

%Probability of the car behind my door
MyDoor = ProbA * ProbB + ProbB * 0 + ProbB * 1;

%The probability of A given B is 1/2 because Monty only has 2 doors to
%chose from
Ans = (ProbA * ProbB) / MyDoor
%The ans is 1/3 which means without moving your odds are 1/3 if you do move
%you chance is 2/3 which is because there are 2 choices and the total
%probability must equal 1