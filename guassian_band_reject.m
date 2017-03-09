clc
clear all
close all
warning('off');

%im = double(imread('D:\Program Files (x86)\MATLAB\R2009a\toolbox\images\imdemos\lena.jpg','jpg'));
 im = double(imread('cameraman.tif'));

transform=fftshift(fft2(im));
real_part=real(transform);

[rows unused]=size(transform);

transform(rows/2+50,129)=transform(129,129);
transform(rows/2-50,129)=transform(129,129);


transform(129,rows/2+100)=transform(129,129);
transform(129,rows/2-100)=transform(129,129);


circle=zeros(size(im));

[rows columns]=size(im);

for u=1:rows
    for v=1:columns

       circle(u,v)=sqrt( ((u-(rows/2)).^2) + ((v-(columns/2)).^2));
       
    end
end

cutt_off=50;
cutt_off_2=100;

width=0.1625/0.1;

nom=(circle.^2)-(cutt_off.^2);
nom2=(circle.^2)-(cutt_off_2.^2);


den=circle.*width;

r=(nom./den).^2;
r2=(nom2./den).^2;

H=1-exp(-(1/2)*r);
H2=1-exp(-(1/2)*r2);






new_fft=transform.*(H.*H2);

subplot(231),imshow(ifft2(fftshift(transform)),[]);impixelinfo, title('distorted image')
subplot(232),imshow(log(abs(real(transform))),[]),impixelinfo, title('distorted fft')
subplot(233),imshow(H.*H2,[]), title('filter used'),impixelinfo
subplot(234),imshow(log((new_fft)),[]),title('filter*distorted fft')
subplot(235),imshow(ifft2(fftshift(new_fft)),[]),title('ifft'),impixelinfo



