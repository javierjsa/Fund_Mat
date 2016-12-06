function derivatives(imd)
%Calcula derivative5, derivative7 de primer y segundo order
%Genera gráficas y calcula energía


clc;
if not(isfloat(imd))
    imd=double(imd);
end;    
[gx5,gy5,gxx5,gyy5,gxy5]=derivative5(imd,'x','y','xx','xy','xy');
[gx7,gy7,gxx7,gyy7,gxy7]=derivative7(imd,'x','y','xx','xy','xy');



figure(1);
colormap('gray');
a1=subplot(1,2,1);
imagesc(gx5);
title(a1,'Ix. Derivative5');
pbaspect(a1,[1 1 1]);
b1=subplot(1,2,2);
imagesc(gy5);
title(b1,'Iy. Derivative5');
pbaspect(b1,[1 1 1]);


figure(2);
colormap('gray');
a2=subplot(1,2,1);
imagesc(gxx5);
title(a2,'Ixx. Derivative5');
pbaspect(a2,[1 1 1]);
b2=subplot(1,2,2);
imagesc(gyy5);
title(b2,'Iy. Derivative5');
pbaspect(b2,[1 1 1]);


figure(3);
colormap('gray');
a3=subplot(1,2,1);
imagesc(gx7);
title(a3,'Ix. Derivative7');
pbaspect(a3,[1 1 1]);
b3=subplot(1,2,2);
imagesc(gy7);
title(b3,'Iy. Derivative7');
pbaspect(b3,[1 1 1]);


figure(4);
colormap('gray');
a4=subplot(1,2,1);
imagesc(gxx7);
title(a4,'Ixx. Derivative7');
pbaspect(a4,[1 1 1]);
b4=subplot(1,2,2);
imagesc(gyy7);
title(b4,'Iyy. Derivative7');
pbaspect(b4,[1 1 1]);

%Calculo del modulo
%modG5=sqrt(gx5.^2+gy5.^2);
%modG7=sqrt(gx7.^2+gy7.^2);
%[f,g]=imgradient(imd,'prewitt');
%k=sqrt(sum(f(:).^2));


%Calculo de energias
%EG5=sum(modG5(:).^2);
%EG7=sum(modG7(:).^2);

imagen=sum(imd(:).^2);

I5=sum(gx5(:).^2)+sum(gy5(:).^2);
II5=sum(gxx5(:).^2)+sum(gxy5(:).^2);

I7=sum(gx7(:).^2)+sum(gy7(:).^2);
II7=sum(gxx7(:).^2)+sum(gxy7(:).^2);


fprintf('Energía de la imagen: %.3f\n\n',imagen);
fprintf('Energía de\tGradiente\tLaplaciano\n');
fprintf('---------------------------------------------\n');
fprintf('Derivative5\t%.3f\t%.3f\n',I5,II5);
fprintf('Derivative7\t%.3f\t%.3f\n',I7,II7);


end
