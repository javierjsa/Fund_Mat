function insVis(original,ruidosa,lambda, dt, Nit)
%insVis(original,ruidosa,lambda, dt, Nit)
%Realiza filtrado y difusión con los parametros indicados
%Muestra imágenes para inspección visual
%La diferencia entre imagenes se multiplica por tres para apreciar
%mejor la diferencia.
    
    clc;
    close all;
    
    original=im2double(original);
    ruidosa=im2double(ruidosa);
    
    [un, diff_un]=LinearDiffusion2016(ruidosa, 0, dt, Nit);  
    [u, diff_u]=LinearDiffusion2016(ruidosa, lambda, dt, Nit);
    
    psnr_fil=PSNR_V(original,un);
    psnr_noi=PSNR_V(original,u);
    
    fprintf('PSNR filtrado:%.3f\n',psnr_fil);
    fprintf('PSNR denoise:%.3f\n',psnr_noi);
    
    diff_filt=(ruidosa-un)*3;
    diff_noi=(ruidosa-u)*3;
    
    figure(1);   
    subplot(1,3,1);   
    imshow(original);
    title('Imagen original');
    
    subplot(1,3,2);
    imshow(im2double(un));
    title('Imagen Filtrado');   
    
    subplot(1,3,3);
    imshow(diff_filt);
    title('(Ruidosa-Filtrado)x3');
    
    figure(2);   
    subplot(1,3,1);   
    imshow(original);
    title('Imagen original');
    
    subplot(1,3,2);
    imshow(im2double(u));
    title('Imagen Denoise');   
    
    subplot(1,3,3);
    imshow(diff_noi);
    title('(Ruidosa-Denoise)x3');
    
    
end   