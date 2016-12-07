function insVis(original,ruidosa,lambda, dt, Nit)
%insVis(original,ruidosa,lambda, dt, Nit)
%Realiza filtrado y difusión con los paramateros indicados
%Muestra imágenes para inspección visual
    
    original=im2double(original);
    
    [un, diff_un]=LinearDiffusion2016(original, 0, dt, Nit);  
    [u, diff_u]=LinearDiffusion2016(original, lambda, dt, Nit);
    
    figure(1);   
    subplot(1,2,1);   
    imshow(original);
    title('Imagen original');
    
    subplot(1,2,2);
    imshow(im2double(un));
    title('Imagen Filtrado');   
    
    figure(2);   
    subplot(1,2,1);   
    imshow(original);
    title('Imagen original');
    
    subplot(1,2,2);
    imshow(im2double(u));
    title('Imagen Denoise');   
    
    
end   