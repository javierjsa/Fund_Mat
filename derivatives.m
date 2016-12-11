function derivatives(imd)
%Calcula derivative5, derivative7 de primer y segundo orden
%Calcula el modulo del gradiente
%Genera gráficas y calcula energía

close all;
clc;
if not(isfloat(imd))
    imd=double(imd);
end;    
[gx5,gy5,gxx5,gyy5,gxy5]=derivative5(imd,'x','y','xx','xy','xy');
[gx7,gy7,gxx7,gyy7,gxy7]=derivative7(imd,'x','y','xx','xy','xy');

% Modulo del gradiente
gmag5 = hypot(gx5,gy5);
gmag7 = hypot(gx7,gy7);

%Modulo del Laplaciano
mlap5=hypot(gxx5,gyy5);
mlap7=hypot(gyy7,gyy7);

lap5=gxx5+gyy5;
lap7=gyy7+gyy7;

imagen=sum(imd(:).^2);

%energia del gradiente y laplaciando
%derivative5
I5=sum(gx5(:).^2+gy5(:).^2);
II5=sum(gxx5(:).^2+gxy5(:).^2);

%energia del gradiente y laplaciando
%derivative7
I7=sum(gx7(:).^2+gy7(:).^2);
II7=sum(gxx7(:).^2+gxy7(:).^2);


figure('name','Gradiente Derivative5');
colormap('gray');
a1=subplot(1,2,1);
imagesc(gx5);
title(a1,'Ix. Derivative5');
pbaspect(a1,[1 1 1]);
b1=subplot(1,2,2);
imagesc(gy5);
title(b1,'Iy. Derivative5');
pbaspect(b1,[1 1 1]);


figure('name','Laplaciano Derivative5');
colormap('gray');
a2=subplot(1,2,1);
imagesc(gxx5);
title(a2,'Ixx. Derivative5');
pbaspect(a2,[1 1 1]);
b2=subplot(1,2,2);
imagesc(gyy5);
title(b2,'Iyy. Derivative5');
pbaspect(b2,[1 1 1]);


figure('name','Gradiente Derivative7');
colormap('gray');
a3=subplot(1,2,1);
imagesc(gx7);
title(a3,'Ix. Derivative7');
pbaspect(a3,[1 1 1]);
b3=subplot(1,2,2);
imagesc(gy7);
title(b3,'Iy. Derivative7');
pbaspect(b3,[1 1 1]);


figure('name','Laplaciano Derivative7');
colormap('gray');
a4=subplot(1,2,1);
imagesc(gxx7);
title(a4,'Ixx. Derivative7');
pbaspect(a4,[1 1 1]);
b4=subplot(1,2,2);
imagesc(gyy7);
title(b4,'Iyy. Derivative7');
pbaspect(b4,[1 1 1]);

figure('name','Modulo gradiente Derivative5,Derivative7');
colormap('gray');
a5=subplot(1,2,1);
imagesc(gmag5);
title(a5,'Mod. Gradiente Der5');
pbaspect(a5,[1 1 1]);
b5=subplot(1,2,2);
imagesc(gmag7);
title(b5,'Mod. Gradiente Der7');
pbaspect(b5,[1 1 1]);

figure('name','Modulo Laplaciano Derivative5, Derivative7');
colormap('gray');
a7=subplot(1,2,1);
imagesc(mlap5);
title(a7,'Mod. Laplaciano Der5');
pbaspect(a7,[1 1 1]);
b7=subplot(1,2,2);
imagesc(mlap7);
title(b7,'Mod. Laplaciano Der7');
pbaspect(b7,[1 1 1]);

%{
figure('name','Laplaciano Derivative5');
colormap('gray');
a8=subplot(1,2,1);
imagesc(gyy5);
title(a8,'gyy5');
pbaspect(a8,[1 1 1]);
b8=subplot(1,2,2);
imagesc(-gxx5);
title(b8,'gxx5');
pbaspect(b8,[1 1 1]);
%}
%{
im=sqrt(gx5.^2+gy5.^2);

figure(6)
colormap('gray');
a6=subplot(1,2,1);
imagesc(im);
title(a6,'Mod. gradiente ');
pbaspect(a6,[1 1 1]);
b6=subplot(1,2,2);
imagesc(abs(im-gmag5));
title(b6,'residuo');
pbaspect(b6,[1 1 1]);
%}

fprintf('Energía de la imagen: %.3f\n\n',imagen);
fprintf('Energía de\tGradiente\tLaplaciano\n');
fprintf('---------------------------------------------\n');
fprintf('Derivative5\t%.3f\t\t%.3f\n',I5,II5);
fprintf('Derivative7\t%.3f\t\t%.3f\n',I7,II7);

fprintf('Modulo del gradiente\n');
fprintf('---------------------------------------------\n');
fprintf('Derivative5\t%.3f\n',sum(gmag5(:)));
fprintf('Derivative7\t%.3f\n',sum(gmag7(:)));

fprintf('Modulo del laplaciano\n');
fprintf('---------------------------------------------\n');
fprintf('Derivative5\t%.3f\n',sum(mlap5(:)));
fprintf('Derivative7\t%.3f\n',sum(mlap7(:)));

end
