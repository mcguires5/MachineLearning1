numberOfDataSets = 2;

x1 = mvnrnd(0,1,1000);
x2 = mvnrnd(4,1,1000);

d = length(x1);
mean1 = sum(x1(:))/length(x1); 
mean2 = sum(x2(:))/length(x2); 
hold on;
histogram(x1)
histogram(x2)
hold off;
sum1 = 0;
sum2 = 0;
for i = 1:700
   sum1 = sum1 + (x1(i)-mean1)^2;
   sum2 = sum2 + (x2(i)-mean2)^2;
end
covariance1 = sum1/length(x1);
covariance2 = sum2/length(x2);

likely1 = 0;
likely2 = 0;
post1 = 0;
post2 = 0;
    for i = 1:300
       likely1 = normpdf(x1(i+700),mean1,covariance1);
       likely2 = normpdf(x1(i+700),mean2,covariance2);
       
       if(likely1 > likely2)
            post1 = post1 + 1;   
       end
       if(likely2 > likely1)
            post2 = post2 + 1;
       end
    end
    
    disp("In first distribution number classified as first " + post1);
    disp("In first distribution number classified as Second " +post2);
    post1 = 0;
    post2 = 0;
    %2nd distribution
    for i = 1:300
       likely1 = normpdf(x2(i+700),mean1,covariance1);
       likely2 = normpdf(x2(i+700),mean2,covariance2);
       
       if(likely1 > likely2)
            post1 = post1 + 1;   
       end
       if(likely2 > likely1)
            post2 = post2 + 1;
       end
    end
    
    disp("In second distribution number classified as first " + post1);
    disp("In second distribution number classified as second " + post2);
