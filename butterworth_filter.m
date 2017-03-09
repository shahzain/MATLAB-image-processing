clc
clear all
close all


im = double(imread('cameraman.tif'));


transform=fftshift(fft2(im));
real_part=real(transform);

%high pass filter
d=10;
n=2;
h=size(im,1);
w=size(im,2);
[x,y]=meshgrid(-floor(w/2):floor((w-1)/2),-floor(h/2):floor((h-1)/2));
out_high=1./(1.+(d./(x.^2+y.^2).^0.5).^2*n);


%low pass filter
d=1;
n=1;
h=size(im,1);
w=size(im,2);
[x,y]=meshgrid(-floor(w/2):floor((w-1)/2),-floor(h/2):floor((h-1)/2));
out_low=1-out_high;



used=transform.*out_low;

new_fft=transform.*out_low;
original=ifft2(fftshift(new_fft));


subplot(221);imshow(log2(real_part+1),[]);impixelinfo, title('fft')
%subplot(222);imshow(out_high,[]),impixelinfo, title('Circle used')
subplot(222);imshow(out_low,[]),impixelinfo, title('Circle used')
subplot(223);imshow(used,[]),impixelinfo, title('fft used')
subplot(224);imshow(original,[]),impixelinfo, title('image')



