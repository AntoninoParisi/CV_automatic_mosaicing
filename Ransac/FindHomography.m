%% starting variables

len = length(pair);


outliers_min =inf;
H_def = [];

warning('off','all')
% points1 = points1';
% points2 = points2';

%% homography computation by trial
% conto il numero di inliers e outliers semplicemente scorrendo tutti i
% punti trovati dalla sift e verificando che siano presenti nel secondo
% set - è possibile impostare una tolleranza di n pixel nel file
% 'automated_mosaicing.m'

% calcolo omografia migliore



k_points = points2(1:2,pair(2,:)); % set points used to check the best hom.
                                   % for a random point set

for R_index = 1:iterations
    

    
    a = ceil(rand*len);
    b = ceil(rand*len);
    c = ceil(rand*len);
    d = ceil(rand*len);    
    
    p1 = [ points1(1:2,pair(1,a))'
        points1(1:2,pair(1,b))'
        points1(1:2,pair(1,c))'
        points1(1:2,pair(1,d))'
       ];
    p2 = [ points2(1:2,pair(2,a))'
        points2(1:2,pair(2,b))'
        points2(1:2,pair(2,c))'
        points2(1:2,pair(2,d))'
        ];
    H = homography(p1',p2');
    tmp = 0;
    
    % counting outliers
    for count = 1:len
        
        p1 = points1(1:2,pair(1,count));
        
        p1 = [p1(1:2)' 1]';
        p2 = H * p1;
        p2 = p2./p2(end);
        
        p2 = ceil(p2);
        
        [r,k_points] = isInPSI(p2',k_points',psi,count);
        k_points=k_points'; % points2 for the wrong solution
        if(~r)
            tmp = tmp + 1;
        end

    end
    
    % scelgo l'omografia con meno outliers
    if (tmp < outliers_min)
        H_def = H;
        outliers_min = tmp;
        outliers = k_points;
    end
    clc
    disp('outliers: ')
    disp(outliers_min)
    disp('iteration : ')
    disp(strcat(num2str(R_index/iterations*100),'%'))
    
    if (outliers_min == 0)
        break;
    end
   
    tmp = 0;
    r = [];
    k_points = points2(1:2,pair(2,:));
    
end
H = H_def;




