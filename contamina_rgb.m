f=imread('./imagenes/cameraman.jpg');
%f=imread('monalisa.jpg');
% si l imagen es en color
%f=rgb2gray(f);
f=im2double(f);
fn=f+(max(f(:))*0.08*randn(size(f)));
noise=fn-f;
%imwrite(fn,'noisy_van_gogh_bw.jpg');
imwrite(fn,'noisycameraman.jpg');
%imwrite(noise,'noise_van_gogh.jpg');
imwrite(noise,'noisecameraman.jpg');
figure
subplot(1,3,1)
imshow(f,[]),title('Original image');
subplot(1,3,2)
imshow(noise,[]),title('Contamination');
subplot(1,3,3)
imshow(fn,[]),title('Noisy image');