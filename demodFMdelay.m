
close all;

fs=32000;  % Frecuencia de muestreo (Hz)
kf= 250; % Constante de desviación de frecuencia (Hz/V)
fc=3000; % Frecuencia de portadora (Hz)
fo=fc;
fm= 200; % Frecuencia moduladora (Hz);


N=100000; % Número de muestras

n=0:N-1;
Ts=1/fs;
t=n*Ts; % Instantes de muestreo
%% tono
m=sin(2*pi*fm*t); %Señal moduladora
%% modulacion
xfm=cos(2*pi*fc*t+2*pi*kf*cumsum(m)*Ts); % Señal modulada en FM
beta=kf*max(abs(m))/fm
Bfm = 2*fm*(beta+1)
%% demodulacion
xfm_n = xfm.*exp(-1i*2*pi*fo*n*1/fs);
h = firpm(400,[0 3600 4000 fs/2]*2/fs,[1 1 0 0]);
xbb = filter(h,1,xfm_n);
xbb = xbb(400/2+1:end);
xbb_z = zeros(1,length(xbb));
xbb_z(2:end) = xbb(1:end-1);
w = xbb.*conj(xbb_z);
y = 20*phase(w);






figure(1);
nn=1:500;
subplot(311),plot(t(nn),m(nn));
subplot(312),plot(t(nn),xfm(nn));
subplot(313),plot(t(nn),y(nn));

figure(2);
powerspec(xfm,Ts);

figure(3);
powerspec(xfm_n,Ts);

figure(4);
powerspec(xbb,Ts);

figure(5);
powerspec(y,Ts);

figure(6);
powerspec(m,Ts);

beta=kf*max(abs(m))/fm;

sxp=1/4*(besselj(0,beta))^2


