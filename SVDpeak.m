function SVDpeak(ruidosa,original)
%Calcula la descomposicion SVD.
%Calcula pnsr entre la imagen original y reconstruccion ruidosa
%empleando la salida de la funcion nativa psnr de matlab [peaksnr,snr]:
% -tomando el valor maximo peaksnr que facilita la funcion
% -acumulando los valores snr
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

%relacion reconstruida original y reconstruida ruidosa
PSNRratio=zeros(1,m); 
%relacion reconstruida original y ruidosa
PSNR=zeros(1,m);
%relacion  original y reconstruida ruidosa PSNRV
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
end   

subplot(3,1,1);  
plot(PSNR);
title('Función psnr matlab (original, reconst.ruidosa)');

subplot(3,1,2); 
plot(PSNR2);
title('Función PSNR\_V (original, reconst.ruidosa)');

subplot(3,1,3); 
plot(PSNRratio);
title('Función PSNR\_V (reconst. orig, reconst. ruidosa)');

axH = findall(gcf,'type','axes');

vmin= min([min(PSNR),min(PSNR2),min(PSNRratio)]);
vmax= max([max(PSNR),max(PSNR2),max(PSNRratio)]);

set(axH,'ylim',[vmin, vmax+0.5]);



res=max(PSNR);
res2=max(PSNR2);

val1=find(PSNR==res);
val2=find(PSNR2==res2);
fprintf('Función psnr(valor directo peaksnr) Matlab:%f\n',actual);
fprintf('Función psnr(snr) Matlab:%f, K=%d\n',res,val1);
fprintf('Función PSNR_V:%f, K=%d\n',res2,val2);