function analisis2(A,b)
clc;
[m,n]=size(A);
rankA=rank(A);
rankAb=rank([A b]);
kernel=n-rank(A);


fprintf('=======================================================\n');
fprintf('Dimensión Imagen F: %d\n',rankA);
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

if (rankA==rankAb) && (kernel>0)
    M=A'*A;
    bm=A'*b;
    e=eig(M);
    m=min(e);
    fprintf('=======================================================\n');
    fprintf('AUTOVALOR MÍNIMO A''A: %d\n',m);
    fprintf('CONDICIONAMIENTO A''A: %d\n',rcond(M));
    fprintf('=======================================================\n\n');
    if m>1.e-3         
        x=M\bm; 
        r=(A*x)-b;
        fprintf('\nSistema compatible indeterminado\n');
        fprintf('Solución única de mínimos cuadrados A''A=A''b\n');
        ffprintf('---------------------------------------------------\n');
        fprintf('Solución del sistema:\n');
        imprimir(x);    
        fprintf('Residuo sistema inicial Ax=b:\n');
        imprimir(r);
    else
        [m,n]=size(M);
        Id=eye(n);
        C=((A'*A)+Id);
        bc=A'*b;
        xslash=C\bc;
        xpinv=pinv(A)*b;
        
        fprintf('=======================================================\n');
        fprintf('Sistema compatible indeterminado\n');
        fprintf('A''A semidefinida positiva\n');
        fprintf('=======================================================\n\n');
        fprintf('\nSolución de mínima energía (A''A+Id)x=A''b\n');
        fprintf('=======================================================\n');
        fprintf('Solución operador "\\":');
        imprimir(xslash);
        fprintf('Energía solución: %2.3E\n',norm(xslash));
        fprintf('-------------------------------------------------------\n');
        fprintf('Residuo Ax-b: ');
        imprimir((A*xslash)-b);
        fprintf('Energía resíduo Ax-b: %2.3E\n',(norm((A*xslash)-b)));
        fprintf('-------------------------------------------------------\n');
        fprintf('Residuo Cx-A''b: ');
        imprimir((A*xslash)-b);       
        fprintf('Energía resíduo Cx-A''b: %2.3E\n',(norm((C*xslash)-bc)));
        fprintf('\n=======================================================\n');
        fprintf('Solución operador pinv: ');
        imprimir(xpinv);
        fprintf('Energía solución pinv: %f\n',norm(xpinv));
        fprintf('-------------------------------------------------------\n');
        fprintf('Residuo pinv Ax-b: ');
        imprimir((A*xpinv)-b);
        fprintf('Energía resíduo pinv Ax-b: %2.3E\n',norm((A*xpinv)-b));
        fprintf('-------------------------------------------------------\n');
        fprintf('Residuo Cx-A''b: ');
        imprimir((C*xpinv)-bc);
        fprintf('Energía resíduo: %2.3E\n',norm((C*xpinv)-bc));
    end
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