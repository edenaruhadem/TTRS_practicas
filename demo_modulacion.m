f1 = 50; 
f2 = 150;
fs = 2000;
t = 0:1/fs:0.5;
xt1 = cos(2*pi*f1*t);
xt2 = cos(2*pi*f2*t);
prod = xt1.*xt2;
plotspec(prod,1/fs)