function resp=LinearDiffPSNR(original,fn, lambda, dt, start,stop,step,showImg,showRes)
%Realiza un proceso en BW de filtrado pura y denoising dentro del rango de
%iteraciones start-step-stop. Genera un grafico y selecciona le maximo.
%function [data,datan]=LinearDiffPSNR(original,ruidosa, lambda, dt, start,stop,step)

clc;
close all;

original=im2double(original);
fn=im2double(fn);
[m,n]=size(fn);

Nit=start:step:stop;

%Datos PSNR difusion
datan=zeros(1,length(Nit));
%Datos PSNR denoise
data=zeros(1,length(Nit));

%Imagenes de filtrado
imlambda=zeros(m,n,length(Nit));

%Imagenes de denoise
imnlambda=zeros(m,n,length(Nit));

clc;
for i=1:length(Nit)   
    it=Nit(i);
    [un, diff_un,funcf]=LinearDiffusion2016f(fn, 0, dt, it);
    imnlambda(:,:,i)=un;    
    
    valorn=PSNR_V(un,original);  
    datan(1,i)=valorn;    
    
    [u, diff_u,funcd]=LinearDiffusion2016f(fn, lambda, dt, it);    
    imlambda(:,:,i)=u;
    
    valor=PSNR_V(u,original);  
    data(1,i)=valor;
end  
if(showRes=='y')
    fprintf('Lambda: %d, dt: %2.2e, BW\n',lambda,dt); 
    fprintf('\n Iter\tPSNR filtrado\tPSNR denoise\t\n');
    fprintf('--------------------------------------------------\n');
    for j=1:length(Nit)
        fprintf('%d\t%f\t%f\n',Nit(j),datan(1,j),data(1,j));    
    end
    maxl=find(data==max(data));
    maxnl=find(datan==max(datan));

    fprintf('\n\t\tIter\tPSNR\n');
    fprintf('--------------------------------------------------\n');
    fprintf('Max denoise\t%d\t%f\n',Nit(maxl),max(data)); 
    fprintf('Max filtrado\t%d\t%f\n',Nit(maxnl),max(datan));

    figure(1);
    subplot(2,1,1);  
    plot(Nit,datan);
    title('PSNR Filtrado');

    subplot(2,1,2); 
    plot(Nit,data);
    title('PSNR Denoise');    
      

    axH = findall(gcf,'type','axes');

    if max(data)>max(datan)
        set(axH,'ylim',[min(datan), max(data)+0.5]);
    else
        set(axH,'ylim',[min(datan), max(datan)+0.5]);
    end
    
    it=1:1:length(funcf);
    
    figure(2);
    subplot(2,1,1);  
    plot(it,funcf);
    title('Energía funcional Filtrado');

    subplot(2,1,2); 
    plot(it,funcd);
    title('Energía funcional Denoise');
    
    
    datait=zeros(1,length(Nit)-1);
    datanit=zeros(1,length(Nit)-1);
    
    for i=2:length(Nit)
        datait(i-1)=data(i)-data(i-1);
        datanit(i-1)=datan(i)-datan(i-1);
    end
    
    it=1:1:length(datait);
    
    figure(3);
    subplot(2,1,1);  
    plot(it,datait);
    title('Variación PSNR iteradas filtrado');

    subplot(2,1,2); 
    plot(it,datanit);
    title('Variación PSNR iteradas Denoise');
   
end

if(showImg=='y')
    figure(4);
    [un, diff_un]=LinearDiffusion2016(fn, 0, dt, maxnl);
    [u, diff_u]=LinearDiffusion2016(fn, lambda, dt, maxl);
   
    subplot(1,2,1);   
    imshow(im2double(imnlambda(:,:,maxnl)));
    title('Imagen Filtrado');
    
    subplot(1,2,2);
    imshow(im2double(imlambda(:,:,maxl)));
    title('Imagen Denoise');   
    
    %REPASAR!!!
end

resp=[datan' data']';
end