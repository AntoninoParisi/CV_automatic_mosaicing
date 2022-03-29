function [realInliers, realOutliers, realIDX,realQ,realM] = RansacPoints(points,eps,iterations)




data1 =  points(1,:);
data2 = points(2,:);

maxA = max(data1);
maxB = max(data2);


data1 = data1./maxA;

data2 = data2./maxB;

points = [data1' data2']';

maxInl = 0;
realQ = 0;
realM = 0;
realInliers = [];
points = points';
realOutliers = [];
realIDX = [];
while iterations  > 0
    inliers = 0;
    outliers = 0;
    pts = ceil(rand(1,2)*size(points,1));
    maybeInliers = points(pts(:),:);
    idx_t = [];
    
    m =  (maybeInliers(1,2)-maybeInliers(2,2)) / ( maybeInliers(1,1)-maybeInliers(2,1) ) ;
    q =  maybeInliers(1,2) - m*maybeInliers(1,1);
    
    
    
    setInliers = [];
    setOutliers = [];
    
    


    
    
    
    % error
    for idx = 1:size(points,1)
        
        tmpy = points(idx,1)*m + q;
        
        dist = abs(points(idx,2) - tmpy)/sqrt(1+m^2); 
        
        if (dist < eps )
            inliers = inliers +1;
            setInliers(inliers,:) = points(idx,:);
            idx_t(inliers) = idx;
        else
            outliers = outliers+1;
            setOutliers(outliers,:) = points(idx,:);
        end
        
        
    end
    
    
    if(maxInl < inliers)
        maxInl = inliers;
        realQ = q;
        realM = m;
        realInliers = setInliers;
        realOutliers = setOutliers;
        realIDX = idx_t;
    end
    iterations = iterations - 1;
end
    



end