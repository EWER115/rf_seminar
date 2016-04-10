function N=Noise_features(image_file)

% input_img=imread(image_file);
% gray_img=rgb2gray(input_img);
gray_img=im2double(image_file);
[rows cols]=size(gray_img);

[F,noise]=wiener2(gray_img,[5,5]);
N_img=gray_img-F;

N_mean=1/(rows*cols)*sum(sum(N_img));

bb=0;
ee=0;
ff=0;
number=1/(rows*cols);
for i=1:rows
    for j=1:cols
      bb=bb+(N_img(i,j)-N_mean)^2; 
    end
end
bb=double(bb);
N_std=sqrt(number*bb);

for i=1:rows
    for j=1:cols
       ee=ee+(1/N_std*(N_img(i,j)-N_mean)).^3;
       ff=ff+(1/N_std*(N_img(i,j)-N_mean)).^4;
    end
end
N_skewness=number*ee;
N_kurtosis=number*ff;

N=[N_mean N_std N_skewness N_kurtosis];
end