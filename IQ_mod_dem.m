clc;
clear all;
close all;
% IQ_moddem.m: IQ mod_dem
time=0.2; Ts=1/10000;                           % sampling interval and time
t=Ts:Ts:time;                                   % define a "time" vector 
fc=1000; c=cos(2*pi*fc*t);                      % define carrier at freq fc
s=sin(2*pi*fc*t);
m1=.7*sin(2*pi*20*t)+.3*cos(2*pi*70*t);          % create "message"
m2=.7*sin(2*pi*10*t)+.3*cos(2*pi*50*t);
x = c.*m1 - s.*m2;
fd = 0; phi = 0;                                % freq & phase offsets
c2 = cos(2*pi*(fc+fd)*t+phi);                   % create cosine for demodulation
s2 = sin(2*pi*(fc+fd)*t+phi);
b1 = x.*c2;
b2 = x.*s2;% demodulate received signal
fbe=[0 0.05 0.25 1]; damps=[1 1 0 0]; L=20;     % low pass filter design 
h=firpm(L,fbe,damps);                           % impulse response of LPF
m1est=2*filter(h,1,b1);                           % LPF the demodulated signal
m2est=2*filter(h,1,b2)*-1;
% generate the figure
figure(1)
subplot(7,1,1), plot(t,m1)
ylabel('amplitude'); title('(a) message signal 1');
axis([0,0.1,-1.5 1.5])
subplot(7,1,2), plot(t,m2)
ylabel('amplitude'); title('(a) message signal 2');
axis([0,0.1,-1.5 1.5])
subplot(7,1,3), plot(t,x,'c')
ylabel('amplitude'); title('(b) modulated signal');
axis([0,0.1, -1.5,1.5])
subplot(7,1,4), plot(t,b1,'m')
ylabel('amplitude'); title('(c) demodulated signal 1');
axis([0,0.1, -1.5,1.5])
subplot(7,1,5), plot(t,b2,'m')
ylabel('amplitude'); title('(c) demodulated signal 2');
axis([0,0.1, -1.5,1.5])
subplot(7,1,6), plot(t,m1est,'r')
ylabel('amplitude'); title('(d) recovered message 1');
axis([0,0.1, -1.5, 1.5])
subplot(7,1,7), plot(t,m2est,'r')
ylabel('amplitude'); title('(d) recovered message 2');
axis([0,0.1, -1.5, 1.5])
xlabel('seconds');

% this shows things a bit more clearly (but won't print well)
% figure(2)
% plot(t,x,'c')
%  hold on
%  plot(t,m)
%  plot(t,mest,'r')
%  ylabel('amplitude')
%  xlabel('seconds')
%  title('cyan=modulated signal, blue=message, red=recovered message')
% hold off



figure(3)
plotspec(m1,Ts)
ylabel('amplitude'); title('(a) message signal 1');

figure(4)
plotspec(m2,Ts)
ylabel('amplitude'); title('(a) message signal 2');

figure(5)
plotspec(x,Ts)
ylabel('amplitude'); title('(a) modulated signal');

figure(6)
plotspec(b1,Ts)
ylabel('amplitude'); title('(a) demodulated signal 1');

figure(7)
plotspec(b2,Ts)
ylabel('amplitude'); title('(a) demodulated signal 2');

figure(8)
plotspec(m1est,Ts)
ylabel('amplitude'); title('(a) recovered signal 1');

figure(9)
plotspec(m2est,Ts)
ylabel('amplitude'); title('(a) recovered signal 2');
