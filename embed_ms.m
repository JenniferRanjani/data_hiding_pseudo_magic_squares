function K=embed_ms(I,sd,out,SB)
global A
global B

N=size(SB,1);


[m, n] = size(I);
s = RandStream('mt19937ar','Seed',out);
Q=randperm(s,m*n);

K =I;
i=1;
cn=ceil(N/2);
fn=floor(N/2);

for j=1:length(sd)
     x=I(Q(i));
     y=I(Q(i+1));
     f=mod((double(y)-A*double(x)),N);
     s = mod((double(y)-B*double(x)),N);
     ms=N*f+s;
     
     [xms,yms]=find(SB==ms);
     [xsd,ysd]=find(SB==sd(j));
     
    xd = xsd-xms;
    yd = ysd-yms;
    
    
    xm=xd.*(abs(xd)<=fn)+mod(xd,N).*(xd<-fn)+(mod(xd,N)-N).*(xd>fn);
    ym=yd.*(abs(yd)<=fn)+mod(yd,N).*(yd<-fn)+(mod(yd,N)-N).*(yd>fn);
    
   
    xc = x+xm;
    yc = y+ym;
    K(Q(i))=xc;
    K(Q(i+1))=yc;
    i=i+2;
end

