function analisis(A,b)
%analisis(A,b)
%Realiza la discusión de un sistema de ecuaciones lineas
clc;
[m,n]=size(A);
rankA=rank(A);
rankAb=rank([A b]);
kernel=n-rank(A);

M=A'*A;
bm=A'*b;
e=eig(M);
meig=min(e);
maeig=max(e);
fprintf('=======================================================\n');
fprintf('Dimensión Imagen F: %d\n',rankA);
fprintf('Rango ampliado A|b: %d\n',rank([A b]));
fprintf('Dimensión espacio de llegada: %d\n',n);
fprintf('Dimensión kernel: %d\n',kernel); 
fprintf('=======================================================\n\n');
if (rankA==rankAb) && (kernel==0)
    x=A\b;
    r=(A*x)-b;
    fprintf('=======================================================\n');
    fprintf('Rango A|b= Dim Imagen  y kernel=0\n');
    fprintf('Sistema compatible determinado\n');  
    fprintf('=======================================================\n');
    fprintf('Solución del sistema: ');
    imprimir(x); 
    fprintf('-------------------------------------------------------\n');
    fprintf('Residuo Ax-b: ');
    imprimir(r);
    
end


fprintf('=======================================================\n');
fprintf('AUTOVALOR MÍNIMO A''A: %d\n',meig);
fprintf('AUTOVALOR MÁXIMO A''A: %d\n',maeig);
fprintf('CONDICIONAMIENTO A''A: %d\n',maeig/meig);
fprintf('=======================================================\n\n');
if rankA==rankAb && kernel>0
    fprintf('=======================================================\n');
    fprintf('Sistema compatible indeterminado\n');
    if meig>1.e-3         
        x=M\bm; 
        r=(A*x)-b;        
        fprintf('Solución única de mínimos cuadrados A''A=A''b\n');
        ffprintf('---------------------------------------------------\n');
        fprintf('Solución del sistema:\n');
        imprimir(x);    
        fprintf('Residuo sistema inicial Ax=b:\n');
        imprimir(r);
        ffprintf('---------------------------------------------------\n');
        op_pinv(A,b);
    else        
        fprintf('A''A semidefinida positiva\n');
        fprintf('=======================================================\n\n');
        fprintf('\nSolución de mínima energía (A''A+Id)x=A''b\n');        
        op_pinv(A,b);        
        fprintf('Solución con operador "\\" de (A''A+Id)x=A''b\n');
        op_back(M,bm);
    end    
end
    
if (rankA<rankAb)        
        fprintf('=======================================================\n');
        fprintf('Sistema incompatible\n');    
        fprintf('\nSolución de mínima energía (A''A+Id)x=A''b\n');
        fprintf('=======================================================\n');    
        op_pinv(A,b);   
       
end
end

function imprimir (x)
 fprintf('[ ');
 for i=1:length(x)
     fprintf('%2.3E ',x(i));
 end
 fprintf(']');
 fprintf('\n');
end 

function op_pinv(A,b)
 xpinv=pinv(A)*b;
 fprintf('Solución operador pinv: ');
 imprimir(xpinv);
 fprintf('Energía solución pinv: %f\n',norm(xpinv));
 fprintf('-------------------------------------------------------\n');
 fprintf('Residuo pinv Ax-b: ');
 imprimir((A*xpinv)-b);
 fprintf('Energía resíduo pinv Ax-b: %2.3E\n',norm((A*xpinv)-b));
 fprintf('-------------------------------------------------------\n')
end 

function op_back(M,bm)
 [a,b]=size(M);
 M=M+eye(a);
 x=M\bm;
 imprimir(x);
end