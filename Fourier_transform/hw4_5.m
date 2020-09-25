%hw 4.5
clear;
%create spectrum
fs = 1600; N = 1024;
k = 0:(N-1);
t = k/fs;
x = sin(400*pi*t).^2.*cos(300*pi*t).^2;
noise = normrnd(0,1/sqrt(2),[1,N]);
x = x+noise;
plot(t,x);
%calculate fourier transfrom
X = fft(x);
f = [0:N/2 -N/2+1:-1]/(N/fs);
indx = find(f>0);
%calculate power spectrum
S = X.*conj(X)/N;
%calculate average power
P_x = sum(S)/N;
P_v = sum(noise.*noise)/N;
disp(['Average power of x(k) = ',num2str(P_x)]);
disp(['Average power of v(k) = ',num2str(P_v)]);
%plot result
subplot(2,1,1);
plot(t,x);
xlabel('x(t)');
ylabel('t(s)');
title('Signal x(t)');
subplot(2,1,2); 
plot(f(indx),S(indx));
xlabel('f(Hz)');
ylabel('S(f)');
title('Power density spectrum');