function permu = permutation(temp1,temp3)
%permu:���ɵ�����
%temp1:ԭʼ����
%temp3������������
for i = 1:5
            if(temp3(i)>0)
                permu(find(temp1 == temp3(i))) = 5-i ;
            end
            if(temp3(i) ==0)
                break;
            end
        end
        while (i<=5)
            k = find(temp1 ==0);
            k1 = size(k,2);
            for j = 1:k1
                permu(k(j)) = abs(j-1);
            end
            i = i+1;
        end
end
        