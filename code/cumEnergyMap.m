function [C] = cumEnergyMap(E)
    C = zeros(size(E));
    C(1,:) = E(1,:);
    
    for i = 2:size(E,1)
        for j = 1:size(E,2)
           if j == 1
            C(i,j) = E(i,j) + min([C(i-1,j),C(i-1,j+1)]);
           elseif j < size(E,2)
            C(i,j) = E(i,j) + min([C(i-1,j-1),C(i-1,j),C(i-1,j+1)]);
           else
            C(i,j) = E(i,j) + min([C(i-1,j-1),C(i-1,j)]);
           end
        end
    end
end

