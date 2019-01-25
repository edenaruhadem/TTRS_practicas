M = 50;
N = 500;
fs = 5000;
coef = 32;
rx = zeros(M,2*N-1);
salida = zeros(M,N+coef);
rx_salida = zeros(M, 2*(N+coef)-1);
b = firpm(coef,[0 0.24 0.26 0.74 0.76 1],[0 0 1 1 0 0]);
xt = pa3(M,N);

%% Proceso aleatorio N realizaciones N muestras de cada realización
% x_t = fliplr(xt);
% rx = conv(xt, x_t)/N;
% plot(rx)
% potencia = sum(abs(xt).^2)/N;
%% Promedio de las autocorrelaciones para M = 50, N = 500
% for k = 1:M    
%     rx(k,:) = conv(xt(k,:),fliplr(xt(k,:)))./N;
% end
% rx_mean = sum(rx)./M;
% plotacf(rx_mean,1/fs)
%% Cálculo de la autocorrelacion a la salida del proceso pasado pòr el filtro FIR
for j = 1:M
    salida(j,:) = conv(xt(j,:),b);
end
for k = 1:M    
    rx_salida(k,:) = conv(salida(k,:),fliplr(salida(k,:)))./N;
end
rx_mean_salida = sum(rx_salida)./M;
plotacf(rx_mean_salida,1/fs)
