set1 = mvnrnd([0 1],[1,1],1000);
set2 = mvnrnd([3 4],[1,1],1000);
%%CONSTC
c = 10;
hold on;
title('Training Data')
plot(set1(:,1),set1(:,2), 'b.')
plot(set2(:,1),set2(:,2), 'r+')
hold off;

x = [set1(:,1) set2(:,2)];
t = ones(length(set1),1);
x = [t x];
w1 = ones(3,1);
w2 = zeros(length(set1),1);
w = [w1;w2];

H1 = [eye(3,3) zeros(3,1000)];
temp = zeros(1000,1003);
H1 = [H1; temp];
H2 = zeros(length(set1)+3);
H = H1 + H2;
Hfirst = ones(3+ length(set1),1);

Greek = ones(length(set1),1);

y1 = ones(length(set1)/2,1);
y2 = ones(length(set1)/2,1);
y = [y1; -y2];

Yi = diag(y);

b = ones(1,length(set1));
b = b.*-1;
xt = x';
t = zeros(3,1);
p = c*ones(length(set1),1);
f = [t;p];

A = (Yi*x)+Hfirst;


lb = [-inf(3,1); zeros(length(set1),1)];

run = quadprog(H,f,-A,-b,[],[],lb,[]);
