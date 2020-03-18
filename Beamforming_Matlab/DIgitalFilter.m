%% Digital Filter
x = randn(10000,1);
x1 = x(1:5000);
x2 = x(5001:end);

b = [2,3];
a = [1,0.2];
[y1,zf] = filter(b,a,x1);

[h,w] = freqz(b,a,50)

plot(w/pi,20*log10(abs(h)))
ax = gca;
ax.YLim = [-100 20];
ax.XTick = 0:.5:2;
xlabel('Normalized Frequency (\times\pi rad/sample)')
ylabel('Magnitude (dB)')

%% Fourier OFDM
Fs=1e6;  %%% Sampling rate
Order=16 %%% QAM order
scale=1/3 %%%
fshift=15e3:15e3:15e3*10; %%% OFDM fftshift
t=0:1/Fs:10e-6; %%% Time samples
Nfft=1000;
Deltaf=Fs/(Nfft)
Nbins=10 %%% 128 bins = 1.5MHz BW  256 bins = 3 MHz BW  512 bins = 5 MHz BW
%%% modulation
f=Fs/2*linspace(-1,1-1/Nfft,Nfft)
hMod = modem.qammod('M',Order,'PHASEOFFSET', 0, 'SYMBOLORDER', 'BINARY', ...
                                                    'INPUTTYPE', 'BIT');

bstream=randi([0 1],1,Nbins*log2(Order)); %%% Bitstream
Bmod=s2p(bstream,log2(Order));  
sig=modulate(hMod,Bmod)*scale;
x=0;
figure,
for ii=1:10
% x=x+sig(ii)*sinc(10*pi*(f-fshift(ii))/max(f));
x=x+sinc(10*pi*(f-fshift(ii))/max(f));
plot((sinc(10*pi*(f-fshift(ii))/max(f)))), hold on
end
x=fftshift(x); %%% FFT transform format single sideband represantation - Frequency Domain
x(end:-1:round(Nfft/2)+2)=conj(x(2:floor(Nfft/2))); %%% Force Hermitian symmetry
figure, %%% Plot signal
plot(f,db((x)))

xofdm=ifft((x));  %%%% IFFT conversion to time domain
yofdm=xofdm+0.8*xofdm.*abs(xofdm).^2; %% Nonlinear gain

XF=fftshift(fft(xofdm,Nfft).^2/Nfft);
YF=fftshift(fft(yofdm,Nfft).^2/Nfft);
figure,
plot(f/1e6,db(XF)),hold on
plot(f/1e6,db(YF)),

% s=sinc(10*pi*(f-fshift(1))/max(f))
% s2=sinc(10*pi*(f-fshift(2))/max(f))

 plot(s), hold on
 plot(s2)



