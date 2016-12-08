function insVisRGB(original,ruidosa,lambda, dt, Nit)
%insVis(original,ruidosa,lambda, dt, Nit)
%Realiza filtrado y difusión con los paramateros indicados en color
%Muestra imágenes para inspección visual.
%La diferencia de imágenes es multiplicada por 3 para apreciar
%mejor el resultado.
    
 [m,n,j]=size(ruidosa);
 ruidosa=im2double(ruidosa);
 original=im2double(original);
 
 res_filt=zeros(m,n,j);
 res_noi=zeros(m,n,j);
 for chn=1:3        
    ruid=ruidosa(:,:,chn);
    [res_filt(:,:,chn), diff_un]=LinearDiffusion2016(ruid, 0, dt, Nit);  
    [res_noi(:,:,chn), diff_u]=LinearDiffusion2016(ruid, lambda, dt, Nit);
 end
    
    diff_filt=(ruidosa-res_filt)*3;
    diff_noi=(ruidosa-res_noi)*3;
    
       
    figure(1);   
    subplot(1,3,1);   
    imshow(original);
    title('Imagen original');
    
    subplot(1,3,2);
    imshow(im2double(res_filt));
    title('Imagen Filtrado'); 
    
    subplot(1,3,3);
    imshow(rgb2gray(diff_filt));
    title('(Ruidosa-Filtrada)*3');
    
    figure(2);   
    subplot(1,3,1);   
    imshow(original);
    title('Imagen original');
    
    subplot(1,3,2);
    imshow(im2double(res_noi));
    title('Imagen Denoise');   
    
    subplot(1,3,3);    
    imshow(rgb2gray(diff_noi));
    title('(Ruidosa-Denoise)*3'); 
    
end   