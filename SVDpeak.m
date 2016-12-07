function SVDpeak(ruidosa,original)
%SVDpeak(ruidosa,original)
% 
%Calcula la descomposicion SVD de la imagen original y la ruidosa.
%Calcula psnr (max snr) entre la imagen original y reconstruccion ruidosa
%empleando la salida de la funcion nativa psnr de matlab [peaksnr,snr]:
% -Tomando el valor maximo peaksnr que facilita la funcion
% -Acumulando los valores snr
%Calcula la psnr empleando la función externa PSNR_V
%Calcula la variacion de la PSNR al reconstruir tanto la imagen
%original como la ruidosa empleando PSNR_V.
clc;
original=im2double(original);
ruidosa=im2double(ruidosa);
%

[U,S,V]=svd(ruidosa);
[Uo,So,Vo]=svd(original);

[m,n]=size(S);

%PSNR reconstruida original y reconstruida ruidosa
PSNRratio=zeros(1,m); 
%PSNR (psnr Matlab)  original y reconstruida ruidosa
PSNR=zeros(1,m);
%PSNR (peak psnr Matlab) original y reconstruida ruidosa
PSNR1=zeros(1,m);
%PSNR (PSNR_V)  original y reconstruida ruidosa
PSNR2=zeros(1,m);
for k=1:m
   rec=U(:,1:k)*S(1:k,1:k)*V(:,1:k)';
   rec_orig=Uo(:,1:k)*So(1:k,1:k)*Vo(:,1:k)';
   actual=PSNR_V(rec,original);
   PSNR2(1,k)=actual;
   
   ratio=PSNR_V(rec,rec_orig);
   PSNRratio(1,k)=ratio;
   
   [actual,val]=psnr(rec,original);
   PSNR(1,k)=val;
   PSNR1(1,k)=actual;
end   

subplot(4,1,1);  
plot(PSNR);
title('Función psnr matlab (original, reconst.ruidosa)');

subplot(4,1,2);  
plot(PSNR1);
title('Función psnr (peak snr) matlab (original, reconst.ruidosa)');

subplot(4,1,3); 
plot(PSNR2);
title('Función PSNR\_V (original, reconst.ruidosa)');

subplot(4,1,4); 
plot(PSNRratio);
title('Función PSNR\_V (reconst. orig, reconst. ruidosa)');

axH = findall(gcf,'type','axes');

vmin= min([min(PSNR),min(PSNR2),min(PSNRratio)]);
vmax= max([max(PSNR),max(PSNR2),max(PSNRratio)]);

set(axH,'ylim',[vmin, vmax+0.5]);

res=max(PSNR);
res2=max(PSNR2);
res1=max(PSNR1);

val=find(PSNR==res);
val2=find(PSNR2==res2);
val1=find(PSNR1==res1);

original_v=PSNR_V(ruidosa,original);
[original_m,valref]=psnr(rec,original);
fprintf('Valores de referencia imágenes de partida:\n');
fprintf(' -Función PSNR_V:%f\n',original_v);
fprintf(' -Función psnr (valor directo peaksnr) Matlab: %f\n',original_m);
fprintf('------------------------------------------------------\n');

fprintf('Función psnr(valor directo peaksnr) Matlab:%f, K=%d\n',res,val1);
fprintf('Función psnr(snr) Matlab:%f, K=%d\n',res,val);
fprintf('Función PSNR_V:%f, K=%d\n',res2,val2);