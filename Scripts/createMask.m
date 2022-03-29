function mask = createMask(img)

    

    [r,c] = size(img);
    
    % same dimension of image
    mask = ones(r,c)*255;
    
    
    idx = find(img < 2);
    
    mask(idx) = 0;
    
    
    %finding the shape of the image
    mask = imbin(mask,10); 
    
    mask = uint8(mask);

end