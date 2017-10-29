x1 = mvnrnd([-1 1],[0.9 0.1;0.1 0.6],500);
x2 = mvnrnd([2 3],[1 -0.5;-0.5 1],500);
x3 = mvnrnd([3 0],[0.9 0.1;0.1 0.6],500);

f = [x1;x2;x3];
labels = [];
data = [f labels];
mdl = fitcnb(f,labels);
pre = md1.predict(f);
chk = (pre == labels);
per = sum(chk)/length(labels)*100;
scatter(f(:,1),f(:,2),10,labels);
figure
scatter(f(:,1),f(:,2),10,pre);