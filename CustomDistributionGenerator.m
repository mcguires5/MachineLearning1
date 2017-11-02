clc
clf
%MU must add up to 1
mu=[.01 .04 .05 .3 .1 .1 .2 .2];
if(sum(mu(:)) ~= 1)
   disp("Probabilities must add to 1"); 
end
if(sum(mu(:)) == 1)
sampleNum = 100000;
Output = zeros(sampleNum, 1);
for j = 1:sampleNum
    tmpSum=0;
    tmprand = rand;
    for i =1:length(mu)
        if( tmprand >= tmpSum && tmprand <= tmpSum + mu(i))
            Output(j) = i;
        end
        tmpSum = tmpSum + mu(i);
    end
end
histogram(Output)
end
