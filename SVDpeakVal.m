function SVDpeakVal(ruidosa,original,valores,color)
%calcula la descomposicion SVD en color y bw
%calcula pnsr y ratio para un conjunto de valores
%SVDpeak(ruidosa,original,[v1,v2,vn]
%Resultados:
% - peaksnr calculado directamente por Matlab
% - psnr calculado con PSNR_V
% - psnr entre la reconstrucción de I y la imagen ruidosa.
clc;
if(color=='y')
    fprintf('Imagen en color\n');
    original=im2bw(original);
    ruidosa=im2bw(ruidosa);
else
    fprintf('Imagen en BW\n');
end    
original=im2double(original);
ruidosa=im2double(ruidosa);

[U,S,V]=svd(ruidosa);
[Uo,So,Vo]=svd(original);

[m,n]=size(S);
long=length(valores);
%relacion reconstruida original y reconstruida ruidosa
PSNRratio=zeros(1,long); 
%relacion reconstruida original y ruidosa
PSNR=zeros(1,long);
%relacion  original y reconstruida ruidosa PSNRV
PSNR2=zeros(1,long);
for j=1:long
   k=valores(j);
   rec=U(:,1:k)*S(1:k,1:k)*V(:,1:k)';
   rec_orig=Uo(:,1:k)*So(1:k,1:k)*Vo(:,1:k)';
   actual=PSNR_V(rec,original);
   PSNR2(1,j)=actual;
   
   ratio=PSNR_V(rec,rec_orig);
   PSNRratio(1,j)=ratio;
   
   [actual,val]=psnr(rec,original);
   PSNR(1,j)=val;
end   

fprintf('K\tpeaksnr Matlab\tPSNR_V(I,ruid.)\tPSNR_V(rec. I,rec.ruidosa)\n');
fprintf('------------------------------------------------------------------\n');
for j=1:long
    fprintf('%d\t%f\t%f\t%f\n',valores(j),PSNR(1,j),PSNR2(1,j),PSNRratio(1,j));    
end