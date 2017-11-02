clf
%Linearly Seperable
mu = [-1.5 1.5];
sigma = [1 0.4;0.4 0.7];
data = mvnrnd(mu,sigma,1000);
data2 = mvnrnd(mu,sigma,1000);
figure
hold on;
plot(data(:,1),data2(:,1),'r.');
plot(data(:,2),data2(:,2),'b.');
hold off;

%Overlapping Data
mu = [-3 -1];
mu2 = [0 3];
mu3 = [4 7];
sigma = [1 0.3;0.3 0.5];
data = mvnrnd(mu,sigma,1000);
data2 = mvnrnd(mu2,sigma,1000);
data3 = mvnrnd(mu3,sigma,1000);
figure
hold on;
for i = 1:length(data)
    plot(data(i,1),data(i,2),'b.');
end
for i = 1:length(data2)
    plot(data2(i,1),data2(i,2),'r.');
end
for i = 1:length(data3)
    plot(data3(i,1),data3(i,2),'m.');
end
hold off;

mu = [0 0];
mu2 = [-1 1];
sigma = [1 0.3;0.3 0.5];
%Overlapping Data
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