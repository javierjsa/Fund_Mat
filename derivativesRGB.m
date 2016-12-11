function derivativesRGB(img)
%derivatesRGB(img)
%calcula el modulo de una imagen en color y muestra el resultado
%junto con la imagen en color

clc;
close all;

imgd=double(img);
[vg,a,ppg]=colorgrad(imgd);

[m,n,j]=size(img);
ratio=m/n;

figure(1);
colormap('gray');
a1=subplot(1,2,1);
imshow(img);
title(a1,'Imagen');
pbaspect(a1,[1 ratio 1]);
set(gca,'XTick',[]);
set(gca,'YTick',[]);
b1=subplot(1,2,2);
imagesc(im2double(vg));
title(b1,'Modulo del gradiente');
pbaspect(b1,[1 ratio 1]);
set(gca,'XTick',[]);
set(gca,'YTick',[]);


end