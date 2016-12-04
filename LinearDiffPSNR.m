function [data,datan]=LinearDiffPSNR(original,fn, lambda, dt, start,stop,step,param)
%function [data,datan]=LinearDiffPSNR(original,fn, lambda, dt, start,stop,step)
original=im2double(original);
fn=im2double(fn);
[m,n]=size(fn);
Nit=start:step:stop;
datan=zeros(1,length(Nit));
data=zeros(1,length(Nit));
imlambda=zeros(m,n,length(Nit));
imnlambda=zeros(m,n,length(Nit));


for i=1:length(Nit)   
    it=Nit(i);
    [un, diff_un]=LinearDiffusion2016(fn, 0, dt, it);
    imnlambda(:,:,i)=un;
    
    valorn=PSNR_V(un,original);  
    datan(1,i)=valorn;    
    
    [u, diff_u]=LinearDiffusion2016(fn, lambda, dt, it);
    imlambda(:,:,i)=im2uint8(double(u));
      
    valor=PSNR_V(u,original);  
    data(1,i)=valor;
end  
fprintf('\tPSNR nolambda\tPSNR lambda\t\n');
fprintf('--------------------------------------------------\n');
for j=1:length(Nit)
    fprintf('%d\t%f\t%f\n',Nit(j),datan(1,j),data(1,j));    
end
maxl=find(data==max(data));
maxnl=find(datan==max(datan));
fprintf('--------------------------------------------------\n');
fprintf('Max lambda\t%d\t%f\n',Nit(maxl),max(data)); 
fprintf('Max nolambda\t%d\t%f\n',Nit(maxnl),max(datan));

figure(1);
subplot(2,1,1);  
plot(datan);
title('No lambda');

subplot(2,1,2); 
plot(data);
title('lambda');
if(param=='y')
    [un, diff_un]=LinearDiffusion2016(fn, 0, dt, maxnl);
    [u, diff_u]=LinearDiffusion2016(fn, lambda, dt, maxl);

    figure(2);
    imshow(im2double(un));
    title('No lambda');

    figure(3) 
    imshow(im2double(u));
    title('lambda');
end


