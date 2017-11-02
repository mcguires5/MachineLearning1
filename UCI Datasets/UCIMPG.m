T = readtable('mpg.dat');
T = rmmissing(T);

raw = table2array(T(:,2:3));
tmp = table2array(T(:,4));
raw2 = table2array(T(:,5:8));
tmp = str2double(tmp);
raw = [raw tmp raw2];
Labels = table2array(T(:,1));

net = feedforwardnet(10);
net.trainParam.showWindow = 1;
net = train(net, raw',Labels');
perf = perform(net,raw',Labels')


