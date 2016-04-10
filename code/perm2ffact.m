% generate The Lehmer co de 
function fc = perm2ffact(x,n)
  for k = 1:n
      xk = x(k);
      i = 0;
      for j = k+1 : n
          if (x(j) < xk)
              i = i+1;
          end
      end
      fc(k) = i;
  end
end
