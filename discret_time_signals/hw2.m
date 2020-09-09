%3.1
M = 512;
k_M = 1:M;
x = input(k_M);
subplot(5,1,1)
plot(k_M,x);
title('Transmitted signal');
xlabel('M-point');
ylabel('x(k)');
%3.2
L = 2048;
k_L = 1:L;
noise = rand(1,L)/10-0.05;
subplot(5,1,2)
plot(k_L,noise);
title('Random noise')
xlabel('L-point');
ylabel('\eta(k)');
%3.3
y = output(k_L,noise);
subplot(5,1,3)
plot(k_L,y);
title('Received signal')
xlabel('L-point');
ylabel('y(k)');
%3.4
ryx = linear_corr(x,y);
subplot(5,1,4)
plot(k_L,ryx);
title('Linear cross-correlation')
xlabel('L-point');
ylabel('r_{yx}');
%3.5
ryx_norm = norm_licorr(x,y);
subplot(5,1,5)
plot(k_L,ryx_norm);
title('Normalized linear cross-correlation')
xlabel('L-point');
ylabel('\rho_{yx}');

function f = cal_f(k)
    f_s = 1E6;
    M = 512;
    f = k*f_s/2/(M-1);
end

function y = output(k,noise)
    alpha = 0.01;
    d = 500;
    y = alpha*input(k-d)+noise;
end

function x = input(k)
    f_s = 1E6;
    x = sin(2*pi*cal_f(k).*k/f_s).*(k>=0).*(k<=512);
end

function z = linear_corr(x,y)
    L = length(y);
    M = length(x);
    D = zeros(L,L);
    for i=1:L
        for j=1:M
            k = i+j-1;
            if k<=L
                D(i,k) = x(j);
            end
        end
    end
    D = D/L;
    z = D*y';
end

function z_norm = norm_licorr(x,y)
    L = length(y);
    M = length(x);
    rxx = linear_corr(x,x);
    ryy = linear_corr(y,y);
    ryx = linear_corr(x,y);
    z_norm = ryx/sqrt((M/L)*rxx(1)*ryy(1));
end