f=imread('./cameraman.png');
%f=imread('./imagenes/flores.png');
f=double(f);
fn=double(uint8(f+(max(f(:))*0.15*randn(size(f)))));
