clc
clear all
close all



im = double(imread('cameraman.tif'));
transform=fftshift(fft2(im));
real_part=real(transform);


center=129;
circle=zeros(size(im));

[rows columns depth]=size(im);
d=5; n=10;

for u=1:rows
    for v=1:columns

        circle(u,v)=1./(1.+(d./((u-rows/2).^2+(v-columns/2).^2).^0.5).^2*n);
        
       %circle(u,v)=sqrt((u-center).^2+(v-center).^2);
    end
end


%circle=circle<20;  % use circle<20 for low pass
circle=1-circle;


new_fft=transform.*circle;
original=ifft2(fftshift(new_fft));

subplot(221);imshow(log2(real_part+1),[]);impixelinfo, title('fft')
subplot(222);imshow(circle,[]),impixelinfo, title('Circle used')
subplot(223);imshow(log2(new_fft+1),[]),impixelinfo, title('retained fft')
subplot(224);imshow(ifft2(fftshift(new_fft)),[]),impixelinfo, title('image from retained fft')
