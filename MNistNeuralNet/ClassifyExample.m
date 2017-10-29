clc
a = imread('TestImage.png');
normImage = mat2gray(a);
b = rgb2gray(a);
BW = uint8(255) - b;
BW = imbinarize(BW,.5);
BW = padarray(BW,[4 4],0,'both');
%%Make input 20x20 go to 28x28
B = reshape(BW,[784,1]);
pre = net1(B);
highestProb = 0;
tmp = -999999;
for i = 1:10
    if(pre(i)>tmp)
       tmp = pre(i);
       highestProb = i - 1;
    end
end
fprintf('Classified as a %i with likelihood of %f\n', highestProb, tmp);