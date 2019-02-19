T = 1;
ampli_pulse = T;
ampli_tripulse = T;
fs = 4000;
t = -5:1/fs:5;
tt = -10:1/fs:10;
x = sinc(t/T);
y = rectpuls(t,ampli_pulse);
z = tripuls(t,ampli_tripulse);
convolucion = conv(x,y);
%plot (t,x)
%plot(t,y)
plot(t,z)
%plot(tt,convolucion)
grid on