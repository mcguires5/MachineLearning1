runs = 100;
Class1 = mvnrnd([2 4], [1 0;0 1], runs); 
Class2 = mvnrnd([5 9], [1 0;0 1], runs);
Class3 = mvnrnd([8 4], [1 0;0 1], runs);

data1r = padarray(Class1,[0 1], 1, 'post');
data2r = padarray(Class2,[0 1], 2, 'post');
data3r = padarray(Class3,[0 1], 3, 'post');
data = [data1r; data2r; data3r];

Trainning1 = data1r(1:runs*.7,:,:);
Testing1 = data1r(runs*.7 + 1:runs,:,:);
Trainning2 = data1r(1:runs*.7,:,:);
Testing2 = data1r(runs*.7 + 1:runs,:,:);
Trainning3 = data1r(1:runs*.7,:,:);
Testing3 = data1r(runs*.7 + 1:runs,:,:);

hold on;
title('Trainning Data')
for i = 1:runs*.7
        plot(data1r(i,1,1),data1r(i,2,1), 'b.')  
        plot(data2r(i,1,1),data2r(i,2,1), 'r+')
        plot(data3r(i,1,1),data3r(i,2,1), 'm*')
end
ThetaX = gradient(Trainning1,Trainning2,Trainning3);
ThetaY = gradient(Trainning2,Trainning1,Trainning3);
ThetaZ = gradient(Trainning3,Trainning1,Trainning2);

alpha = .005;
%Class1 (+1) vs Class2 (-1)
theta = [0 0 0];
thetaOld = [0; 0];
%%Shuffle data
data = data(randperm(size(data,1)),:);
for i = 1:runs
    for a = 1:runs*.7
        x = [1 data(i,1) data(i,2)];
        if(data(i,3) == 1)
            y = 1;
        elseif(data(i,3) == 2 || data(i,3) == 3)
            y = -1;
        end
        derivitiveCost = -y*x;  
    end
    theta = theta - (alpha .* derivitiveCost);
end
theta

function Output = gradient(Dataset1,Dataset2,Dataset3)
w0 = 1;
%Make bias term matrix
Weights = [w0;1;1];
eta = 1;
%Initialize cost function to zero
cost = 1;

TotalData = [Dataset1;Dataset2;Dataset3];

TotalDataX = TotalData(:,1);
TotalDataY = TotalData(:,2);

count = 0;
costs = [];
deltacost = 1;

while abs(deltacost) > 0.005
    
    cost = 0;
    sum = [1;0;0];
    
    l = length(c1) + 1;
    
    for i = 1:length(TotalData)
        x1 = TotalDataX(i);
        x2 = TotalDataY(i);
        X = [1;x1;x2];
        
        g = Weights' * X;
        
        if(i < l) %index at which class 1 stops
            y = 1;
        else
            y = -1;
        end
        if(y * g < 0)
            cost = cost - g*y;
            sum = sum - X*y;
        end
    end
    if count > 0
        deltacost = costs(length(costs)) - cost;
    else
        deltacost = abs(cost);
    end
    Weights = Weights - eta * sum;
    
    count = count + 1;
    costs = [costs cost];
    
end
W = Weights;
end

hold off;
%%
clear all; clc;
X = mvnrnd([1 10], [1 0; 0 1], 100); %OG data
Y = mvnrnd([4 5], [1 0;0 1], 100);
Z = mvnrnd([8 10], [1 0;0 1], 100);

X7 = X(1:70,1:2); %training data = 70% of ds
Y7 = Y(1:70,1:2);
Z7 = Z(1:70,1:2);

X3 = X(71:100,1:2); %testing data = 30% of ds
Y3 = Y(71:100,1:2);
Z3 = Z(71:100,1:2);

hold on
plot(X7(:,1),X7(:,2),'.'); %plot
plot(Y7(:,1),Y7(:,2),'+');
plot(Z7(:,1),Z7(:,2),'o');
title('Training Data');
hold off

Wx = grad(X7,Y7,Z7);
Wy = grad(Y7,X7,Z7);
Wz = grad(Z7,X7,Y7);

classify(Wx,Wy,Wz,X3,Y3,Z3);

function w = grad(c1,c2,c3)
w0 = 1;
w = [w0;1;1];
eta = 1;
cost = 1;

z = vertcat(c1,c2,c3);

z1 = z(:,1);
z2 = z(:,2);

count = 0;
costs = [];
deltacost = 1;

while abs(deltacost) > 0.005
    
    cost = 0;
    sum = [1;0;0];
    
    l = length(c1) + 1;
    
    for i = 1:length(z)
        x1 = z1(i);
        x2 = z2(i);
        X = [1;x1;x2];
        
        g = w' * X;
        
        if(i < l) %index at which class 1 stops
            y = 1;
        else
            y = -1;
        end
        if(y * g < 0)
            cost = cost - g*y;
            sum = sum - X*y;
        end
    end
    if count > 0
        deltacost = costs(length(costs)) - cost;
    else 
        deltacost = abs(cost);
    end
    w = w - eta * sum;
    
    count = count + 1;
    costs = [costs cost];
    
end
W = w;
end

function classify(w1,w2,w3,c1,c2,c3)

z = vertcat(c1,c2,c3);

z1 = z(:,1);
z2 = z(:,2);

Cx = [];
Cy = [];
Cz = [];

for i = 1:length(z)
    x1 = z1(i);
    x2 = z2(i);
    X = [1;x1;x2];

    gx = w1'*X;
    gy = w2'*X;
    gz = w3'*X;
    
    class = max([gx,gy,gz]);
    if (class == gx)
        Cx = [Cx;z(i,1) z(i,2)];
    elseif(class == gy)
        Cy = [Cy;z(i,1) z(i,2)];
    elseif(class == gz)
        Cz = [Cz;z(i,1) z(i,2)];
    end
end

figure;
hold on
plot(Cx(:,1),Cx(:,2),'.'); %plot
plot(Cy(:,1),Cy(:,2),'+');
plot(Cz(:,1),Cz(:,2),'o');
title('Testing Data');
hold off

end

