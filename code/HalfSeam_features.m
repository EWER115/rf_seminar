function S=HalfSeam_features(x)
%输入X为Energy_features的第二个输入E
[rows cols]=size(x);

Mv=zeros(rows,cols);
Mh=zeros(rows,cols);
Mv(1,:)=x(1,:);
Mh(:,1)=x(:,1);
%verticalseam
for i=2:rows
    for j=1:cols
        if j-1<1
            Mv(i,j)= x(i,j)+min([Mv(i-1,j),Mv(i-1,j+1)]);
        elseif j+1>cols
            Mv(i,j)= x(i,j)+min([Mv(i-1,j-1),Mv(i-1,j)]);
        else
            Mv(i,j)= x(i,j)+min([Mv(i-1,j-1),Mv(i-1,j),Mv(i-1,j+1)]);
        end
    end
end


Mv_min1=min(Mv(round(rows/5),:));
Mv_max1=max(Mv(round(rows/5),:));
Mv_mean1=1/cols*sum(Mv(round(rows/5),:));

Mv_min2=min(Mv(round(rows*2/5),:));
Mv_max2=max(Mv(round(rows*2/5),:));
Mv_mean2=1/cols*sum(Mv(round(rows*2/5),:));

Mv_min3=min(Mv(round(rows*3/5),:));
Mv_max3=max(Mv(round(rows*3/5),:));
Mv_mean3=1/cols*sum(Mv(round(rows*3/5),:));

Mv_min4=min(Mv(round(rows*4/5),:));
Mv_max4=max(Mv(round(rows*4/5),:));
Mv_mean4=1/cols*sum(Mv(round(rows*4/5),:));


% horizontalseam
for j=2:cols
    for i=1:rows
        if i-1<1
            Mh(i,j)= x(i,j)+min([Mh(i,j-1),Mh(i+1,j-1)]);
        elseif i+1>rows
            Mh(i,j)= x(i,j)+min([Mh(i-1,j-1),Mh(i,j-1)]);
        else
            Mh(i,j)= x(i,j)+min([Mh(i-1,j-1),Mh(i,j-1),Mh(i+1,j-1)]);
        end
    end
end

Mh_min1=min(Mh(round(rows/5),:));
Mh_max1=max(Mh(round(rows/5),:));
Mh_mean1=1/cols*sum(Mh(round(rows/5),:));

Mh_min2=min(Mh(round(rows*2/5),:));
Mh_max2=max(Mh(round(rows*2/5),:));
Mh_mean2=1/cols*sum(Mh(round(rows*2/5),:));

Mh_min3=min(Mh(round(rows*3/5),:));
Mh_max3=max(Mh(round(rows*3/5),:));
Mh_mean3=1/cols*sum(Mh(round(rows*3/5),:));

Mh_min4=min(Mh(round(rows*4/5),:));
Mh_max4=max(Mh(round(rows*4/5),:));
Mh_mean4=1/cols*sum(Mh(round(rows*4/5),:));

% S=[Mv_min Mv_max Mv_mean Mv_std Mv_diff Mh_min Mh_max Mh_mean Mh_std Mh_diff Mv_min Mv_max Mv_mean];
S=[Mv_min1 Mv_min2 Mv_min3 Mv_min4 Mv_max1 Mv_max2 Mv_max3 Mv_max4 Mv_mean1 Mv_mean2 Mv_mean3 Mv_mean4...
   Mh_min1 Mh_min2 Mh_min3 Mh_min4 Mh_max1 Mh_max2 Mh_max3 Mh_max4 Mh_mean1 Mh_mean2 Mh_mean3 Mh_mean4];

end