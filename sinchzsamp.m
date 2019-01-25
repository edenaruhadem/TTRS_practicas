To=5e-3; time=0.05; timeminus = -0.05; Tu=1/10000; t=timeminus:Tu:time;    % freq and time vectors 
w=sinc(t/To);                            % create sine wave w(t)
M=50;                                           % take 1 in M samples
wk=w(1:M:end);                                  % the "sampled" sequence
ws=zeros(size(w)); ws(1:M:end)=wk;              % sampled waveform ws(t)
subplot(211), plot(t,w)                         % plot the waveform
hold on, plot(t,ws,'r'), hold off               % plot "sampled" wave
xlabel('segundos'), ylabel('amplitud')          % label the axes
subplot(212), plot(t(1:M:end),wk,'ro')          % plot samples
xlabel('segundos'), ylabel('amplitud')