%Original Data
X= mvnrnd([1 10], [1 0; 0 1], 100); 
Y = mvnrnd([3 7], [1 0;0 1], 100);

%plot
figure
hold on
plot(X(:,1),X(:,2),'.'); 
plot(Y(:,1),Y(:,2),'+');
title('Training Data');
hold off
%Theta values
theta = [0;0;0];

z = [X; Y];
[rZ cZ] = size(z);
TotalX = z(:,1);
TotalY = z(:,2);

cost = 1;
alpha = 0.0005;
sum = [0;0;0];
Class1Points = [];
Class2Points = [];
count =0;
costs=[];
%Change in cost function
deltacost = 1;
while abs(deltacost) > 0.05
    cost = 0;
    sum = [0;0;0];
    for i = 1:rZ
        x = [1;TotalX(i);TotalY(i)];
        %Hypothesis
        h = (1/(1+exp(-(theta'*x))));
        if(i < 101)
            %First Class
            y = 0;
            %Compute Cost
            cost = cost + (-log(1-h));
            sum = sum + (h-y)*x;
        elseif(i >= 101)
            %Second Class
            y =1;
            %Compute Cost
            cost = cost + (-log(h));
            sum = sum+ (h-y)*x;
        end
    end
    if count > 0
        %Previous cost - cost
        deltacost = costs(length(costs)) - cost;
    end
    theta = theta - alpha * sum;
    count = count+1;
    costs = [costs cost];
end
disp(theta);

%Count in class 1 and 2
countClass1 = 0;
countClass2 = 0;

for i = 1:length(z)
    %Compute Hypothesis at every point in total data set
    x = [1;TotalX(i);TotalY(i)];
    h = (1/(1+exp(-(theta'*x))));
    
    %Matricies are created for all points expected in class 1 and 2
    
    %Hypothesis greater than .5 class 1 incremented
    if (h < 0.5)
        Class1Points = [Class1Points;z(i,1) z(i,2)];
        countClass1 = countClass1 + 1;
    %Hypothesis Less than .5 class 2 incremented
    elseif( h >= 0.5)
        Class2Points = [Class2Points;z(i,1) z(i,2)];
        countClass2 = countClass2 + 1;
    end
end
%Plot the predicted classes
figure
fprintf('Amount in class 1 %d /n', countClass1);
fprintf('Amount in class 2 %d /n', countClass1);
hold on
plot(Class1Points(:,1),Class1Points(:,2),'.'); %plot
plot(Class2Points(:,1),Class2Points(:,2),'+');
title('Test Data');
hold off

labels = [ones(1,100) 2*ones(1,100)];
%Matlabs built in logestic regression function
%B = mnrfit(z,labels'); 
%disp('Matlabs Built in predicted values ');
%disp(B);