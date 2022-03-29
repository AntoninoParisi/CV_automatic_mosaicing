function croppedImage = imCut(img,mask)
    
[R,C] = size(img);

%gamma must be choosen better

idx = find(mask == 0);

[r,c] = size(img);
gamma = size(idx);
gamma = gamma/(r*c);



h = R*gamma;
v = C*gamma;
[R,C] = size(mask);







% columns adjustment

leftC = 1;

for i = 1:C
    idx = find( mask(:,i) > 0);
    if(size(idx,1) > h)
        leftC = i;
        break;
    end
end

rightC = C;

for i = 1:C
    idx = find( mask(:,C-i+1) > 0);
    if(size(idx,1) > h)
        rightC = C-i+1;
        break;
    end
end




croppedImage = img(:, leftC:rightC);



% row adjustment
topR = 1;
for i = 1:R
    idx = find( mask(i,:) > 0);
    if(size(idx,2) > v)
        topR = i;
        break;
    end
end

bottomR = R;

for i = 1:R
    idx = find( mask(R-i+1,:) > 0);
    if(size(idx,2) > v)
        bottomR = R-i+1;
        break;
    end
end

croppedImage = croppedImage(topR:bottomR,:);


        







end