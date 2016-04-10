function [meanMatrix] = computeMeanMatrix(hight,width,Img)
    subImg=zeros(5,5);
    sImg=zeros(3,3);
    meanMatrix=zeros(hight-4,width-4);
    err=0.0;
    for i=1:hight-4
        for j=1:width-4
            err=0.0;
            subImg=Img(i:i+4,j:j+4);
             for ii=i:i+2
                for jj=j:j+2
                     sImg=double(Img(ii:ii+2,jj:jj+2));
                     v=var(sImg(:));
                     err=1/(1+v)+err;
                 end
             end
        %meanMatrix(i,j)=mean(subImg(:));
        meanMatrix(i,j)=mean(subImg(:))+err;
        end
    end
end

