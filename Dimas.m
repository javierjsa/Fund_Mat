function [ resultado ] = DiMas( I, hi )

if (~exist('hi', 'var'))
    hi=1;
end;

[ni, nj]=size(I);
IBi=zeros(ni+1, nj);
IBi(1:end-1, :)=I;
IBi(end,:)=IBi(end-1,:);

resultado=diff(IBi, 1, 1)./hi;
%resultado(1,:)=0; NO SE PONE, NO ENTRA DENTRO DE LAS CONDICIONES DE
%CONTORNO