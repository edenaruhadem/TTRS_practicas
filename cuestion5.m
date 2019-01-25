fs = 10000; f = 20; A = 1; t = 0:1/fs:2;
x = A*sin(2*pi*f*t);
plotspec(x,1/fs)