function SVDp(imagen,param)
%calcula la descomposicion SVD
%calcula pnsr
if param=='C'
    imagen=rgb2gray(imagen);
    %original=rgb2gray(original);
end 
imagen=im2double(imagen);
%

[U,S,V]=svd(imagen);
[m,n]=size(S);
actual=0
for k=1:m
   prev=actual;
   rec=U(:,1:k)*S(1:k,1:k)*V(:,1:k)';
   %a=U(:,1:k);
   %b=firma(1:k,1:k);
   %c=V(:,1:k)';
   %rec=a*b*c;
   actual=PSNR_V(rec,imagen);
   fprintf ('\n----------------------------\n');
   fprintf ('K: %d PSNR: %f INCREMENTO: %f\n',k,actual,actual-prev);
   fprintf ('Ratio:%f\n',(m*n)/(k*(m+n+1)));
   fprintf ('----------------------------\n');
   
end
imshow(rec);

