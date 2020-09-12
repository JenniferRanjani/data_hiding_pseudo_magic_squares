function [extract] = extract_ms(K,out,csz,N)

global A
global B

[m, n] = size(K);
s = RandStream('mt19937ar','Seed',out);
Q=randperm(s,m*n);

i = 1;
f=zeros(1,4);
N2=N*N;
for j=1:csz
     x=K(Q(i));
     y=K(Q(i+1));
     f(j)=N*(mod((double(y)-A*double(x)),N))+(mod((double(y)-B*double(x)),N));
    
    i = i+2;
end


sz=bi2de(f,N2);
csz=1;
f = zeros(1,(sz*csz));
for j=1:(sz*csz)
     x=K(Q(i));
     y=K(Q(i+1));
     f(j)=N*(mod((double(y)-A*double(x)),N))+(mod((double(y)-B*double(x)),N));
     i = i+2;
end


ek = reshape(f,csz,sz);
EJ = bi2de(ek',N2);
extract = EJ';



