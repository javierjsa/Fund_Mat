function SVDpeak(ruidosa,original)
%SVDpeak(ruidosa,original)
%Imagenes BW
%Calcula la descomposicion SVD de la imagen original y la ruidosa.
%Calcula psnr (max snr) entre la imagen original y reconstruccion ruidosa
%empleando la salida de la funcion nativa psnr de matlab [peaksnr,snr]:
% -Tomando el valor maximo peaksnr que facilita la funcion
% -Acumulando los valores snr
%Calcula la psnr empleando la función externa PSNR_V
%Calcula la variacion de la PSNR al reconstruir tanto la imagen
%original como la ruidosa empleando PSNR_V.
clc;
close all;
original=im2double(original);
ruidosa=im2double(ruidosa);
%

[U,S,V]=svd(ruidosa);
[Uo,So,Vo]=svd(original);
[x1,y1]=size(original);
[m,n]=size(S);

fro_orig=norm(original,'fro');

%PSNR reconstruida original y reconstruida ruidosa
PSNRratio=zeros(1,m); 
%PSNR (psnr Matlab)  original y reconstruida ruidosa
PSNR=zeros(1,m);
%PSNR (peak psnr Matlab) original y reconstruida ruidosa
PSNR1=zeros(1,m);
%PSNR (PSNR_V)  original y reconstruida ruidosa
PSNR2=zeros(1,m);

%ratio compresion imagen reconstruida
compresion=zeros(1,m);
%norma de frobenius
fro_rec_orig=zeros(1,m);
fro_rec_ruid=zeros(1,m);
recRuid=zeros(m,n,m);
recOrig=zeros(m,n,m);

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
   
   recRuid(:,:,k)=rec;
   recOrig(:,:,k)=rec_orig;
   
   [a1,a2]=size(U(:,1:k));
   [b1,b2]=size(U(:,1:k));
   [c1,c2]=size(U(:,1:k));
   
   tam=(a1*a2)+(b1*b2)+(c1*c2);        
   compresion(1,k)=tam/(x1*y1);  
   
   fro_rec_orig(1,k)=fro_orig/norm(rec_orig,'fro');
   fro_rec_ruid(1,k)=fro_orig/norm(rec,'fro');
   
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

res4=max(compresion);

res6=min(fro_rec_orig);
res7=min(fro_rec_ruid);

val4=find(compresion==res4);

val6=find(fro_rec_orig==res6);
val7=find(fro_rec_ruid==res7);

original_v=PSNR_V(ruidosa,original);
[original_m,valref]=psnr(rec,original);

fprintf('Valores de referencia imágenes de partida:\n\n');
fprintf(' -Función PSNR_V:%f\n',original_v);
fprintf(' -Función psnr (valor directo peaksnr) Matlab: %f\n',original_m);
fprintf('------------------------------------------------------\n');

fprintf('Max psnr(valor directo peaksnr) Matlab:%f, K=%d\n',res,val1);
fprintf('Max psnr(snr) Matlab:%f, K=%d\n',res,val);
fprintf('Max PSNR_V:%f, K=%d\n',res2,val2);

fprintf('------------------------------------------------------\n');
fprintf('Max compresión número pixeles(??) :%f, K=%d\n',res4,val4);
fprintf('------------------------------------------------------\n');
fprintf('Ratios de compresión autovalores:\n\n');
fprintf('Max psnr(peaksnr) Matlab K=%d Procentaje:%f\n',val1,(val1/m)*100);
fprintf('Max psnr(snr) Matlab:K=%d Procentaje:%f\n',val,(val/m)*100);
fprintf('Max PSNR_V:K=%d Procentaje:%f\n',val2,(val2/m)*100);
fprintf('------------------------------------------------------\n');
fprintf('Max ratio norma Frobenius original/reconst orig:%f, K=%d\n',res6,val6);
fprintf('Max ratio norma Frobenius original/reconst ruid:%f, K=%d\n',res7,val7);