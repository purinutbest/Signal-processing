%hw 4.6
clear;
%load audio source
[sound,fs] = audioread('hbd.mp3');
N = length(sound);
L = 4000; M = ceil(N/L);
y = (sound(:,1)+sound(:,2))/2;
y = [y;zeros(M*L-N,1)];
t = zeros(L,M);
S = zeros(L,M);
%extracting subsignals and compute the spectrum
for ind = 1:2*M-1
    %determine the range of the subsignals
    k_sub = (ind-1)*L/2+1:(ind-1)*L/2+L; k_sub = k_sub';
    %extracting the subsignals and multoply with the Hanning window
    %function
    y_sub = y(k_sub).*(0.5-0.5*cos(2*pi*k_sub/L));
    t(:,ind) = (k_sub-1)/fs;
    %compute the FFT
    Y_sub = fft(y_sub);
    S(:,ind) = abs(Y_sub);
end
f = [0:L/2 -L/2+1:-1]'/(L/fs);
idx = find(f>=0 & f<=5200);
imagesc(f(idx),t(:),S(idx,:)',[0 50]);
xlabel('f(Hz)'); ylabel('t(s)');
set(gca,'ColorScale','log')
colorbar;
title('Spectrogram of the HBD song');