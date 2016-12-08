function analisis(A,b)
%analisis( A,b )
%Realiza la discusión de un sistema
%La dimensión de Im( A ) es r, rango de A . Si r=min(n,m) el sistema tiene 
%solución para todo b . Si r<min(n.m) sólo existe solución si b ∈Im( A ).
%Warning
clc;
[m,n]=size(A);

rank_A=rank(A);
rank_Ab=rank([A b]);



if (rank_A ~= rank_Ab)
  comp=0;  
  str='Rango A distinto de Rango Ab. Sistema incompatible.';
  else if (rank_A <m && rank_A<n)
        comp=2;      
        str='Hay vectores linealmente dependientes';
       else
        str='Rango A = Rango A|b. Sistema compatible.';
        comp=1;
       end
end

fprintf('Dimensión imagen de A: %i.\n',rank_A);
fprintf('Rango matriz ampliada: %i.\n',rank_Ab);
fprintf('%s\n',str);
if comp==1 || comp==2
    if n>rank_A
        fprintf('Dimension del kernel: %i.\n',(n-rank_A));
        fprintf('-------------------------------\n');
        fprintf('No hay solución única.\n');
        %Cálculo pinv
        x=pinv(A)*b;
        fprintf('-------------------------------\n');
        fprintf('\nSolución pinv(A)*b:\n');
        imprimir(x);
        fprintf('Resíduo:\n');
        res=b-(A*x);
        imprimir(res);
        disp(norm(res));
        %Cálculo backlash
        if comp ~=2
            xb=A\b;
            fprintf('\nSolución A\\b:\n');
            imprimir(xb);
            fprintf('Resíduo:\n');
            resb=b-(A*xb);
            imprimir(resb);
            disp(norm(resb));
        end
        
    else
        fprintf('Dimension del kernel: %i\n',(n-rank_A));
        fprintf('-------------------------------\n');
        fprintf('Solución única\n');
        x=A\b;
        fprintf('-------------------------------\n');
        fprintf('\nSolución A\\b:');
        imprimir(x);
        fprintf('\nResíduo:');
        res=(A*x)-b;
        imprimir(res);
        disp(norm(res));
    end    
end

end

function imprimir (x)
 for i=1:length(x)
     fprintf('%d\t',x(i));
 end
 fprintf('\n');
end 