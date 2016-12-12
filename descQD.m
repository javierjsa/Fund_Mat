function descQD(A);
%Cálculo descomposicion matriz en autovalores y autovectores

[Q,D] = eig(A);

a=inv(Q)*A*Q; % D=Q'AQ 
b=Q*D*inv(Q); % A=QDQ'

resa=sum(a(:))-sum(D(:));
resb=sum(b(:))-sum(A(:));

if (resa==0 && resb==0)
    disp('descomposición verificada');
else
    disp('descomposición no verificada');




end
