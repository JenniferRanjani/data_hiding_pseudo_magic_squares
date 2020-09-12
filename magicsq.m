function [steg,out,csz]=magicsq(I,J,N)
global A
global B

%To avoid overflow
t=floor(N/2);
I(I<t)=t;
I(I>(255-t))=255-t;

[m,n]=size(I);

cn=ceil(N/2);

for x=-t:cn-1
for y=-t:cn-1
FM(x+t+1,y+t+1)=mod(y-A*x,N);
SM(x+t+1,y+t+1)=mod(y-B*x,N);
end
end
SB = N*FM+SM;

%--------------------------------------------------------------------------
out = randseed;   %Secret Key

%-------------message to base-N conversion--------------------------------

J=double(J);
msg_int =J;
ms_in_sz = length(msg_int(:));
N2=N*N;
csz = length(de2bi(ms_in_sz,[],N2));  % base conversion size
msg = [de2bi(ms_in_sz,csz,N2) msg_int(:)'];

%-----------------Embed----------------------------------------------------
steg=embed_ms(I,msg,out,SB);
steg = reshape(steg,[m n]);
