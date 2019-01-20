%program to find PLP coeffcients for 256 samples of voiced speech

function x= plp(a)
% %clear all;
% %fp=fopen('C:\Documents and Settings\DIGIT\Desktop\speaker identification\database\u1.wav');
% fseek(fp,224000,-1);
% a=fread(fp,256);
% %plot 256 points of voiced speech
% plot(a);title('plot of voiced part of a signal');
% xlabel('sample no.');ylabel('amplitude');
% %find 256 point FFT
b=fft(a);
b1=(abs(b));
for i=1:256,
    b1(i)=b1(i)*b1(i); %calculation of squared power
end
 
 
%calculate frequency in Hz for every FFT bin
for i=1:128,
    f(i)=22100/256*i;
end
for i=1:128,
    c1(i)=b1(i);
end
 %calculate bark scale frequency for each frequency in HZ corresponding to FFT bin
 for i=1:128,
     bark(i)=6*log(2*pi*f(i)/1200*pi+sqrt((2*pi*f(i)/1200*pi)^2+1));
       
 end
 %plot spectrum in bark scale foe each FFT bin. And find cube root of power spectrum bin and plot it on bark scale.
 
for i=1:128,
    c11(i)=nthroot(c1(i),3);
end

 %subplot(2,1,2);stem(bark,c11);title('plot of cube root of power spectrum in bark scale for voiced speech');
%xlabel('Frequency in bark scale');ylabel('Amplitude in dB');
%divide bark scale in equally spaced triangular filter each of width equal to 5 bark with 50% overlap. first filter is from 10 bark to 15 bark. Next is from 12.5 bark to 17.5 bark and so on. integrate cube root of power spectrum bins over the filter 
figure;
for j=1:28,
    sum(j)=0;
    for i=1:58,
       
        if ((bark(i)>10+(j-1)*2.5)&&(bark(i)<15+(j-1)*2.5))
            if (bark(i)<12.5+(j-1)*2.5)
                g(i)=((bark(i)-(2.5+2.5*(j-1)))*1/5);
                 else
                g(i)=((15+2.5*(j-1)-bark(i))*1/5);
            end
             
       
         sum(j)=sum(j)+c11(i)*g(i);
        
        end
     
   end
end 
%find ifft of the resulting integrated values considering it as a signal.
d=ifft(sum);
d1=real(d);
 
 
 
for i=1:20,
    x(i)=d1(i);
end
 %plot first 14 MFCC coefficients by cepstral truncation.
stem(x);title('plot of PLP coefficients for voiced speech');
xlabel('Frequency in Mel scale');ylabel('Amplitude in dB');

  