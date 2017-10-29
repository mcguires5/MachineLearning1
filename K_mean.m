
set1 = mvnrnd([0 1],[1,1],1000);
set2 = mvnrnd([3 4],[1,1],1000);

set = [set1; set2];

xCentroid1 = rand()*3;
yCentroid1 = rand()*4;

xCentroid2 = rand()*3;
yCentroid2 = rand()*4;
figure
hold on;
plot(set1(:,1),set1(:,2),'.r');
plot(set2(:,1),set2(:,2),'+b');
plot(xCentroid1,yCentroid1,'om', 'markersize',50);
plot(xCentroid2,yCentroid2, 'og', 'markersize',50);
hold off;
delDist = 1;

while(delDist > 0.05)
    Class1Data = zeros(2000,2);
    Class2Data = zeros(2000,2);
    NewCentroid1 = zeros(3,1);
    NewCentroid2 = zeros(3,1);
    %Distances from set1 or 2
    for i = 1:2000
        distToOne = sqrt((set(i,1) - xCentroid1)^2 + (set(i,2) - yCentroid1)^2);
        distToTwo = sqrt((set(i,1) - xCentroid2)^2 + (set(i,2) - yCentroid2)^2);
        if(distToOne < distToTwo)
            NewCentroid1(1) = NewCentroid1(1) + set(i,1);
            NewCentroid1(2) = NewCentroid1(2) + set(i,2);
            Class1Data(i,1) = set(i,1);
            Class1Data(i,2) = set(i,2);
            %To count number of points in class
            NewCentroid1(3) = NewCentroid1(3) + 1;
        else
            NewCentroid2(1) = NewCentroid2(1) + set(i,1);
            NewCentroid2(2) = NewCentroid2(2) + set(i,2);
            Class2Data(i,1) = set(i,1);
            Class2Data(i,2) = set(i,2);
            %To count number of points in class
            NewCentroid2(3) = NewCentroid2(3) + 1;
        end
    end
    NewCentroid1(1) = NewCentroid1(1)/NewCentroid1(3);
    NewCentroid1(2) = NewCentroid1(2)/NewCentroid1(3);
    
    NewCentroid2(1) = NewCentroid2(1)/NewCentroid2(3);
    NewCentroid2(2) = NewCentroid2(2)/NewCentroid2(3);
    figure
    hold on;
    plot(Class1Data(:,1), Class1Data(:,2), '.r');
    plot(Class2Data(:,1), Class2Data(:,2), '.b');
    plot(NewCentroid1(1),NewCentroid1(2),'om', 'markersize',50);
    plot(NewCentroid2(1),NewCentroid2(2), 'og', 'markersize',50);
    hold off;
    delDist = sqrt((xCentroid1 - NewCentroid1(1))^2 + (yCentroid1 - NewCentroid1(2))^2);
    xCentroid1 = NewCentroid1(1);
    yCentroid1 = NewCentroid1(2);
    xCentroid2 = NewCentroid2(1);
    yCentroid2 = NewCentroid2(2);
end


