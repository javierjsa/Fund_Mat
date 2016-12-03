function SVDpeak(ruidosa,original,param)
%calcula la descomposicion SVD
%calcula pnsr
if param=='C'
    ruidosa=rgb2gray(ruidosa);
    original=rgb2gray(original);
end 
original=im2double(original);
ruidosa=im2double(ruidosa);
%

[U,S,V]=svd(ruidosa);
[m,n]=size(S);
PSNR=zeros(1,m);
PSNR2=zeros(1,m);
for k=1:m
   rec=U(:,1:k)*S(1:k,1:k)*V(:,1:k)';
   actual=PSNR_V(rec,original);
   PSNR2(1,k)=actual;
   [actual,val]=psnr(rec,original);
   PSNR(1,k)=val;
end   

plot(PSNR);
hold on;
plot(PSNR2);
hold off;
res=max(PSNR);
res2=max(PSNR2);
val=find(PSNR==actual);
val1=find(PSNR==res);
val2=find(PSNR2==res2);
fprintf('Matlab PSNR direct:%f, K=%d\n',actual,val);
fprintf('Matlab PSNR matlab:%f, K=%d\n',res,val1);
fprintf('Matlab PSNR calcul:%f, K=%d\n',res2,val2);