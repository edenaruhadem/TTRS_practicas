% Modulacion FM tono 200 Hz
close all;
clear all;
clc;

fs=32000;  % Frecuencia de muestreo (Hz)
N=100000; % Número de muestras
kf= 800; % Constante de desviación de frecuencia (Hz/V)
kf_vect = 200:100:800;
xfm_vect = zeros(length(kf_vect),N);
fc=3000; % Frecuencia de portadora (Hz)
fm= 200; % Frecuencia moduladora (Hz);

n=0:N-1;
Ts=1/fs;
t=n*Ts; % Instantes de muestreo

m=sin(2*pi*fm*t); %Señal moduladora
%% Señal moduladora para el caso (c)
%m = sign(m);
xfm=cos(2*pi*fc*t+2*pi*kf*cumsum(m)*Ts); % Señal modulada en FM

for i = 1:length(kf_vect)
    xfm_vect(i,:) = cos(2*pi*fc*t+2*pi*kf_vect(i)*cumsum(m)*Ts);
end
%% Plots temporales
figure(1);
nn=1:500;
d(1)=subplot(211);
plot(t(nn),m(nn));
d(2)=subplot(212);
plot(t(nn),xfm(nn));
linkaxes(d, 'xy');

%% Densidades espectrales de potencia
figure(2);
powerspec(xfm,Ts);
%% plot de (a)
% figure(3);
% nn=1:500;
% q(1)=subplot(511);
% plot(t(nn),m(nn));
% q(2)=subplot(512);
% plot(t(nn),xfm_vect(1,nn));
% title('f = 200, 400, 600, 800')
% q(3)=subplot(513);
% plot(t(nn),xfm_vect(3,nn));
% q(4)=subplot(514);
% plot(t(nn),xfm_vect(5,nn));
% q(5)=subplot(515);
% plot(t(nn),xfm_vect(7,nn));
%linkaxes(q, 'xy');

%% Plot de (a) todo junto
% figure(4)
% nn=1:500;
% d(1)=subplot(211);
% plot(t(nn),m(nn));
% d(2)=subplot(212);
% for i = 1:length(kf_vect)
% plot(t(nn),xfm_vect(i,nn));
% hold on;
% end
% linkaxes(d, 'xy');

beta=kf*max(abs(m))/fm

sxp=1/4*(besselj(0,beta))^2 % Altura, es decir, valor de potencia de J(0)


