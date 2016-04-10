function [best,bestErr] = best_match(x, y, m,n,Source,IP,meanMatrix,meanPatch)
[mm nn]=size(Source);
N=nn-n+1; 
M=mm-m+1;
bestErr=1000000000.0;
best=[0 0];
x=x+4;
y=y+4;
mapping=getmapping(8,'u2'); 
  Source=double(Source);
  IP=double(IP);
  subSource=zeros(m,n);
  %��ʼ����
  for j=1:N 
    %����ͼ����ÿһ���������ڵ�9*9��
    J=j+n-1;
    for i=1:M
      I=i+m-1;
      y1=i+4;
      x1=j+4;
      if ( (pdist([x y;x1 y1],'euclidean')> 20) && ( abs(meanPatch-meanMatrix(i,j))<=2))
      %�������LBP�����ľ���   
          patchErr=0.0;%����LBP�����ľ��� 
          %���ڵ�ǰ���е�ÿһ������   
          subSource=Source(i:I,j:J);
          H1=LBP(IP,1,8,mapping,'nh'); 
          H2=LBP(subSource,1,8,mapping,'nh');
          patchErr=pdist([H1;H2],'euclidean');

      %������С����
      if (patchErr <=bestErr) 
          bestErr=patchErr;
          %��¼ƥ������Ͻ����ص�����
          best=[i j];
      end
      end
    end
  end
 


end

