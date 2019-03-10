close all;
clear all;
clc;
% dem_heterodino.m
%% Parametros
time=0.2; Ts=1/15000;                          
t=Ts:Ts:time;                                   
fc=2000; fol1 = 1500; fol2 = 500; fi1 = 2500; fi2 = 1600; fi3 = 990; c=cos(2*pi*fc*t);
cfi1 = cos(2*pi*fi1*t); Acf1 = 0;
cfi2 = cos(2*pi*fi2*t); Acf2 = 0;
cfi3 = cos(2*pi*fi3*t); Acf3 = 1;
fif1 = fc - fol1; fif2 = fc - fol2;
m=.5*sin(2*pi*70*t + pi/3)+.7*cos(2*pi*100*t - pi/6);         
%% Modulacion + interferencias
x = c.*m + Acf1*cfi1 + Acf2*cfi2 + Acf3*cfi3;
%% Filtro rechazo de imagen
fri=[0 1500 1900 2100 2500 1/(2*Ts)]*2*Ts; mask_fri=[0 0 1 1 0 0]; L_fri=80; 
hfri=firpm(L_fri,fri,mask_fri);
filter_xfri=2*filter(hfri,1,x);
%% Bajadas a fif
xif1 = filter_xfri.*cos(2*pi*fol1*t);
xif2 = filter_xfri.*cos(2*pi*fol2*t);
%% Filtros IF
fpb1=[0 300 400 600 700 1/(2*Ts)]*2*Ts; mask_fpb1=[0 0 1 1 0 0]; L_fpb1=200;     % paso banda orden 80 
hpb1=firpm(L_fpb1,fpb1,mask_fpb1);
filter_xif1=4*filter(hpb1,1,xif1);
fpb2=[0 1200 1400 1600 1800 1/(2*Ts)]*2*Ts; mask_fpb2=[0 0 1 1 0 0]; L_fpb2=120;     % paso banda orden 80 
hpb2=firpm(L_fpb2,fpb2,mask_fpb2);
filter_xif2=4*filter(hpb2,1,xif2);
%% Bajadas a banda base
c1 = cos(2*pi*fif1*t);                   
c2 = cos(2*pi*fif2*t); 
bb1 = filter_xif1.*c1;
bb2 = filter_xif2.*c2;
%% Filtros paso bajo
fpaso_bajo1=[0 100 150 1/(2*Ts)]*2*Ts ; mask_fpaso_bajo1=[1 1 0 0]; L_paso_bajo1=500;     
h_paso_bajo1=firpm(L_paso_bajo1,fpaso_bajo1,mask_fpaso_bajo1);                           
m_est_fif1=filter(h_paso_bajo1,1,bb1);                           
fpaso_bajo2=[0 100 200 1/(2*Ts)]*2*Ts; mask_fpaso_bajo2=[1 1 0 0]; L_paso_bajo2=500;      
h_paso_bajo2=firpm(L_paso_bajo2,fpaso_bajo2,mask_fpaso_bajo2);                           
m_est_fif2=filter(h_paso_bajo2,1,bb2); 

%% figuras dominio tiempo
% figure(1)
% subplot(4,1,1), plot(t,m)
% ylabel('amplitude'); title('(a) moduladora');
% axis([0,0.1,-1.5 1.5])
% subplot(4,1,2), plot(t,x,'c')
% ylabel('amplitude'); title('(b) modulada');
% axis([0,0.1, -1.5,1.5])
% subplot(4,1,3), plot(t,xif1,'m')
% ylabel('amplitude'); title('(c) bajada a Fif1');
% axis([0,0.1, -1.5,1.5])
% subplot(4,1,4), plot(t,xif2,'m')
% ylabel('amplitude'); title('(d) bajada a Fif2');
% axis([0,0.1, -1.5,1.5])
% xlabel('seconds');
% 
% figure(2)
% subplot(4,1,1), plot(t,filter_xif1)
% ylabel('amplitude'); title('(a) filtrado Fif1');
% axis([0,0.1,-1.5 1.5])
% subplot(4,1,2), plot(t,filter_xif2,'c')
% ylabel('amplitude'); title('(b) filtrado Fif2');
% axis([0,0.1, -1.5,1.5])
% subplot(4,1,3), plot(t,bb1,'m')
% ylabel('amplitude'); title('(c) bajada a banda base 1');
% axis([0,0.1, -1.5,1.5])
% subplot(4,1,4), plot(t,bb2,'m')
% ylabel('amplitude'); title('(d) bajada a banda base 2');
% axis([0,0.1, -1.5,1.5])
% xlabel('seconds');
% 
% figure(3)
% subplot(3,1,1), plot(t,m)
% ylabel('amplitude'); title('(a) moduladora');
% axis([0,0.1,-1.5 1.5])
% subplot(3,1,2), plot(t,m_est_fif1)
% ylabel('amplitude'); title('(a) estimación mensaje 1');
% axis([0,0.1,-1.5 1.5])
% subplot(3,1,3), plot(t,m_est_fif2)
% ylabel('amplitude'); title('(a) estimación mensaje 2');
% axis([0,0.1,-1.5 1.5])
% xlabel('seconds');

%% Figuras dominio frecuencia Fol = 1500
% figure(1)
% plotspec(m,Ts)
% ylabel('amplitude'); title('(a) moduladora');
% 
% figure(2)
% plotspec(x,Ts)
% ylabel('amplitude'); title('(a) modulada e interferencias');
% 
% figure(3)
% plotspec(xif1,Ts)
% ylabel('amplitude'); title('(a) bajada a Fif1');
% 
% figure(4)
% plotspec(filter_xif1,Ts)
% ylabel('amplitude'); title('(a) filtrado bajada a Fif1');
% 
% figure(5)
% plotspec(bb1,Ts)
% ylabel('amplitude'); title('(a) bajada a banda base 1');
% 
% figure(6)
% plotspec(m_est_fif1,Ts)
% ylabel('amplitude'); title('(a) mensaje recuperado Fif1');

%% Figuras dominio frecuencia Fol = 500

figure(7)
plotspec(m,Ts)
ylabel('amplitude'); title('(a) moduladora');

figure(8)
plotspec(x,Ts)
ylabel('amplitude'); title('(a) modulada e interferencias');

figure(9)
plotspec(xif2,Ts)
ylabel('amplitude'); title('(a) bajada a Fif2');

figure(10)
plotspec(filter_xif2,Ts)
ylabel('amplitude'); title('(a) filtrado bajada a Fif2');

figure(11)
plotspec(bb2,Ts)
ylabel('amplitude'); title('(a) bajada a banda base 2');

figure(12)
plotspec(m_est_fif2,Ts)
ylabel('amplitude'); title('(a) mensaje recuperado Fif2');

