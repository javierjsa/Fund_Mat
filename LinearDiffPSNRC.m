function resp=LinearDiffPSNRC(original,fn, lambda, dt, start,stop,step,showImg)
%Realiza un proceso en COLOR de difusion pura y denoising dentro del rango de
%iteraciones start-step-stop. Genera un grafico y selecciona le maximo.
%function [data,datan]=LinearDiffPSNR(original,ruidosa, lambda, dt, start,stop,step)

original=double(original);
fn=double(fn);
[m,n,i]=size(fn);
Nit=start:step:stop;
resps=zeros(2,length(Nit));
for chn=1:3
    orig=original(:,:,chn);
    ruid=fn(:,:,i);
    resp=LinearDiffPSNR(orig,ruid,2,1.e-2,start,stop,step,'n','n');
    resps=resps+resp;
end

data=resps(2,:);
datan=resps(1,:);

fprintf('Lambda: %d, dt: %2.2e, COLOR\n',lambda,dt); 
    fprintf('\n Iter\tPSNR difusión\tPSNR denoise\t\n');
    fprintf('--------------------------------------------------\n');
    for j=1:length(Nit)
        fprintf('%d\t%f\t%f\n',Nit(j),datan(1,j),data(1,j));    
    end
    
    maxl=find(data==max(data));
    maxnl=find(datan==max(datan));

    fprintf('\n\t\tIter\tPSNR\n');
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

if(showImg=='y')
    imdif=zeros(m,n,3);
    imnoi=zeros(m,n,3);
    for chn=1:3        
        ruid=fn(:,:,chn);    
        [imdif(:,:,chn), diff_un]=LinearDiffusion2016(ruid, 0, dt, maxnl);
        [imnoi(:,:,chn), diff_u]=LinearDiffusion2016(ruid, lambda, dt, maxl);
    end
    
   
    
    
    figure(2);
    subplot(1,2,1);    
    imshow(uint8(imdif));
    title('Difusión');
    
    subplot(1,2,2);
    imshow(uint8(imnoi));
    title('Denoise');
    

    %{
    subplot(1,2,1);   
    
    imshow(im2double(imdif));
    title('Difusión');
    
    subplot(1,2,2);
    imagesc(imdif);
    title('Denoise');
    
end  
  %}
end
end