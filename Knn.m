prevError = 1;
bestK = 0;
for i = 1:50
    
    data1 = mvnrnd([2 5],[1,.8;.8,1],100);
    data2 = mvnrnd([3 7],[1,.8;.8,1],100);
    %Pads on a zero for the first data set
    data1r = padarray(data1,[0 1], 'post');
    %Pads on a 1 for the second data set
    data2r = padarray(data2,[0 1], 1, 'post');
    %Combinds set into one data set
    data = [data1r; data2r];
    %Strip positions from the data set
    pos = data(1:200, 1:2);
    %data row 1 x row 2 y row 3 class
    Mdl = fitcknn(pos,data(1:200, 3),'NumNeighbors',i,'Standardize',1)
    
    %Do crossvalidation
    CVKNNMdl = crossval(Mdl);
    classError = kfoldLoss(CVKNNMdl)
    %If the loss is less than the previous best loss then replace it
    if(classError < prevError)
        prevError = classError
        bestK = i
    end
end
hold on
%Plot first class of points
plot(data(1:100, 1), data(1:100, 2), '.');
%Plot second class of points
plot(data(101:200, 1), data(101:200, 2), '+');
hold off
%Display the best k value and the best loss
bestK
prevError