clf
clear all;
clc
data = twospirals(1000, 360, 0, .5);
%Train with 80% first set (1-400) second (500-900)
firstSet = data(1:400,1:2);
secondSet = data(501:900,1:2);
TrainSet = [firstSet; secondSet];
TestSet = [data(401:500,1:2); data(901:1000,1:2)];
labels = [ones(400,1); 2*ones(400,1)];
hold on;
title('Training Data');
plot(firstSet(:,1),firstSet(:,2), '.r');
plot(secondSet(:,1),secondSet(:,2), '.b');
hold off;
%Kernel Scale auto gives best result
% 0.15  correct
% 0.01  incorrect
% 0.008 incorrect
% 0.005 incorrect
% 0.001 Way off
Model = fitcsvm(TrainSet,labels,'standard',true,'Boxconstraint',1,'kernelFunction','RBF','KernelScale','auto');

[result,score] = predict(Model,TestSet);
figure
hold on
title('Testing Data');
for i = 1:200
    if(result(i) == 1)
        plot(data(i+400,1),data(i+400,2),'.r');
    else
       plot(data((i-100)+900,1),data((i-100)+900,2),'.b');
        
    end
    
end
hold off