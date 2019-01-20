function ap= lpc (x)

x=x-256;

sum=0;
i=1;
for k=1:256,
    sum=sum+x(k)*x(k);
end
h(1)=1;
for i=2:20,
    sum1=0;
    sum2=0;
    for k=1:256-i
        sum1=sum1+x(k)*x(k+i);
        sum2=sum2+x(k+i)*x(k+i);
    end
    h(i)=sum1/sqrt(sum*sum+sum2*sum2);
end

%levinson-durbin recursion

ap=0;
g=[];
aj(1)=1;
ej=h(1);
e=[ej];
for j=1:19,
    aj1=zeros(j+1,1);
    aj1(1)=1;
    hcj=h(j+1);
    for i=2:j,
        hcj=hcj + aj(i)*h(j-i+2);
    end
    hccj1=hcj/ej;
    g=[g ; hccj1];
    for i=2:j;
        aj1(i)=aj(i)+hccj1*(aj(j-i+2)');
    end
    aj1(j+1)=hccj1;
    ej1=ej*(1-abs(hccj1)^2);
    e=[e;ej1];
    aj=aj1;
    ap=aj1;
    ej=ej1;
end
b0=sqrt(ej1);
%  subplot(2,1,2);
% %plot(ap);
% stem(ap);
% title('plot of predictor coefficient for a signal');
% xlabel('coefficient number');
% ylabel('value of coefficient');
% 
%     
