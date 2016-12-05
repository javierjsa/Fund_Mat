function [data,datan]=LinearDiffPSNR(original,fn, lambda, dt, start,stop,step,param)
%Realiza un proceso de difusion pura y denoising dentro del rango de
%iteraciones start-step-stop. Genera un grafico y selecciona le maximo.
%function [data,datan]=LinearDiffPSNR(original,fn, lambda, dt, start,stop,step)
original=im2double(original);
fn=im2double(fn);
[m,n]=size(fn);
Nit=start:step:stop;
datan=zeros(1,length(Nit));
data=zeros(1,length(Nit));
imlambda=zeros(m,n,length(Nit));
imnlambda=zeros(m,n,length(Nit));

clc;
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
fprintf('\n Iter\tPSNR difusión\tPSNR denoise\t\n');
fprintf('--------------------------------------------------\n');
for j=1:length(Nit)
    fprintf('%d\t%f\t%f\n',Nit(j),datan(1,j),data(1,j));    
end
maxl=find(data==max(data));
maxnl=find(datan==max(datan));

fprintf('\n\t\tK\tPSNR\n');
fprintf('--------------------------------------------------\n');
fprintf('Max denoise\t%d\t%f\n',Nit(maxl),max(data)); 
fprintf('Max difusión\t%d\t%f\n',Nit(maxnl),max(datan));

figure(1);
subplot(2,1,1);  
plot(Nit,datan);
title('Difusión');

subplot(2,1,2); 
plot(Nit,data);
title('Denoise');

axH = findall(gcf,'type','axes');

if max(data)>max(datan)
    set(axH,'ylim',[min(datan), max(data)+0.5]);
else
    set(axH,'ylim',[min(datan), max(datan)+0.5]);
end

if(param=='y')
    figure(2);
    [un, diff_un]=LinearDiffusion2016(fn, 0, dt, maxnl);
    [u, diff_u]=LinearDiffusion2016(fn, lambda, dt, maxl);
    subplot(1,2,1);   
    imshow(im2double(un));
    title('Difusión');
    
    subplot(1,2,2);
    imshow(im2double(u));
    title('Denoise');
end


