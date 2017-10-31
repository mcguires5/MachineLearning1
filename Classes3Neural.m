runs = 100;
Class1 = mvnrnd([2 4], [1 0;0 1], runs); 
Class2 = mvnrnd([5 9], [1 0;0 1], runs);
Class3 = mvnrnd([8 4], [1 0;0 1], runs);
data1r = padarray(Class1,[0 1], 1, 'post');
data2r = padarray(Class2,[0 1], 2, 'post');
data3r = padarray(Class3,[0 1], 3, 'post');
data = [data1r; data2r; data3r];
hold on;
title('Training Data')
for i = 1:runs*3
    if(data(i,3) == 1)
        plot(data(i,1,1),data(i,2,1), 'b.')  
    elseif(data(i,3) == 2)
        plot(data(i,1,1),data(i,2,1), 'r+')
    elseif(data(i,3) == 3)
        plot(data(i,1,1),data(i,2,1), 'm*')
    end
end

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

hold off;
