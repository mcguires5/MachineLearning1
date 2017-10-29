data = twospirals(1000, 180, 0, 5);
firstSet = data(1:500,1:2);
secondSet = data(501:1000,1:2);
hold on;
plot(firstSet(:,1),firstSet(:,2));
plot(secondSet(:,1),secondSet(:,2));
hold off;
Mdl = fitcsvm(X,Y)