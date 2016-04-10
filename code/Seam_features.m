function S=Seam_features(x)
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
Mv_min=min(Mv(rows,:));
Mv_max=max(Mv(rows,:));
Mv_mean=1/cols*sum(Mv(rows,:));
if  mod(rows,2)==0
Mv_min1=min(Mv(rows/2,:));
Mv_max1=max(Mv(rows/2,:));
Mv_mean1=1/cols*sum(Mv(rows/2,:));
else
Mv_min1=min(Mv((rows+1)/2,:));
Mv_max1=max(Mv((rows+1)/2,:));
Mv_mean1=1/cols*sum(Mv((rows+1)/2,:));
end

cc=0;
for j=1:cols  
    cc=cc+(Mv_mean-Mv(rows,j))^2;    
end
Mv_std=(1/cols*cc)^(1/2);
Mv_diff=Mv_max-Mv_min;
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
Mh_min=min(Mh(:,cols));
Mh_max=max(Mh(:,cols));
Mh_mean=1/rows*sum(Mh(:,cols));
if  mod(cols,2)==0
Mh_min1=min(Mh(:,cols/2));
Mh_max1=max(Mh(:,cols/2));
Mh_mean1=1/rows*sum(Mh(:,cols/2));
else
Mh_min1=min(Mh(:,(cols+1)/2));
Mh_max1=max(Mh(:,(cols+1)/2));
Mh_mean1=1/rows*sum(Mh(:,(cols+1)/2));   
end

dd=0;
for i=1:rows  
    dd=dd+(Mh_mean-Mh(i,cols))^2;    
end
Mh_std=(1/rows*dd)^(1/2);
Mh_diff=Mh_max-Mh_min;


% S=[Mv_min Mv_max Mv_mean Mv_std Mv_diff Mh_min Mh_max Mh_mean Mh_std Mh_diff Mv_min Mv_max Mv_mean];
S=[Mv_min Mv_max Mv_mean Mv_std Mv_diff Mh_min Mh_max Mh_mean Mh_std Mh_diff ...
    Mv_min1 Mv_max1 Mv_mean1 Mh_min1 Mh_max1 Mh_mean1];

end