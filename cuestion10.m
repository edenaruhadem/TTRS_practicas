N = 10000;
mean = 5;
var = 1;
bins = 10;
%% rand. 10000 muestras uniformamente distribuidas entre -1 y 1. Ver con hist
% x = 2*(rand(1,N) - 0.5);
%% randn. 10000 muestras distribucion normal media 0-5 varianza 3-1. Ver con hist: bins(10,20,50)
%x = mean + sqrt(var)*randn(1,10000);
%% rand. 10000 muestras uniformamente distribuidas con valores -1 y 1. Ver con hist
x = sign(2*(rand(1,N) - 0.5));
%%
hist(x,bins);
