mu= [5, 10];
sigma = [0.9 0.4;0.4 0.3];
X = -5:0.1:5; 
Y = -10:0.1:-5;
data = normrnd(mu, sigma, 20 , 1)
