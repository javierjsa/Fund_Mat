function SVDpeakRGB(ruidosa,original)
%calcula la descomposicion SVD
%calcula pnsr de imagen RGB convirtiendo a bw
%SVDpeakRGB(ruidos.original)


original=im2bw(original);
ruidosa =im2bw(ruidosa);

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
title('PSNR matlab RGB')

subplot(3,1,2); 
plot(PSNR2);
title('PSNR con PSNR_V RGB');

subplot(3,1,3); 
plot(PSNRratio);
title('Ratio reconst orig-ruidosa RGB');

res=max(PSNR);
res2=max(PSNR2);
val=find(PSNR==actual);
val1=find(PSNR==res);
val2=find(PSNR2==res2);
fprintf('Matlab PSNR direct:%f, K=%d\n',actual,val);
fprintf('Matlab PSNR matlab:%f, K=%d\n',res,val1);
fprintf('Matlab PSNR calcul:%f, K=%d\n',res2,val2);