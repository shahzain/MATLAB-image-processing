close all

im = double(imread('cameraman.tif')); %read image store in im
%%im = double(imread('lena.png'));
im_out_y= zeros(size(im)); 

im_out_x= zeros(size(im));

fil= [1 0 -1;2 0 -2;-1 -1 -1];

fil1 = [1 2 1; 0 0 0; -1 -2 -1];


for i=2:size(im,1)-1
    for j=2:size(im,2)-1
        
        im_out_x(i,j)= sum(sum(im(i-1:i+1,j-1:j+1).*fil));
        im_out_y(i,j)= sum(sum(im(i-1:i+1,j-1:j+1).*fil1));
   
    end
end

subplot(221);imshow(im_out_y,[]),impixelinfo, title=('in y');
subplot(222);imshow(im_out_x,[]),impixelinfo, title=('in x');


H= fspecial('gaussian',3);

C = conv2(im, H, 'same');

S = [-1 -2 -1;0 0 0;1 2 1];

Gy = conv2(C, S, 'same');

S=S';

Gx = conv2(C, S, 'same');

gradmag = sqrt(Gx.^2 + Gy.^2);

figure, imshow(gradmag,[]);

fo;