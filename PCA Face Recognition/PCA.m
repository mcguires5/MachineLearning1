%Sean McGuire
%PCA from Yale Face Database
%http://vision.ucsd.edu/content/yale-face-database
Image = {6,1};
FinalOutput = {6,1};
%Read images of subects with glasses into the Image cell array
for i = 1:6
    Image{i,1} = im2double(imread(strcat('subject0',num2str(i),'.glasses.gif')));
end
%Choose the input subject, subject 1 or 2 with happy expression
Input = im2double(imread('subject02.happy.gif'));
%Input = im2double(imread('subject01.happy.gif'));

%Add Noise
Input = imnoise(Input,'gaussian',0.1);
%Display Input Image
figure;
imshow(Input)
title('Input Image')
%Perform PCA on Input Image
ModifiedOriginal = PCAFunction(Input,10);
for i = 1:6
    %Add noise
    Image{i,1} = imnoise(Image{i,1},'gaussian',0.1);
    %Perform PCA on Images
    Output{i,1} = PCAFunction(Image{i,1},10);
end
%initilize minDistance to a large number so it can be changed on first
%itteration
minDistance = 100000000;
%Variable shows which subect is the closest to the input
bestMatch = 0;
%Create figure with all subjects to select from
figure;
suptitle('Subjects to Select From')
for i = 1:6
    subplot(2,3,i), imshow(Image{i,1}), title(strcat('Subject',{' '}, num2str(i)))
    distance = sqrt(sum((ModifiedOriginal-Output{i,1}).^2));
    d = average(distance(:,:));
    if d < minDistance
        minDistance = d;
        bestMatch = i;
    end
end
%Print the closest match to console
disp(bestMatch);
%Performing PCA function
function ImOut = PCAFunction(Image,k)
%Mean contains the average of every column repeated for all of the rows
Mean = repmat(mean(Image),length(Image(:,1)),1);
%Normalize the data by subtracting the original image values from the mean
Norm = Image - Mean;
%Calculates the covarriance of the normalized image
Covariance = cov(Norm);
%Returns the eigenvectors of the covariance matrix
[V, D] = eig(Covariance,'vector');
tmp = length(V)-(k-1);
%Takes the highest k eigenvectors and sets them to Output
Output = V(:,tmp:length(V(1,:)));
%The output image can be reconstructed by multiplying the Image by the
%output and the transpose of the output
ImOut = Image*Output*Output';
end



