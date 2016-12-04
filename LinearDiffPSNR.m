function [data,datan]=LinearDiffPSNR(fn, lambda, dt, val)
[m,n]=size(fn);
Nit=length(val);
datan=zeros(1,Nit);
data=zeros(1,Nit);
fn=im2double(fn);
imlambda=zeros(m,n,Nit);
imnlambda=zeros(m,n,Nit);


for i=1:Nit   
    it=val(i);
    [un, diff_un]=LinearDiffusion2016(fn, 0, dt, it);
    imnlambda(:,:,i)=un;
    %un=im2double(un);
    %prevn=im2double(un);    
    valorn=PSNR_V(un,fn);  
    datan(i)=valorn;    
    
    [u, diff_u]=LinearDiffusion2016(fn, lambda, dt, it);
    imlambda(:,:,i)=im2uint8(double(u));
    %u=im2double(u);
    %prev=im2double(u);    
    valor=PSNR_V(u,fn);  
    data(i)=valor;
end  
%un=double(un);
%u=double(u);
%un=im2uint8(un);
%u=im2uint8(u);
%{
subplot(4,1,1);  
plot(data);
title('Difusion')

subplot(4,1,3); 
plot(datan);
title('Filtrado (lambda=0)');
%}
figure;
title('Con lambda');
for i=1:Nit
    subplot(1,Nit,i);  
    img=uint8(im2double(imlambda(:,:,i)));
    imshow(img);
    %imshow(fn);
    %subplot(2,Nit,i);
    %imshow(imnlambda(:,:,i));    
end

figure;
title('Sin lambda');
for i=1:Nit
    subplot(1,Nit,i);  
    img=uint8(im2double(imnlambda(:,:,i)));
    imshow(img);
    %imshow(fn);
    %subplot(2,Nit,i);
    %imshow(imnlambda(:,:,i));    
end
