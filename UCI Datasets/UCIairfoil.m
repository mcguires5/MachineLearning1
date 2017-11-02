T = readtable('airfoil.dat');
T = rmmissing(T);

raw = table2array(T(:,1:5));
Labels = table2array(T(:,6));

net = feedforwardnet(10);
net.trainParam.showWindow = 1;
net = train(net, raw',Labels');
perf = perform(net,raw',Labels')