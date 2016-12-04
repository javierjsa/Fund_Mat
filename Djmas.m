function [ resultado ] = DjMas( I, hj )

if (~exist('hj', 'var'))
    hj=1;
end;

[ni, nj]=size(I);
IBj=zeros(ni, nj+1);
IBj(:, 1:end-1)=I;
IBj(:, end)=IBj(:, end-1);

resultado=diff(IBj, 1, 2)./hj;
%resultado(:,1)=0; NO SE PONE NO ENTRA DENTRO DE LAS CONDICIONES DE
%CONTORNO