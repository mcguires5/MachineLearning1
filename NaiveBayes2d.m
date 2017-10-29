numberOfDataSets = 2;
%2 data sets with x and y
set1 = mvnrnd([0 1],[1,1],1000);
set2 = mvnrnd([3 4],[1,1],1000);

d = length(set1);
mean1x = mean(set1(:,1)); 
mean2x = mean(set2(:,1));
mean1y = mean(set1(:,2));
mean2y = mean(set2(:,2));

hold on;
title('Training Data')
plot(set1(:,1),set1(:,2), 'b.')
plot(set2(:,1),set2(:,2), 'r+')
hold off;
sum1x = 0;
sum2x = 0;
sum1y = 0;
sum2y = 0;

for i = 1:700
   sum1x = sum1x + (set1(i,1)-mean1x)^2;
   sum2x = sum2x + (set2(i,1)-mean2x)^2;
   sum1y = sum1y + (set1(i,2) -mean1y)^2;
   sum2y = sum2y + (set2(i,2) -mean2y)^2;
end
covariance1x = sum1x/length(set1);
covariance2x = sum2x/length(set2);
covariance1y = sum1y/length(set1);
covariance2y = sum2y/length(set2);
likely1 = 0;
likely2 = 0;
post1 = 0;
post2 = 0;
figure
hold on
title('Test Data');
    for i = 1:300
       likely1x = normpdf(set1(i+700,1),mean1x,covariance1x);
       likely2x = normpdf(set1(i+700,1),mean2x,covariance2x);
       likely1y = normpdf(set1(i+700,2),mean1y,covariance1y);
       likely2y = normpdf(set1(i+700,2),mean2y,covariance2y);
       likely1 = likely1x *likely1y;
       likely2 = likely2x * likely2y;
       if(likely1 > likely2)
            post1 = post1 + 1;
            plot(set1(i+700,1), set1(i+700,2),'b.');
       end
       if(likely2 > likely1)
            post2 = post2 + 1;
            plot(set2(i+700,1), set2(i+700,2),'r+');
       end
    end
    
    disp("In first distribution number classified as first " + post1);
    disp("In first distribution number classified as Second " +post2);
    post1 = 0;
    post2 = 0;
    %2nd distribution
    for i = 1:300
       likely1x = normpdf(set2(i+700,1),mean1x,covariance1x);
       likely2x = normpdf(set2(i+700,1),mean2x,covariance2x);
       likely1y = normpdf(set2(i+700,2),mean1y,covariance1y);
       likely2y = normpdf(set2(i+700,2),mean2y,covariance2y);
       likely1 = likely1x *likely1y;
       likely2 = likely2x * likely2y;
       if(likely1 > likely2)
            post1 = post1 + 1;
            plot(set1(i+700,1), set1(i+700,2),'b.');
       end
       if(likely2 > likely1)
            post2 = post2 + 1;
            plot(set2(i+700,1), set2(i+700,2),'r+');
       end
    end
    hold off
    disp("In second distribution number classified as first " + post1);
    disp("In second distribution number classified as second " + post2);
