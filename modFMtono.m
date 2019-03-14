
close all;

fs=32000;  % Frecuencia de muestreo (Hz)
kf= 250; % Constante de desviación de frecuencia (Hz/V)
fc=3000; % Frecuencia de portadora (Hz)
fm= 200; % Frecuencia moduladora (Hz);

N=100000; % Número de muestras

n=0:N-1;
Ts=1/fs;
t=n*Ts; % Instantes de muestreo

m=sin(2*pi*fm*t); %Señal moduladora
xfm=cos(2*pi*fc*t+2*pi*kf*cumsum(m)*Ts); % Señal modulada en FM

figure(1);
nn=1:500;
subplot(211),plot(t(nn),m(nn));
subplot(212),plot(t(nn),xfm(nn));

figure(2);
powerspec(xfm,Ts);


beta=kf*max(abs(m))/fm;

sxp=1/4*(besselj(0,beta))^2


