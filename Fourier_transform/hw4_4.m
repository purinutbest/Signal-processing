%hw 4.4
clear;
%create analog pulse
T0 = 1; T_pulse = T0/5; F0 = 1/T0;
t_f = 5*T0;
t = 0:1e-4:t_f;
x = 10*(mod(t,T0)<=T_pulse).*(t>=0);
%create digital pulse
H = 16; N_T = 2*H;
fs = F0*(N_T);
t_i = 0:1/fs:t_f;
N =length(t_i);
x_i = 10*(mod(t_i,T0)<=T_pulse).*(t_i>=0);
%calculate DFT
W_N = exp(-2*pi*1i/N_T);
W = zeros(N,N);
for indx_i = 1:N
    for indx_k = 1:N
        W(indx_i,indx_k)= W_N^((indx_i-1)*(indx_k-1));
    end
end
X = W*x_i';

%Magnetude spectrum (M)
M = abs(X);
d = 2*M(1:N_T/2)/N;
subplot(3,1,2); stem(d); xlabel('i'); ylabel('d_i');
%phase spectrum (phi)
phi = angle(X(1:N_T/2));
subplot(3,1,3); stem(phi/pi); xlabel('i'); ylabel('\phi_i (unit of \pi)');
%reconstruct signal
x_r = 0.5*d(1)*ones(1,length(t));
for indx_i = 2:N_T/2
    x_r = x_r + d(indx_i)*cos(2*pi*(indx_i-1)*F0*t+phi(indx_i));
end
%plot signal
subplot(3,1,1);
hold on;
plot(t,x);
stem(t_i,x_i);
plot(t,x_r);
hold off;
title('Pulse signal and the fourier coefficients')
legend('x_a','x_i','reconstrcted x_a');
ylabel('x(t)');
xlabel('time');
