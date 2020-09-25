x = load('water_sound.mat');
y = x.y; fs = x.fs;
N = length(y); T=1/fs;
r = nextpow2(N);
M = 2^r;
y = [y;zeros(M-N,1)]; N=M;
yft = fft(y);
f = [0:N/2,-N/2:-1]*fs/N;
indx = find(f>=0);
power_xf = yft.*conj(yft);
plot(f(indx),abs(power_xf(indx)));


