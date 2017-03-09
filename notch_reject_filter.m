clc
clear all
close all
warning('off');
%im = double(imread('D:\Program Files (x86)\MATLAB\R2009a\toolbox\images\imdemos\lena.jpg','jpg'));
 im = double(imread('cameraman.tif'));

transform=fftshift(fft2(im));
%real_part=real(transform);

[rows nop]=size(transform);

transform(rows/2+70,128)=transform(129,129);
transform(rows/2-70,128)=transform(129,129);




uo=70;
vo=0;

d1=zeros(size(im));
d2=zeros(size(im));
center=rows/2;

circle=zeros(size(im));

[rows columns]=size(im);

for u=1:rows
    for v=1:columns

        d1(u,v)=sqrt((u-128-uo).^2+(v-128-vo).^2);
        d2(u,v)=sqrt((u-128+uo).^2+(v-128+vo).^2);
       
    end
end

d1=d1+0.000000000000000000000001;
d2=d2+0.000000000000000000000001;

width=10;
ratio=(d1.*d2)./(width.^2);
h=1-exp(-(1/2)*ratio);
figure, imshow(h, []);

new_fft=transform.*h;


subplot(231),imshow(log(transform),[]);impixelinfo, title('distorted fft')
subplot(232),imshow(ifft2(fftshift(transform)),[]),impixelinfo, title('distorted image')
subplot(233),imshow(h,[]), title('filter used'),impixelinfo
subplot(234),imshow(log(new_fft),[]),title('filter*distorted fft')
subplot(235),imshow(ifft2(fftshift(new_fft)),[]),title('ifft'),impixelinfo




