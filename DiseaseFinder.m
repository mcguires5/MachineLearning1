%%Disease problem

%Probability that any person in population has disease
ProbDisease = 0.01;

%Probability that you have the disease when you test positive
ProbPos = 0.9;

%Probability that you do not have the disease when you test negative
%1-ProbNeg is used because we want the probability that the test was wrong
%and you did have the disease
ProbNeg = .98;

Ans = (ProbDisease * ProbPos)/((ProbDisease * ProbPos) + ((1-ProbDisease) * (1-ProbNeg)))