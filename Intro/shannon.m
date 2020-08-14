t_stop = 0.1;

f = 100;
t = 0:1e-5:t_stop;
y = signal(2*pi*f*t);

fs = 5*f;
ts = 0:1/fs:t_stop;
y_s = signal(2*pi*f*ts);

y_a = zeros(1,length(t));
for i = 1:length(y_s)
    y_a = y_a+y_s(i)*sinc(pi*fs*(t-(i-1)/fs));
end

plot(t,y);
hold on;
plot(ts,y_s,'or');
plot(t,y_a,'r');
hold off;

function y = signal(x)
    y = sin(0.5*x).*cos(1.2*x).*x.^1.2;
end

function y = sinc(x)
    if x == 0
        y = 1;
    else
        y = sin(x)./x;
    end
end
%##########Finish##########
