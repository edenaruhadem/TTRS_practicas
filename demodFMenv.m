
close all

[s fss]=audioread('radio3.wav');
s=reshape(s,1,length(s));
s=s/max(abs(s));
W = 4000; %Ancho de banda aproximado de la moduladora
M=80 %Factor de interpolación
m=interp(s,M);  %Se aumenta la frecuencia de muestreo, se comprime la señal en tiempo
%Se ensancha la señal por un factor de 80
% figure (3)
% powerspec(m,1/(M*fs));
VN=0; %varianza del ruido
fs=fss*M;  % Frecuencia de muestreo (Hz)
%% Variar kf
kf=75e3; % Constante de desviación de frecuencia (Hz/V)
%%
fc=100e3; % Frecuencia de portadora (Hz)

N=length(m); % Número de muestras

n=0:N-1;
Ts=1/fs;
t=n*Ts; % Instantes de muestreo


xfm=cos(2*pi*fc*t+2*pi*kf*cumsum(m)*Ts)+sqrt(VN)*randn(1,length(t)); % Señal modulada en FM 
figure(1)
powerspec(xfm,1/fs);

%%
xlim=limitador(xfm,0.8); %Limitador de la modulada a 0.8
%xlim = xfm;
figure(2)
powerspec(xlim,1/fs);
%% filtro paso banda
% S=800;
% q=firpm(S,[0 (fc-kf-5000) (fc-kf) (fc+kf) (fc+kf+5000) fs/2]/(fs/2),[0 0 1 1 0 0]);
% xlimf=filter(q,1,xlim); %filtrado paso banda de la salida del limitador
%%
%figure(6)
%powerspec(xlimf,1/fs);
dx=diff(xlim); %Salida del derivador
rdx=abs(dx);
figure(3)
powerspec(rdx,1/fs);

L=400;
h=firpm(L,[0 3600 4000 fs/2]/(fs/2),[1 1 0 0]); %h=firpm(L,[0 3600 4000 fs/2]/(fs/2),[1 1 0 0]);
xbb=filter(h,1,rdx); %filtrado paso bajo de la envolvente
xbb=xbb(L/2+1:end); %Eliminas el retardo   
xbb=xbb-mean(xbb); %Se elimina el valor de continua
vd=decimate(xbb,M);  %Se baja la frecuencia de muestreo, se ensancha la señal en tiempo
soundsc(vd,fs/M);
figure(4);
powerspec(vd,M/fs);

%% Bfm Carson
D = kf/W;
Bfm = 2*W*(D+1)


