T = 1;
ampli_pulse = T;
fs = 4000;
t = -5:1/fs:5;
tt = -10:1/fs:10;
x = sinc(t/T);
y = rectpuls(t,ampli_pulse);
convolucion = conv(x,y);
%plot (t,x)
%plot(t,y)
plot(tt,convolucion)
grid on