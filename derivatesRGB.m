function derivatesRGB(img)
%derivatesRGB(img)
%calcula el modulo de una imagen en color y muestra el resultado
%junto con la imagen en color

imgd=double(img);
[vg,a,ppg]=colorgrad(imgd);



figure(1);
colormap('gray');
a1=subplot(1,2,1);
imageshow(img);
title(a1,'Imagen');
pbaspect(a1,[1 1 1]);
b1=subplot(1,2,2);
imagesc(im2double(vg));
title(b1,'Modulo del gradiente');
pbaspect(b1,[1 1 1]);

end