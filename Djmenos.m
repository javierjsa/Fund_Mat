function [ resultado ] = DjMenos( I, hj )
if (~exist('hj', 'var'))
    hj=1;
end;

%Los bordes laterales no se tratan porque siempre son 0

[ni, nj]=size(I);
% resultado=zeros(ni, nj);
% 
% resultado(:, 2:end-1) = I(:, 1:end-2);
% 
% resultado(:, 2:end-1) = I(:, 2:end-1) - resultado(:, 2:end-1);
% resultado(:, 2:end-1) =resultado(:, 2:end-1)./hj;

IBj=zeros(ni, nj+1);
IBj(:, 2:end)=I;
IBj(:, 1)=IBj(:, 2);

resultado=diff(IBj, 1, 2)./hj;
%resultado(:, end)=0; NO SE PONE NO ENTRA DENTRO DE LAS CONDICIONES DE
%CONTORNO