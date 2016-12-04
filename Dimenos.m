function [ resultado ] = DiMenos( I, hi )
if (~exist('hi', 'var'))
    hi=1;
end;

%Los bordes superior e inferior no se tratan porque son 0

 [ni, nj]=size(I);
% resultado=zeros(ni, nj);
% 
% resultado(2:end-1, :) = I(1:end-2, :);
% 
% resultado(2:end-1, :) = I(1:end-2, :) - resultado(1:end-2, :);
% resultado(2:end-1, :) =resultado(2:end-1, :)./hi;
IBi=zeros(ni+1, nj);
IBi(2:end, :)=I;
IBi(1,:)=IBi(2,:);

resultado=diff(IBi, 1, 1)./hi;
%resultado(end,:)=0; No se pone NO ENTRA DENTRO DE LAS CONDICIONES DE
%CONTORNO