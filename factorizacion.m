function  [L,U,P, D, S, V, Q, R]=factorizacion(A)
%[P, L, U, S, V, Q, R]=factorizacion(A)
%Genera la factorizacion LU QR y SVD de una matriz
%Convierte la imagen a double y escala de grises si es
%necesario.

clc;
close all;

if (isa(A,'uint8'))
    A=im2double(A);
end

dim=size(A);

if length(dim)==3
    A=rgb2gray(A);
end

[m,n]=size(A);
ratio=m/n;

[D,S,V]=svd(A);
[L,U,P] = lu(A);
[Q,R]=qr(A);

figure(1)
[m,n]=size(D);
ratio=m/n;
colormap('jet');
a1=subplot(2,3,1);
imagesc(D);
title(a1,'Matriz U');
pbaspect(a1,[1 ratio 1]);
set(gca,'XTick',[]);
set(gca,'YTick',[]);

a2=subplot(2,3,2);
[m,n]=size(S);
ratio=m/n;
imshow(im2double(S));
title(a2,'Matriz S');
pbaspect(a2,[1 ratio 1]);
set(gca,'XTick',[]);
set(gca,'YTick',[]);

a3=subplot(2,3,3);
[m,n]=size(V);
ratio=m/n;
imagesc(V);
title(a3,'Matriz V');
pbaspect(a3,[1 ratio 1]);
set(gca,'XTick',[]);
set(gca,'YTick',[]);

a4=subplot(2,3,4);
[m,n]=size(D*S*V');
ratio=m/n;
imagesc(D*S*V');
title(a4,'D*S*V');
pbaspect(a4,[1 ratio 1]);
set(gca,'XTick',[]);
set(gca,'YTick',[]);

a5=subplot(2,3,5);
[m,n]=size(A-(D*S*V'));
ratio=m/n;
imagesc(A-(D*S*V'));
title(a5,'A-(U*S*V)');
pbaspect(a5,[1 ratio 1]);
set(gca,'XTick',[]);
set(gca,'YTick',[]);

figure(2)

colormap('gray');
[m,n]=size(P);
ratio=m/n;
b1=subplot(2,3,1);
imagesc(P);
title(b1,'Matriz P');
pbaspect(b1,[1 ratio 1]);
set(gca,'XTick',[]);
set(gca,'YTick',[]);

b2=subplot(2,3,2);
[m,n]=size(L);
ratio=m/n;
imagesc(L);
title(b2,'Matriz L');
pbaspect(b2,[1 ratio 1]);
set(gca,'XTick',[]);
set(gca,'YTick',[]);


b3=subplot(2,3,3);
[m,n]=size(U);
ratio=m/n;
imagesc(U);
title(b3,'Matriz U');
pbaspect(b3,[1 ratio 1]);
set(gca,'XTick',[]);
set(gca,'YTick',[]);

b4=subplot(2,3,4);
[m,n]=size(L*U);
ratio=m/n;
imagesc(L*U);
title(b4,'Matriz L*U');
pbaspect(b4,[1 ratio 1]);
set(gca,'XTick',[]);
set(gca,'YTick',[]);

b5=subplot(2,3,5);
[m,n]=size(inv(P)*L*U);
ratio=m/n;
imagesc(inv(P)*L*U);
title(b5,'Matriz inv(P)*L*U');
pbaspect(b5,[1 ratio 1]);
set(gca,'XTick',[]);
set(gca,'YTick',[]);

b6=subplot(2,3,6);
[m,n]=size(A-inv(P)*L*U);
ratio=m/n;
imagesc(A-inv(P)*L*U);
title(b6,'A-(inv(P)*L*U)');
pbaspect(b6,[1 ratio 1]);
set(gca,'XTick',[]);
set(gca,'YTick',[]);

figure (3)
[m,n]=size(Q);
ratio=m/n;
colormap('gray');
c1=subplot(2,2,1);
imagesc(Q);
title(c1,'Matriz Q');
pbaspect(c1,[1 ratio 1]);
set(gca,'XTick',[]);
set(gca,'YTick',[]);

c2=subplot(2,2,2);
[m,n]=size(R);
ratio=m/n;
imagesc(R);
title(c2,'Matriz R');
pbaspect(c2,[1 ratio 1]);
set(gca,'XTick',[]);
set(gca,'YTick',[]);

c3=subplot(2,2,3);
[m,n]=size(Q*R);
ratio=m/n;
imagesc(Q*R);
title(c3,'Q*R');
pbaspect(c3,[1 ratio 1]);
set(gca,'XTick',[]);
set(gca,'YTick',[]);

c4=subplot(2,2,4);
[m,n]=size(A-(Q*R));
ratio=m/n;
imagesc(A-(Q*R));
title(c4,'A-(Q*R)');
pbaspect(c4,[1 ratio 1]);
set(gca,'XTick',[]);
set(gca,'YTick',[]);





end

