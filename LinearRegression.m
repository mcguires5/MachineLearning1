%%Linear Regrssion
n= 1000;
%Develop noise which is a random number 
noise = rand(n,1);
%Subtract .5 so noise is centered around the line
noise = noise - (.5);
%use random number between 0 and .05 to base the y values off of
x = rand(n,1).*05;
y = 4 + 4*x + noise;
%Plot points
plot(x,y,'.');
%Add column of 1's to x
x = [ones(size(x)) x];
itterations = 10000;
theta = zeros(2,1);
StepSize = 0.05;
for i = 1:itterations
    h = zeros(n,1);
    in1=0;
    in2=0;

    for p = 1:n
        %Hypothesis theta(1,1) is the intercept theta (2,1) is the
        %coefficent of x
        h(p) = theta(1,1)+ theta(2,1)*x(p,2); 
        %Add Hypothesis for y
        in1 = in1+(h(p)-y(p));
        %Add Hypothesis for x
        in2 = in2+(h(p)-y(p))*x(p,2);
    end
    %Set Theta 
    theta(1,1)=theta(1,1)-(StepSize*1/(2*n)*in1);
    theta(2,1)=theta(2,1)-(StepSize*1/(2*n)*in2);
    %Prints out theta values to show improvement over time
    theta
end
