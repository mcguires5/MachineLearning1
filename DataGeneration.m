mu = [-1.5 1.5];
mu2 = [-1 1];
sigma = [1 0.4;0.4 0.7];


data = mvnrnd(mu,sigma,1000);
data2 = mvnrnd(mu,sigma,1000);
figure
hold on;
plot(data(:,1),data2(:,1),'r.');
plot(data(:,2),data2(:,2),'b.');
hold off;


mu = [0 0];
sigma = [1 0.3;0.3 0.5];

data = mvnrnd(mu,sigma,1000);
data2 = mvnrnd(mu2,sigma,1000);
figure
hold on;

for i = 1:length(data)
    plot(data(i,1),data2(i,1),'b.');
end
for i = 1:length(data)
    plot(data(i,2),data2(i,2),'r.');
end
hold off;
