fmt = transpose(fm); % fm almacenada en el workspace
FM = fmt(:);
fs = 228e3;
flmr = 38000;
Ts = 1/fs;
N = length(FM);
n=0:N-1;
t=n*Ts;

%% Demodulacion
% xfm_n = xfm.*exp(-1i*2*pi*fo*n*1/fs);
% h = firpm(400,[0 3600 4000 fs/2]*2/fs,[1 1 0 0]);
% xbb = filter(h,1,xfm_n);
% xbb = xbb(400/2+1:end);

%xbb_z = zeros(1,length(FM));
%xbb_z(2:end) = FM(1:end-1);
xbb_z = [0;FM(1:end-1)];
w = FM.*conj(xbb_z);
y = 20*phase(w);
%% filtro paso bajo para L+R
%  h = firpm(400,[0 15000 17000 fs/2]*2/fs,[1 1 0 0]);
%  lpr = filter(h,1,y);
%  lpr = lpr(400/2+1:end);
 lpr = decimate(double(y),8);
%% filtro paso banda para L+R
 l = firpm(400,[0 23000 25000 51000 53000 fs/2]*2/fs,[0 0 1 1 0 0]);
 lmr = filter(l,1,y);
 lmr = lmr(400/2+1:end);
%% Bajada a BB de L-R
c = cos(2*pi*flmr*t);
lmrbb = lmr.*c';
%% Filtro paso bajo de L-R en bb

 lmrbbf = filter(h,1,lmrbb);
 lmrbbf = lmrbbf(400/2+1:end);

%% figures
figure(1)
powerspec(FM,1/fs);
title("Espectro señal modulada banda base");
figure(2)
powerspec(y,1/fs);
title("Espectro señal demodulada");
figure(3)
powerspec(lpr,1/fs);
title("Espectro L+R en bb");
figure(4)
powerspec(lmrbbf,1/fs);
title("Espectro L-R en bb");