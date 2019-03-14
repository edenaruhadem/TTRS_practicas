
close all

[s fss]=audioread('radio3.wav');
s=reshape(s,1,length(s));
s=s/max(abs(s));

M=80 %Factor de interpolación
m=interp(s,M);  

VN=0; %varianza del ruido

fs=fss*M;  % Frecuencia de muestreo (Hz)
kf=50e3; % Constante de desviación de frecuencia (Hz/V)
fc=100e3; % Frecuencia de portadora (Hz)

N=length(m); % Número de muestras

n=0:N-1;
Ts=1/fs;
t=n*Ts; % Instantes de muestreo


xfm=cos(2*pi*fc*t+2*pi*kf*cumsum(m)*Ts)+sqrt(VN)*randn(1,length(t)); % Señal modulada en FM
 
figure(1)
powerspec(xfm,1/fs);

%%

xlim=limitador(xfm,0.9);

dx=diff(xlim);
rdx=abs(dx);

L=400;
h=firpm(L,[0 3600 4000 fs/2]/(fs/2),[1 1 0 0]);
xbb=filter(h,1,rdx);
xbb=xbb(L/2+1:end);   
xbb=xbb-mean(xbb);


vd=decimate(xbb,M);

sound(vd,fs/M);

figure(2);
powerspec(vd,M/fs);




