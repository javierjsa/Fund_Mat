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
[x1,y1]=size(original);

fro_orig=norm(original,'fro');

recRuid=zeros(m,n,length(valores));
recOrig=zeros(m,n,length(valores));
long=length(valores);
%relacion reconstruida original y reconstruida ruidosa
PSNRratio=zeros(1,long); 
%relacion reconstruida original y ruidosa
PSNR=zeros(1,long);
%relacion  original y reconstruida ruidosa PSNRV
PSNR2=zeros(1,long);
%ratio compresion imagen reconstruida
compresion=zeros(1,long);
%norma de frobenius
fro_rec_orig=zeros(1,long);
fro_rec_ruid=zeros(1,long);

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
   
   recRuid(:,:,j)=rec;
   recOrig(:,:,j)=rec_orig;
   
   [a1,a2]=size(U(:,1:k));
   [b1,b2]=size(U(:,1:k));
   [c1,c2]=size(U(:,1:k));
   
   tam=(a1*a2)+(b1*b2)+(c1*c2);        
   compresion(1,j)=tam/(x1*y1);  
   
   fro_rec_orig(1,j)=fro_orig/norm(rec_orig,'fro');
   fro_rec_ruid(1,j)=fro_orig/norm(rec,'fro');
   
  
end   

fprintf('K\tpeaksnr Matlab\tPSNR_V(I,ruid.)\tPSNR_V(rec. I,rec.ruidosa)\n');
fprintf('------------------------------------------------------------------\n');
for j=1:long
    fprintf('%d\t%f\t%f\t%f\n',valores(j),PSNR(1,j),PSNR2(1,j),PSNRratio(1,j));    
end

fprintf('\nK\tRatio de compresion (pixels descomp/pixel original)\n');
fprintf('------------------------------------------------------------------\n');
for j=1:long
    fprintf('%d\t%f\n',valores(j),compresion(1,j));    
end

fprintf('\nCociente norma frobenius original/reconstrucción\n');
fprintf('K\tRec. original\tRec. ruidosa\n');
fprintf('------------------------------------------------------------------\n');
for j=1:long
    fprintf('%d\t%f\t%f\n',valores(j),fro_rec_orig(1,j),fro_rec_ruid(1,j));    
end

figure('name','Reconstrucción imagen original');
for i=1:length(valores)   
  subplot(1,length(valores),i);    
  imshow(recOrig(:,:,i));  
end  

figure('name','Reconstrucción imagen ruidosa');
for i=1:length(valores)  
  subplot(1,length(valores),i);
  imshow(recRuid(:,:,i));  
end 
