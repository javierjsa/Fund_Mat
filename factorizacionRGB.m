function  [L,U,P, D, S, V, Q, R]=factorizacionRGB(A)
%[P, L, U, S, V, Q, R]=factorizacion(A)
%Genera la factorizacion LU QR y SVD de una matriz
%Convierte la imagen a double y escala de grises si es
%necesario.
clc;
close all;

A=im2double(A);

[m,n,j]=size(A);

[d,s,v]=svd(A(:,:,1));

[m,n]=size(d);
D=zeros(m,n,j);
[m,n]=size(s);
S=zeros(m,n,j);
[m,n]=size(v);
V=zeros(m,n,j);

[l,u,p]=lu(A(:,:,1));

[m,n]=size(p);
P=zeros(m,n,j);
[m,n]=size(l);
L=zeros(m,n,j);
[m,n]=size(u);
U=zeros(m,n,j);

[q,r]=qr(A(:,:,1));

[m,n]=size(q);
Q=zeros(m,n,j);
[m,n]=size(r);
R=zeros(m,n,j);


for i=1:j    
    [D(:,:,i),S(:,:,i),V(:,:,i)]=svd(A(:,:,i));
    [L(:,:,i),U(:,:,i),P(:,:,i)] = lu(A(:,:,i));
    [Q(:,:,i),R(:,:,i)]=qr(A(:,:,i));
end    

recDSV=zeros(m,n,j);
recPLU=zeros(m,n,j);
recLU=zeros(m,n,j);
recQR=zeros(m,n,j);

for i=1:j
    recDSV(:,:,i)=D(:,:,i)*S(:,:,i)*V(:,:,i)';
    recPLU(:,:,i)=inv(P(:,:,i))*L(:,:,i)*U(:,:,i);
    recLU(:,:,i)=L(:,:,i)*U(:,:,i);
    recQR(:,:,i) =Q(:,:,i)*R(:,:,i);
end  

resDSV=zeros(m,n,j);
resPLU=zeros(m,n,j);
resQR=zeros(m,n,j);

for i=1:j
    resDSV(:,:,i)=A(:,:,i)-recDSV(:,:,i);
    resPLU(:,:,i)=A(:,:,i)-recPLU(:,:,i);
    resQR(:,:,i) =A(:,:,i)-recQR(:,:,i);
end  

figure(1)
%colormap('jet');
a1=subplot(2,3,1);
[m,n]=size(D);
ratio=m/n;
imshow(im2double(D));
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
imshow(im2double(V));
title(a3,'Matriz V');
pbaspect(a3,[1 ratio 1]);
set(gca,'XTick',[]);
set(gca,'YTick',[]);

a4=subplot(2,3,4);
[m,n,s]=size(recDSV);
ratio=m/n;
imagesc(recDSV);
title(a4,'D*S*V');
pbaspect(a4,[1 ratio 1]);
set(gca,'XTick',[]);
set(gca,'YTick',[]);


a5=subplot(2,3,5);
[m,n]=size(resDSV);
ratio=m/n;
imshow(im2double(resDSV));
title(a5,'A-(U*S*V)');
pbaspect(a5,[1 ratio 1]);
set(gca,'XTick',[]);
set(gca,'YTick',[]);

figure(2)

%colormap('jet');
b1=subplot(2,3,1);
[m,n]=size(P);
ratio=m/n;
imshow(im2double(P));
title(b1,'Matriz P');
pbaspect(b1,[1 ratio 1]);
set(gca,'XTick',[]);
set(gca,'YTick',[]);

b2=subplot(2,3,2);
[m,n]=size(L);
ratio=m/n;
imshow(im2double(L));
title(b2,'Matriz L');
pbaspect(b2,[1 ratio 1]);
set(gca,'XTick',[]);
set(gca,'YTick',[]);

b3=subplot(2,3,3);
[m,n]=size(U);
ratio=m/n;
imshow(im2double(U));
title(b3,'Matriz U');
pbaspect(b3,[1 ratio 1]);
set(gca,'XTick',[]);
set(gca,'YTick',[]);

b4=subplot(2,3,4);
[m,n,s]=size(recLU);
ratio=m/n;
imshow(im2double(recLU));
title(b4,'Matriz L*U');
pbaspect(b4,[1 ratio 1]);
set(gca,'XTick',[]);
set(gca,'YTick',[]);

b5=subplot(2,3,5);
[m,n,s]=size(recPLU);
ratio=m/n;
imshow(im2double(recPLU));
title(b5,'Matriz inv(P)*L*U');
pbaspect(b5,[1 ratio 1]);
set(gca,'XTick',[]);
set(gca,'YTick',[]);

b6=subplot(2,3,6);
[m,n,s]=size(resPLU);
ratio=m/n;
imshow(im2double(resPLU));
title(b6,'A-(inv(P)*L*U)');
pbaspect(b6,[1 ratio 1]);
set(gca,'XTick',[]);
set(gca,'YTick',[]);

figure (3)
%colormap('gray');
[m,n,s]=size(Q);
ratio=m/n;
c1=subplot(2,2,1);
imshow(im2double(Q));
title(c1,'Matriz Q');
pbaspect(c1,[1 ratio 1]);
set(gca,'XTick',[]);
set(gca,'YTick',[]);

c2=subplot(2,2,2);
[m,n,s]=size(R);
ratio=m/n;
imshow(im2double(R));
title(c2,'Matriz R');
pbaspect(c2,[1 ratio 1]);
set(gca,'XTick',[]);
set(gca,'YTick',[]);

c3=subplot(2,2,3);
[m,n,s]=size(recQR);
ratio=m/n;
imshow(im2double(recQR));
title(c3,'Q*R');
pbaspect(c3,[1 ratio 1]);
set(gca,'XTick',[]);
set(gca,'YTick',[]);

c4=subplot(2,2,4);
[m,n,s]=size(resQR);
ratio=m/n;
imshow(im2double(resQR));
title(c4,'A-(Q*R)');
pbaspect(c4,[1 ratio 1]);
set(gca,'XTick',[]);
set(gca,'YTick',[]);
end

