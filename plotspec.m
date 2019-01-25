% plotspec(x,Ts) plots the spectrum of the signal x% Ts = time (in seconds) between adjacent samples in xfunction plotspec(x,Ts)N = length(x);                                    % length of the signal xt = Ts*(0:N-1);                                   % define a time vector ssf = (-N/2:N/2-1)/(Ts*N);                        % frequency vectorfx  = fft(x(1:N));                                % do DFT/FFTfxs = fftshift(fx);                               % shift it for plottingsubplot(2,1,1), plot(t,x)                         % plot the waveformxlabel('time (seconds)'); ylabel('amplitude')     % label the axessubplot(2,1,2), plot(ssf,abs(fxs)/N)                % plot magnitude spectrumxlabel('frequency (Hz)'); ylabel('magnitude')     % label the axes%verify parseval equalize power using%sum(abs(fxs).^2)/N%sum(abs(x).^2)% use axis([0,2,-1.1,1.1]) for specsquare.eps