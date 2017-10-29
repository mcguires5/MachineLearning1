%%UCI TEMPLATE
irisraw = csvread('iris.txt');
irisdata = irisraw(:,1:4)';
irisLabels = zeros(3,500); %%Equal to 1 column

%%net.performParam.regularization = .1; lamda
