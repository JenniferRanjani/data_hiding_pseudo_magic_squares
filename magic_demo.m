clc
clear all;
close all;

%Read the cover image. We assume that the cover image is in grayscale
Im = imread('boat512.tiff');
if ndims(Im) >=2
    I = double(Im(:,:,1));  
else
    I = double(Im);
end

[m,n]=size(I);

%Parameter Setting
N=15;
global A
global B
A=2;
B=3;

%Generate the random secret message
ssz=floor(sqrt(0.5*m*n));
sz=(ssz*ssz);
J = randi([0 N^2-1],1,sz);
%J=reshape(J,[ssz ssz]);

%Embed the random secret on the cover image 
[steg_magic,out,csz]=magicsq(I,J,N);
figure,imshow(uint8(steg_magic))


%Extraction phase
extract_magic = extract_ms(steg_magic,out,csz,N);

%Verify that the extracted message is same as the generated secret message
sum(sum(J-extract_magic))


