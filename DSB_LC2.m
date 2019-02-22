% DSB_LC.m: large carrier AM demodulated with "envelope detection"
time=0.4; Ts=1/10000;                           % sampling interval and time
t=Ts:Ts:time;                                   % define a "time" vector
fase = 0;
g = 0;
fc=1000; c=cos(2*pi*(fc+g)*t + fase);                      % define carrier at freq fc
m=.7*sin(2*pi*20*t)+.3*cos(2*pi*70*t);          % create "message" > -1
a = 0.6; %Suponemos que Ap = 1
x = a*c.*m + c;                               % modulate with large carrier
fbe=[0 .05 .18 1]; damps=[1 1 0 0]; L=35;       % low pass filter design 
h=firpm(L,fbe,damps);                           % impulse response of LPF
x_rect = (1/2)*(x+abs(x));
envv=pi*filter(h,1,x_rect);                 % find envelope

% generate the figure
figure(1)
subplot(4,1,1), plot(t,m)
ylabel('amplitude'); title('(a) message signal');
axis([0,0.1, -1.5,1.5])
subplot(4,1,2), plot(t,c,'k')
ylabel('amplitude'); title('(b) carrier');
axis([0,0.1, -1.5,1.5])
subplot(4,1,3), plot(t,x,'c')
ylabel('amplitude'); title('(c) modulated signal');
axis([0,0.1, -2,2])
subplot(4,1,4), plot(t,envv,'r')
ylabel('amplitude'); title('(d) output of envelope detector');
axis([0,0.1, -2,2])
xlabel('seconds');

% this shows things a bit more clearly (but won't print well)
figure(2)
plot(t,x,'c')
hold on
plot(t,m)
plot(t,envv,'r')
ylabel('amplitude')
xlabel('seconds')
title('cyan=modulated signal, blue=message, red=envelope')
hold off

figure(3)
plotspec(m,Ts)
ylabel('amplitude'); title('(a) Spectrum of message signal');

figure(4)
plotspec(c,Ts)
ylabel('amplitude'); title('(a) Spectrum of carrier');

figure(5)
plotspec(x,Ts)
ylabel('amplitude'); title('(a) Spectrum of modulated signal');

figure(6)
plotspec(envv,Ts)
ylabel('amplitude'); title('(a) Spectrum of envelope');

figure(7)
freqz(h)

figure(8)
plotspec(x_rect, Ts)
ylabel('amplitude'); title('(a) Spectrum of rectified x(t)');