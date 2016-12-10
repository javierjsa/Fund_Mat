function  [L,U,P, D, S, V, Q, R]=factorizacion(A)
%[P, L, U, S, V, Q, R]=factorizacion(A)
%Genera la factorizacion LU QR y SVD de una matriz
%Convierte la imagen a double y escala de grises si es
%necesario.


if (isa(A,'uint8'))
    A=im2double(A);
end

dim=size(A);

if length(dim)==3
    A=rgb2gray(A);
end

[D,S,V]=svd(A);
[L,U,P] = lu(A);
[Q,R]=qr(A);

figure(1)
colormap('jet');
a1=subplot(2,3,1);
imagesc(D);
title(a1,'Matriz U');
pbaspect(a1,[1 1 1]);
a2=subplot(2,3,2);
imshow(im2double(S));
title(a2,'Matriz S');
pbaspect(a2,[1 1 1]);
a3=subplot(2,3,3);
imagesc(V);
title(a3,'Matriz V');
pbaspect(a3,[1 1 1]);

a4=subplot(2,3,4);
imagesc(D*S*V');
title(a4,'D*S*V');
pbaspect(a4,[1 1 1]);

a5=subplot(2,3,5);
imagesc(A-(D*S*V'));
title(a5,'A-(U*S*V)');
pbaspect(a5,[1 1 1]);

figure(2)

colormap('gray');
b1=subplot(2,3,1);
imagesc(P);
title(b1,'Matriz P');
pbaspect(b1,[1 1 1]);
b2=subplot(2,3,2);
imagesc(L);
title(b2,'Matriz L');
pbaspect(b2,[1 1 1]);
b3=subplot(2,3,3);
imagesc(U);
title(b3,'Matriz U');
pbaspect(b3,[1 1 1]);

b4=subplot(2,3,4);
imagesc(L*U);
title(b4,'Matriz L*U');
pbaspect(b4,[1 1 1]);

b5=subplot(2,3,5);
imagesc(inv(P)*L*U);
title(b5,'Matriz inv(P)*L*U');
pbaspect(b5,[1 1 1]);

b6=subplot(2,3,6);
imagesc(A-inv(P)*L*U);
title(b6,'A-(inv(P)*L*U)');
pbaspect(b6,[1 1 1]);

figure (3)
colormap('gray');
c1=subplot(2,2,1);
imagesc(Q);
title(c1,'Matriz Q');
pbaspect(c1,[1 1 1]);

c2=subplot(2,2,2);
imagesc(R);
title(c2,'Matriz R');
pbaspect(c2,[1 1 1]);

c3=subplot(2,2,3);
imagesc(Q*R);
title(c3,'Q*R');
pbaspect(c3,[1 1 1]);

c4=subplot(2,2,4);
imagesc(A-(Q*R));
title(c4,'A-(Q*R)');
pbaspect(c4,[1 1 1]);





end

