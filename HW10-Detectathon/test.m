y1 = load("door1.mat").y;  % row vector of interarrival times
n  = length(y1);           % 12,894

k = 20
lambda = sum(y1(1:20))


P = (lambda^k * exp(-lambda)) / factorial(k);

fprintf("P: %6.5f\n", P);