function [img_out_disp] = gabor(in , lam , the)
lambda  = lam;
theta   =  0  ;
psi     = [0 pi/2];
gamma   = 0.5;
bw      = 1;
N       = 8;
img_in = im2double(in); 
img_in(:,:,2:3) = [];

img_out = zeros(size(img_in,1), size(img_in,2), the );

for n=1:the 
    gb = gabor_fn(bw,gamma,psi(1),lambda,theta)...
        + 1i * gabor_fn(bw,gamma,psi(2),lambda,theta);
    img_out(:,:,n ) = imfilter(img_in, gb, 'symmetric');
    theta = theta + 2*pi/N;
end
img_out_disp = sum(abs(img_out).^2, 3).^0.5;
img_out_disp = img_out_disp./max(img_out_disp(:));