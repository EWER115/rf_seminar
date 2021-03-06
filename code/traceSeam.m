function [T] = traceSeam(C)
    T = zeros(1,size(C,1));
    [~,idx] = min(C(end,:));
    T(end) = idx;
    for i = size(C,1)-1:-1:1
      if T(i+1) == 1
          [~,idx] = min([C(i,T(i+1)),C(i,T(i+1)+1)]);
          
          if idx == 1
              T(i) = T(i+1);
          else
              T(i) = min(size(C, 2), T(i+1)+1);
          end
          
      elseif T(i+1) < size(C,2) && T(i+1) > 1
          [~,idx] = min([C(i,T(i+1)-1),C(i,T(i+1)),C(i,T(i+1)+1)]);
          
          if idx == 1
              T(i) = max(1, T(i+1)-1);
          elseif idx == 2
              T(i) = T(i+1);
          else
              T(i) = min(size(C, 2), T(i+1)+1);
          end
          
      else
          [~,idx] = min([C(i,T(i+1)-1),C(i,T(i+1))]);
          
          if idx == 1
              T(i) = max(1, T(i+1-1));
          else
              T(i) = T(i+1);
          end
      end
    end
end

