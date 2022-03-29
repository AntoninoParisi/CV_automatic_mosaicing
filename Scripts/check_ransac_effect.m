% im1 is the panorama image
% im2 is the next image to stitch
function [] = check_ransac_effect(im1,im2,tresh)
    
    
    
    
    [r1,c1] = size(im1);
    [r2,c2] = size(im2);
    im2 = imresize(im2, [r1, c2]);


    [points1, desc1] = vl_sift(im1,'PeakThresh', tresh) ;
    [points2, desc2] = vl_sift(im2,'PeakThresh', tresh) ;
    [pair,~] = vl_ubcmatch(desc1,desc2);
    
    raw_pair = pair;


    data = [points1(2,pair(1,:))' points2(2,pair(2,:))']';
    
    [A,B,idx_t,q,m] = RansacPoints(data,0.05,500);
    pair = pair(:,idx_t);
    
%     figure(988)
%     subplot(211);
%     scatter(A(:,1),A(:,2),10,'*g');
%     hold on
%     scatter(B(:,1),B(:,2),10,'*r');
%     title('Y axis')
%     legend({'inliers','outliers'})
%     hold off
    
    
    data = [points1(1,pair(1,:))' points2(1,pair(2,:))']';
    [A,B,idx_t,q,m] =  RansacPoints(data,0.05,500);

    
    pair = pair(:,idx_t);
    
%     subplot(212);
%     scatter(A(:,1),A(:,2),10,'*g');
%     hold on
%     scatter(B(:,1),B(:,2),10,'*r');
%     title('X axis')
%     legend({'inliers','outliers'})
%     hold off
%     
%     hold off
%     
    pair1 = points1(1:2,pair(1,:));
    pair2 = points2(1:2,pair(2,:));
    
    
    Rpair1 = points1(1:2,raw_pair(1,:));
    Rpair2 = points2(1:2,raw_pair(2,:));
    
    
    pair2(1,:) = pair2(1,:) + c1;
    Rpair2(1,:) = Rpair2(1,:) + c1;

    
    
    n_img = uint8([im1 im2]);
    
    
  
    
    
    figure(111)
    
    
    L(1) = plot(nan, nan,'Color','green');
    hold on
    
    
    imshow(uint8(n_img))
    hold on

   
    plot([Rpair1(1,:)' Rpair2(1,:)']' , [Rpair1(2,:)' Rpair2(2,:)']','Color','red')
    hold on
    plot([pair1(1,:)' pair2(1,:)']' , [pair1(2,:)' pair2(2,:)']','Color','green')
    hold on

    L(2) = plot(nan, nan,'Color','red');
    legend(L, {'Inliers','Outliers'})
    
    hold off
    
    
end