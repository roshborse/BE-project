function x = mfcc2(a)
%clear all;

b=fft(a);
b1=(abs(b));
for i=1:256;
    b1(i)=b1(i)*b1(i);
end

c=log10(b1);
for i=1:128;
    f(i)=22050/256*i;
end
for i=1:128;
    c1(i)=c(i);
end

for i=1:128;
    m(i)=2595*log(1+f(i)/700);
end

% subplot(2,1,2);
% stem(m,c1);
% title('plot of log in mel scale');
% xlabel('frequency in mel scale');
% ylabel('amplitude');


for j=1:48;
    sum(j)=0;
    for i=1:88;
        
        if((m(i)>300+(j-1)*150)&&(m(i)<600+(j-1)*150))
            if (m(i)<450+(j-1)*150)
                g(i)=((m(i)-(300+150*(j-1)))*1/150);
            else
                g(i)=((600+150*(j-1)-m(i))*1/150);
            end
            
            sum(j)=sum(j)+c1(i)*g(i);
        end
    end
end

d=ifft(sum);
d=abs (d);
figure;

for i=1:20;
    x(i)=d(i);
end

stem(x);
title('plot of mfcc for voiced speech');
xlabel('frequency in mel scale');
ylabel('amplitude');

    

