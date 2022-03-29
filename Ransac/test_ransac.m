

% script to demonstrate the rule of Ransac in regression

n = 1000;

% 
% 
% 
% data1 =  points1(1,pair(1,:));
% data2 = points2(1,pair(2,:));


data1 =  randn(1,1000);
data2 = randn(1,1000);


% maxA = max(points1(1,pair(1,:)));
% maxB = max(points2(1,pair(2,:)));

% 
% data1 = data1./maxA;
% 
% data2 = data2./maxB;


[A,B,~,q,m] = RansacPoints([data1' data2']',0.01,1000);










x = min(data1):max(data1);
y = m*x + q;



[m2,q2] = LS(data1,data2);

x2 = min(data1):max(data1);
y2 = m2*x2 +q2;

[m,q] = LS(A(:,1),A(:,2));

x3 = min(data1):max(data1);
y3 = m*x3 +q;


plot(x,y,'Color','green')
hold on
plot(x2,y2,'Color','red')
hold on



figure

scatter(A(:,1),A(:,2),'*g');
hold on
if(size(B) > 0)
    scatter(B(:,1),B(:,2),'*b');
end


legend('Ransac','LS','Inliers','Outliers')