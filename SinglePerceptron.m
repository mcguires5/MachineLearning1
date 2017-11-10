Points = 100;
Class1 = mvnrnd([1 8], [1 0;0 1], Points);
Class2 = mvnrnd([6 7], [1 0;0 1], Points);
Class3 = mvnrnd([2 4], [1 0;0 1], Points);

%Create trainning and testing data
Trainning1 = Class1(1:Points*.7,1:2);
Testing1 = Class1(Points*.7 + 1:Points,1:2);
Trainning2 = Class2(1:Points*.7,1:2);
Testing2 = Class2(Points*.7 + 1:Points,1:2);
Trainning3 = Class3(1:Points*.7,1:2);
Testing3 = Class3(Points*.7 + 1:Points,1:2);

%Plot Trainning Data
hold on;
title('Trainning Data')
for i = 1:Points*.7
    plot(Trainning1(i,1,1),Trainning1(i,2,1), '*r')
    plot(Trainning2(i,1,1),Trainning2(i,2,1), '+b')
    plot(Trainning3(i,1,1),Trainning3(i,2,1), 'om')
end
hold off;
%All theta values are returned from calling the gradient
Theta1 = gradient(Trainning1(:,:),Trainning2(:,:),Trainning3(:,:));
Theta2 = gradient(Trainning2(:,:),Trainning1(:,:),Trainning3(:,:));
Theta3 = gradient(Trainning3(:,:),Trainning1(:,:),Trainning2(:,:));

classify(Theta1,Theta2,Theta3,Testing1,Testing2,Testing3);

function Output = gradient(Dataset1,Dataset2,Dataset3)

%Make bias term matrix Initizilze to 1
Weights = [1;1;1];
%Initialize cost function to zero
cost = 1;
TotalData = [Dataset1;Dataset2;Dataset3];

TotalDataX = TotalData(:,1);
TotalDataY = TotalData(:,2);

count = 0;
Allcosts = [];
deltacost = 1;
CutOff = 0.05;
while abs(deltacost) > CutOff
    cost = 0;
    sum = [1;0;0];
    l = length(Dataset1) + 1;
    
    for i = 1:length(TotalData)
        X = [1;TotalDataX(i);TotalDataY(i)];
        g = Weights' * X;
        if(i < l) %if it is less than one then it is from class 1
            y = 1;
        else %if it is greater than one then it is from a different class
            y = -1;
        end
        %If classification inccorect update cost and sum
        if(y * g < 0)
            cost = cost - g*y;
            sum = sum - X*y;
        end
    end
    if count > 0
        %Change cost function for higher itterations
        deltacost = Allcosts(length(Allcosts)) - cost;
    else
        %Initilization of cost function
        deltacost = abs(cost);
    end
    Weights = Weights - 1 * sum;
    
    count = 1;
    Allcosts = [Allcosts cost];
end
Output = Weights;
end


function classify(Theta1,Theta2,Theta3,DataSet1,DataSet2,DataSet3)

TotalData = [DataSet1;DataSet2;DataSet3];

TotalDataX = TotalData(:,1);
TotalDataY = TotalData(:,2);

Class1Data = [];
Class2Data = [];
Class3Data = [];

for i = 1:length(TotalData)
    X = [1;TotalDataX(i);TotalDataY(i)];
    %returns the value predicted for each class
    Class1Value = Theta1'*X;
    Class2Value = Theta2'*X;
    Class3Value = Theta3'*X;
    
    %The Correct Class has the highest Predicted Value
    CorrectClass = max([Class1Value,Class2Value,Class3Value]);
    %Append data to the class data
    if (CorrectClass == Class1Value)
        Class1Data = [Class1Data;TotalData(i,1) TotalData(i,2)];
    elseif(CorrectClass == Class2Value)
        Class2Data = [Class2Data;TotalData(i,1) TotalData(i,2)];
    elseif(CorrectClass == Class3Value)
        Class3Data = [Class3Data;TotalData(i,1) TotalData(i,2)];
    end
end

%Plot All Classes of Data
figure;
hold on
plot(Class1Data(:,1),Class1Data(:,2),'*r'); %plot
plot(Class2Data(:,1),Class2Data(:,2),'+b');
plot(Class3Data(:,1),Class3Data(:,2),'om');
title('Testing Data');
hold off


end

