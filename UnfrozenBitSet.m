clear;
clc;
SNR_dB=4;  %dB change with demonded SNR
SNR_dec=10^(SNR_dB/10);  %decimal form
sigma2=1/SNR_dec;    %The variance of Gauss noise
sigma=sqrt(sigma2);
%sigma=0.97865;
m=2/(sigma2);
n=11;      % code length coefficient 
N=2^n;

R=1;      %change with demanded rate
K=round(N*R);  %The number of information bits
U=zeros(1,N);
Mean=zeros(n+1,N);
Mean(1,1:N)=m;
 for k=2:n+1
    for i=1:2:2^(k-1)
        for j=1:N/(2^(k-1))
            Mean(k,(i-1)*N/(2^(k-1))+j)=Phi(Mean(k-1,(i-1)/2*N/(2^(k-2))+2*j-1),Mean(k-1,(i-1)/2*N/(2^(k-2))+2*j));
            Mean(k,i*N/(2^(k-1))+j)=Mean(k-1,(i-1)/2*N/(2^(k-2))+2*j-1)+Mean(k-1,(i-1)/2*N/(2^(k-2))+2*j);
         end
    end
 end

Mean_information_sequence=Mean(n+1,:);
Xk=1:N;
Bk=Mean_information_sequence;
for i=1:N
    for j=N:-1:i+1
        if Bk(j-1)<Bk(j)
            tmp=Bk(j);
            Bk(j)=Bk(j-1);
            Bk(j-1)=tmp;
            itmp=Xk(j);
            Xk(j)=Xk(j-1);
            Xk(j-1)=itmp;
        else
            if Bk(j-1)==Bk(j) && Xk(j-1)<Xk(j)
                xxx=1;
                itmp=Xk(j);
                Xk(j)=Xk(j-1);
                Xk(j-1)=itmp;
            end
        end
    end
end
K_kflag=Xk(1:K);
K_kflag=K_kflag-1;
% [Bj,Xj]=sort(Mean_information_sequence);
% Mean_information_bit=Bj(N:-1:N-K+1);
% K_jflag=Xj(N:-1:N-K+1);
% temp_Mean_information_bit=Mean_information_bit;
% 
% Pe_information_sequence=qfunc(sqrt(Mean(n+1,:)/2));
% 
% dlmwrite('pe.txt',Pe_information_sequence,'delimiter',' ','newline','pc');
% [Bi,Xi]=sort(Pe_information_sequence);
% K_iflag=Xi(1:K);
dlmwrite('4.txt',K_kflag,'delimiter',' ','newline','pc');
%Phi(-m,-m);
