%f=imread('van_gogh_bw.jpg');
%f=imread('mona_lisa.jpg');
% si l imagen es en color y quiero contaminar el bw
%f=imread('./imagenes/picassobw_red.jpg');
%f=imread('Shepp-Logan.tif');
%f=rgb2gray(f);
%f=P256;
%f=double(f);
f=imread('dali.jpg');
f=rgb2gray(f);
f=im2double(f);
fn=f+(max(f(:))*0.05*randn(size(f)));
noise=fn-f;
imwrite(fn,'nimage.jpg');
imwrite(fn,'dalir_noise_bw.jpg');
%imwrite(noise,'noise_van_gogh.jpg');
%imwrite(noise,'noise_mona_lisa.jpg');
figure
subplot(1,3,1)
imshow(f,[]),title('Original image');
subplot(1,3,2)
imshow(noise,[]),title('Contamination');
subplot(1,3,3)
imshow(fn,[]),title('Noisy image');