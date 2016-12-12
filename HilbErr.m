function HilbErr()
%Cálculo error relativo autovalores
warning('off','all');cwarning('off','all')
clc;
close all;

error=0;
i=1;

while error<1000;  
    disp(i);
    a=hilb(i);
    r=inv(a)*a;    
    eigr=eig(r);
    uno=ones(i,1);
    num=norm(uno-eigr);
    den=norm(eigr);
    error=(num/den)*100;        
    i=i+1;
end    
fprintf('n: %d -Autovalor:%.3d Error relativo:%.3f\n',i,eigr(i),error);        
end

