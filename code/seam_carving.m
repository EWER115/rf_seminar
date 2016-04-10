function [Ir] = seam_carving(I, n)
    Ig = rgb2gray(I);
    [Ix, Iy] = image_derivatives(Ig,1);
    E = abs(Ix) + abs(Iy);
    
    Ir = I(:,:,1);
    Ig = I(:,:,2);
    Ib = I(:,:,3);
    
    for i=1:n
       [m,n] = size(E);
       C = cumEnergyMap(E);
       T = traceSeam(C); 
       M = true(m,n);
       M(sub2ind([m,n],1:m,T)) = false;
       
       E = E'; E = reshape(E(M'),n-1,m)';
       Ir = Ir'; Ir = reshape(Ir(M'),n-1,m)';
       Ig = Ig'; Ig = reshape(Ig(M'),n-1,m)';
       Ib = Ib'; Ib = reshape(Ib(M'),n-1,m)';
    end
    
    Ir = cat(3,Ir,Ig,Ib);
end

