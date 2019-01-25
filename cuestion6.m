A = 1; f = 20; fs = 1000; t = 0:1/fs:2;
x = sign(A*cos(2*pi*f*t));
plotspec(x,1/fs)
