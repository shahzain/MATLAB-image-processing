im = double(imread('cameraman.tif'));
subplot(221);imshow(im,[]),impixelinfo
counter=zeros(1,256);

for i=1:1:256
    for j=1:1:256
        a=im(i,j);
        counter(a) = counter(a)+1;
        
    end
end
subplot(222);plot(counter)

