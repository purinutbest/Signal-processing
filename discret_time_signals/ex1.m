k=0:40;
x=10*sin(0.1*pi*k);
y=filter([2,-3,4],[1,-0.2,-0.8],x);
y2=zeros(1,length(k));
for i=0:length(k)-1
    y2=y2+(-5*(i==0)+1.67+5.33*(-0.5)^(i))*10*sin(0.1*pi*(k-i)).*(k-i>0);
end
stem(k,y2);
hold on;
h=(-5*(k==0)+1.67+5.33*(-0.5).^(k));
stem(k,y);
hold off;