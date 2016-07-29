function result=Phi(a,b)
alpha=-0.4527;
beta=0.0218;
gama=0.86;
epsilon=1E-10;
if a==0
    ia=1;
end
if a>0 && a<10
    largenum=alpha*a^gama+beta;
    if largenum>700
        largenum=700;
    end
    %ia=exp(alpha*a^gama+beta);
    ia=exp(largenum);
end
if a>=10
    ia=sqrt(pi/a)*(1-10/7/a)*exp(-a/4);
end

if b==0
    ib=1;
end
if b>0 && b<10
    largenum=alpha*b^gama+beta;
    if largenum>700
        largenum=700;
    end
    %ib=exp(alpha*b^gama+beta);
    ib=exp(alpha*b^gama+beta);
end
if b>=10
    ib=sqrt(pi/b)*(1-10/7/b)*exp(-b/4);
end
ic=1-(1-ia)*(1-ib);

if ic==1
    result=0;
end
if ic<1 && ic> exp(alpha*10^gama+beta)
    result=((log(ic)-beta)/alpha)^(1/gama);
end
if ic>=0 && ic<=exp(alpha*10^gama+beta)
    tmp=[10:0.005:600];
    v_tmp=sqrt(pi./tmp).*(1-10/7./tmp).*exp(-tmp./4);
    v_tmp(length(tmp));
    num=1;
    while num<=length(tmp)-1
        if abs(v_tmp(num+1)-ic)>abs(v_tmp(num)-ic)
            break;
        end
        num=num+1;
    end
    result=tmp(num);
end

% if a>0
%     ia=exp(alpha*a^gama+beta);
% else
%     ia=2-exp(alpha*(-a)^gama+beta);
% end
% if b>0
%     ib=exp(alpha*b^gama+beta);
% else
%     ib=2-exp(alpha*(-b)^gama+beta);
% end
% if a==0
%     ia=1;
% end
% if b==0
%     ib=1;
% end
% ic=1-(1-ia)*(1-ib);
% if a*b>0
%     result=((log(ic)-beta)/alpha)^(1/gama);
% else
%     result=-((log(2-ic)-beta)/alpha)^(1/gama);
% end
% if ic==1
%     result=0;
% end
end
