function features = compute_features(I)
    spoints=[ -1 0; -1 1; -0 1;  1 1; 1 0;1 -1;0 -1; -1 -1];
    neighbors=8;
    mapping=0;
    mode='nh';
   
    I=rgb2gray(I);
    d=lbp(I,spoints,neighbors,mapping,mode);
    
    [c1, x]=Energy_features(d);
    c2=HalfSeam_features(x);
    c3=Seam_features(x);
    c4=Noise_features(d);
    features=[c1 c2 c3 c4];
end

