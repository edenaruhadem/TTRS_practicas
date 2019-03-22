
close all;

[s fss]=audioread('radio3.wav');
s=reshape(s,1,length(s));
s=s/max(abs(s));
%sound(s,fss);
m=interp(s,80);  

fs=fss*80;  % Frecuencia de muestreo (Hz)
kf=25e3; % Constante de desviaci�n de frecuencia (Hz/V)
fc=100e3; % Frecuencia de portadora (Hz)

N=length(m); % N�mero de muestras
nfft=N; % n�mero de puntos de la FFT
df=fs/nfft; % Resoluci�n espectral en frecuencia

n=0:N-1;
Ts=1/fs;
t=n*Ts; % Instantes de muestreo


xfm=cos(2*pi*fc*t+2*pi*kf*cumsum(m)*Ts); % Se�al modulada en FM

W = 4000;
figure(1)
powerspec(xfm,1/fs);
figure(2)
powerspec(m,1/fs);
D = kf*max(m)/W;
bfm = 2*(D+1)*W
