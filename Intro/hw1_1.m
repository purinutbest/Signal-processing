t_start = 0;
t_stop = 1;
f=1/1e-5;
t = t_start:1/f:t_stop;
y = 5*sin(100*pi*t)-2*cos(40*pi*t);

fs = 90;
ts = t_start:1/fs:t_stop;
y_s = 5*sin(100*pi*ts)-2*cos(40*pi*ts);

y_a = zeros(1,length(t));
for i = 1:length(y_s)
    y_a = y_a+y_s(i)*sinc(pi*fs*(t-(i-1)/fs));
end

plot(t,y);
hold on;
plot(ts,y_s,'or');
plot(t,y_a,'r');
hold off;
legend('Original signal','Collected data','Reconstructed signal');
xlabel('t (s)');
ylabel('x_a(t)');
title(['Shannon interpolation of the signal with sampling ',num2str(fs),' rate Hz']);
% y_f = fft(y_s)/fs*2;
% F = fs*(0:length(ts)/2)/length(ts);
% semilogx(F,abs(y_f(1:floor(length(y_f)/2+1))));

function y = sinc(x)
    if x == 0
        y = 1;
    else
        y = sin(x)./x;
    end
end
%##########Finish##########