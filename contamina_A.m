f=imread('./imagenes/cameraman.jpg');
%f=imread('./imagenes/flores.jpg');
f=double(f);
fn=double(uint8(f+(max(f(:))*0.15*randn(size(f)))));
