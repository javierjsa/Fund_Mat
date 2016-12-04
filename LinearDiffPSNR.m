function [data,datan]=LinearDiffPSNR(fn, lambda, dt, Nit)

datan=[1,Nit];
data=[1,Nit];
prev=fn;
prevn=fn;
fnd=double(fn);
for i=1:Nit   
    [un, diff_un]=LinearDiffusion2016(prevn, 0, dt, 1);
    prevn=un;
    un=double(un);
    valn=PSNR_V(un,fnd);  
    datan(i)=valn;
    
    [u, diff_u]=LinearDiffusion2016(prev, lambda, dt, 1);
    prev=u;
    u=double(u);
    val=PSNR_V(u,fnd);  
    data(i)=val;
    
end        
subplot(2,1,1);  
plot(data);
title('Difusion')

subplot(2,1,2); 
plot(datan);
title('Filtrado (lambda=0)');