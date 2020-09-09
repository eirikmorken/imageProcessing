help;
helpdesk;
a = 1;
whos;
clear a;
v = []; 
v(3) = 2;
m = [];
m(3 ,4) = 3;
ones(2,3);
eye(5,6)
v1 = [4 : 2 : 10]
eye(10, 10)
m1 = ans
m1(1:10, 6:9)
m1(:, 6:9)
m2 = []
m2(: ,1:4)=m1(:,6:9)
m3 = rand(4,5)
m3 = randn(4,5)
m4 = round(m3) %round, fix, ceil, floor
m6 = round(randn(4,5))
m5 = cat(1, zeros(4,8),ones(4,8))
find(m3<0)
size(m3)
%operators (a+b)*v
A./B; %division element by element
%sum(m, dim) . same for sum, mean, prod, var, std, cumsum, cumprod
m9 = repmat(1:10, 5, 1)




%figure
x = [-pi:0.1:pi];
y = sin(x);
plot(x,y);
figure;
plot(x,y);
z = cos(x);
subplot(2, 1, 1);
plot(x, y);
subplot(2, 1, 2);
plot(x, z);
title('subplot');
%titile('inserttitel') + xlabel, ylabel osv

x = [-pi:0.1:pi];
y = sin(x);
z = cos(x);
plot(x,y, 'b');
hold;
plot(x,z, 'r');
title('superimposed');
