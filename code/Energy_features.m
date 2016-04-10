function [E Emap]=Energy_features(image_file)
%EÎª»Ò¶ÈÍ¼
% input_img=imread(image_file);
% input_img=imread('1.jpg');
% gray_img= double(rgb2gray(input_img));
input_img=im2double(image_file);
[rows cols dim]=size(input_img);
%sobel operator used to calculate gradient image
Grd=[ -1 -2 -1;
       0  0  0;
       1  2  1];
for i=1:dim
    Eh(:,:,i)=conv2(input_img(:,:,i),Grd,'same');
    Ev(:,:,i)=conv2(input_img(:,:,i),Grd.','same');
    E(:,:,i)=abs(Eh(:,:,i))+abs(Ev(:,:,i));
    Ed(:,:,i)=abs(Eh(:,:,i))-abs(Ev(:,:,i));
%     E(:,:,i)=conv2(X(:,:,i),Grd1,'same');
end
  %finds average gradient image if RGB image
Emap=1/dim*sum(E,3); 

Ecolumn=1/(rows*cols)*sum(sum(1/dim*sum(abs(Eh),3)));
Erow=1/(rows*cols)*sum(sum(1/dim*sum(abs(Ev),3)));
Emean=1/(rows*cols)*sum(sum(1/dim*sum(abs(E),3))); 
Ediff=1/(rows*cols)*sum(sum(1/dim*sum(abs(Ed),3)));

E=[Ecolumn Erow Emean Ediff];

end