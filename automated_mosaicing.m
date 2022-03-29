clc
clear all
%% Paramater settings
close all
tresh = 4;
psi = 3; % parameter for neighbourhood pixel tolerance used in FindHomography.m
iterations = 1000;
ransac_tresh = 0.01;
dir_im = dir('sample_images/big_test');

%% mosaicing

H_cell = {};

imgs = {};

names = {};

isRGB = false;


for index = 4:size(dir_im,1)
    names{index-3} = dir_im(index).name;    
end


img1 = imread(names{1});



if(size(img1,3) > 1)
    img1 = rgb2gray(img1);
    isRGB = true;
end

img1 = single(img1);





for index = 1:size(names,2)-1
    
    
    
    
    img2 = imread(names{index+1});
    
    if(size(img2,3) > 1)
        img2 = rgb2gray(img2);
    end
    
    
    img2 = single(img2);
    
    
    
    
    
    % calculating sift for each image
    
    
    
    [points1, desc1] = vl_sift(img1,'PeakThresh', tresh) ;
    [points2, desc2] = vl_sift(img2,'PeakThresh', tresh) ;

    [pair,~] = vl_ubcmatch(desc1,desc2);
    
    
    % ransac on y coords 
    data = [points1(2,pair(1,:))' points2(2,pair(2,:))']';
    [A,B,idx_t,q,m] = RansacPoints(data,ransac_tresh,500);
    
    
    pair = pair(:,idx_t);
    
    
    % ransac on x coords 

    data = [points1(1,pair(1,:))' points2(1,pair(2,:))']';
    [A,B,idx_t,q,m] =  RansacPoints(data,ransac_tresh,500);

    
    pair = pair(:,idx_t); % the 'real' conjugate points set found by Ransac

 
    % ransac for homography
    
    
    FindHomography;
    
   
    H_cell{1,index} = H; % only for rgb images
    
    
    
    if(index == 1)
        result = img1;
    end
    
    
    
    result = imgMerge(result,img2,H);
    
    
    if(size(dir_im,1) > index)
        img1 = single(result);
    end
    
    ransac_tresh = ransac_tresh + index*0.01; % i consider to increase the 
                                               % treshold in order to reduce the 
                                               % error due to the curvature
                                               % of the points in some
                                               % cases, this actually
                                               % increase the quality of
                                               % the resulting images
                                               
%     if(index == 3)
%         break
%     end
    
    figure()
    imshow(result)
    
    %check_ransac_effect(img1,img2,4);
    
end







if(isRGB)
    result = imread(names{1});
    for index = 1:size(names,2)-1
        img = imread(names{index+1});
        A = result(:,:,1);
        A = imgMerge(A,img(:,:,1),H_cell{1,index});
        
        
        B = result(:,:,2);
        B = imgMerge(B,img(:,:,2),H_cell{1,index});
        
        C = result(:,:,3);
        C = imgMerge(C,img(:,:,3),H_cell{1,index});
        
        
        [r,c] = size(A);
        [r2,c2] = size(B);
        [r3,c3] = size(C);
        
        r = min([r,r2,r3]);
        c = min([c,c2,c3]);
        
        A = A(1:r,1:c);
        B = B(1:r,1:c);
        C = C(1:r,1:c);
        
        result = zeros(r,c,3) ;
        result(:,:,1) = A;
        result(:,:,2) = B;
        result(:,:,3) = C;
    end
end

figure()
imshow(uint8(result))





%% point check

% figure(1)
% imshow(uint8(img1));
% hold on
% p1 = ginput(1);
% hold off
%
%
% p2 = H_def*[p1 1]';
% p2 = p2'./p2(end);
% figure;
% subplot(121); imshow(uint8(img1));
% subplot(122); imshow(uint8(img2));
% subplot(121); hold on; scatter(p1(1,1),p1(1,2),'*r');
% subplot(122); hold on; scatter(p2(1,1),p2(1,2),'*g');











