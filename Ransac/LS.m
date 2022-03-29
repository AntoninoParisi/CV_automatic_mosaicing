function [ m q ] = LS(x,y)


sqX = x.^2;
xy = x.*y;

N = length(x);

m = N*sum(xy) - sum(x)*sum(y);
m = m/(N*sum(sqX)- sum(x)^2);

q = (sum(y) - m*sum(x))/N;


end