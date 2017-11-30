%Sean McGuire
%Gaussian Mixture Model
numberOfDataSets = 2;
%2 data sets with x and y
set1 = mvnrnd([2 3],[1,1],500);
set2 = mvnrnd([6 1],[1,1],500);
TotalData = [set1; set2];
delta = 1;
PreviousValue = 0;

d = length(set1);
mean1x = 1.7; 
mean2x = 6.5;
mean1y = 4;
mean2y = 1.5;

hold on;
title('Training Data')
plot(set1(:,1),set1(:,2), 'b.')
plot(set2(:,1),set2(:,2), 'r+')
hold off;
counter = 0;
while abs(delta) > 0.0001
    sum1x = 0;
    sum2x = 0;
    sum1y = 0;
    sum2y = 0;
    for i = 1:1000
       sum1x = sum1x + (TotalData(i,1)-mean1x);
       sum2x = sum2x + (TotalData(i,1)-mean2x);
       sum1y = sum1y + (TotalData(i,2) -mean1y);
       sum2y = sum2y + (TotalData(i,2) -mean2y);
    end
    covariance1x = abs(sum1x/(length(TotalData)-1));
    covariance2x = abs(sum2x/(length(TotalData)-1));
    covariance1y = abs(sum1y/(length(TotalData)-1));
    covariance2y = abs(sum2y/(length(TotalData)-1));
    likely1 = 0;
    likely2 = 0;
    post1 = 0;
    post2 = 0;
    Class1Meanx = 0;
    Class2Meanx = 0;
    Class1Meany = 0;
    Class2Meany = 0;
    TotLikelyX1 = 0;
    TotLikelyY1 = 0;
    TotLikelyX2 = 0;
    TotLikelyY2 = 0;
    STDevX1 = 0;
    STDevY1 = 0;
    STDevX2 = 0;
    STDevY2 = 0;
    for i = 1:1000
       likely1x = normpdf(TotalData(i,1),mean1x,covariance1x);
       likely2x = normpdf(TotalData(i,1),mean2x,covariance2x);
       likely1y = normpdf(TotalData(i,2),mean1y,covariance1y);
       likely2y = normpdf(TotalData(i,2),mean2y,covariance2y);

       
       
       %fprintf('Class 1 X: %d Y: %d STDx: %d STDy: %d\n', tmpMean1x, tmpMean1y,tmpMean2x,tmpMean2y);
       likely1 = likely1x *likely1y;
       likely2 = likely2x * likely2y;
       if i == 1
          Data1 = [];
          Data2 = [];
       end


       if(likely1x > likely2x)
           Class1Meanx = Class1Meanx + ((likely1x*.5)/(likely1x+likely2x))*TotalData(i,1);
           TotLikelyX1 = TotLikelyX1 + ((likely1x*.5)/(likely1x+likely2x));
           STDevX1 = STDevX1 + ((likely1x*.5)/(likely1x+likely2x))*((TotalData(i,1)-mean1x)^2);
       else
           Class2Meanx = Class2Meanx + ((likely2x*.5)/(likely1x+likely2x))*TotalData(i,1);
           TotLikelyX2 = TotLikelyX2 + ((likely2x*.5)/(likely1x+likely2x));
           STDevX2 = STDevX2 + ((likely2x*.5)/(likely1x+likely2x))*((TotalData(i,1)-mean2x)^2);
       end
           
       if(likely1y >= likely2y)
           Class1Meany = Class1Meany + ((likely1y*.5)/(likely1y+likely2y))*TotalData(i,2);
           TotLikelyY1 = TotLikelyY1 + ((likely1y*.5)/(likely1y+likely2y));
           STDevY1 = STDevY1 + ((likely1y*.5)/(likely1y+likely2y))*((TotalData(i,2)-mean1y)^2);
       else
           Class2Meany = Class2Meany + ((likely2y*.5)/(likely1y+likely2y))*TotalData(i,2);
           TotLikelyY2 = TotLikelyY2 + ((likely2y*.5)/(likely1y+likely2y));
           STDevY2 = STDevY2 + ((likely2y*.5)/(likely1y+likely2y))*((TotalData(i,2)-mean2y)^2);
       end
    end
    counter = counter + 1;
    covariance1x = STDevX1/TotLikelyX1;  
    covariance1y = STDevY1/TotLikelyY1;
    covariance2x = STDevX2/TotLikelyX2;  
    covariance2y = STDevY2/TotLikelyY2;
    mean1x = Class1Meanx/TotLikelyX1;
    mean1y = Class1Meany/TotLikelyY1;
    mean2x = Class2Meanx/TotLikelyX2;
    mean2y = Class2Meany/TotLikelyY2;
    fprintf('Class 1 X: %d Y: %d STDx: %d STDy: %d\n', mean1x, mean1y,covariance1x,covariance1y);
    fprintf('Class 2 X: %d Y: %d STDx: %d STDy: %d\n', mean2x, mean2y,covariance2x,covariance2y);
    delta = mean1x - PreviousValue;
    PreviousValue = mean1x;
end