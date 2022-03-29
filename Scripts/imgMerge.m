% given two images this fucntion provide to merge these two images with and
% homograpy matrix that is used for the second image warping

function [mosaic] = imgMerge(img1,img2,H)

% warping the second image

[img_wrap_mos, bb, alpha] = imwarp3(img2,inv(H), 'linear', 'valid');


% warping boundaries translation
bb_ij = zeros(1,4);
bb_ij(1)=bb(2); bb_ij(2)=bb(1); bb_ij(3)=bb(4); bb_ij(4)=bb(3);
bb_ij=bb_ij';


bb_1=[0; 0; size(img1)'];

corners=[bb_ij bb_1];


minj = min(corners(2,:));
mini = min(corners(1,:));
maxj = max(corners(4,:));
maxi = max(corners(3,:));

bb_mos=[mini; minj; maxi; maxj];

offs=[abs(mini); abs(minj)];

sz_mos = bb_mos+[offs; offs];

if(sz_mos(1)==0 && sz_mos(2)==0)
    mosaic_ref=zeros(sz_mos(3), sz_mos(4));
    mosaic_mov=mosaic_ref;
end


if((offs(1)>0) && (offs(2)>0))
% first image
mosaic_ref(offs(1):(size(img1,1)+offs(1)-1),offs(2):(size(img1,2)+offs(2)-1))=img1(:,:);
% warped image
mosaic_mov(1:(size(img_wrap_mos,1)),1:size(img_wrap_mos,2))=img_wrap_mos(:,:);
end

if ((offs(1)>0) && (offs(2)==0))
mosaic_ref(offs(1):(size(img1,1)+offs(1)-1),1:size(img1,2))=img1(:,:);
mosaic_mov(1:size(img_wrap_mos,1),(bb_ij(2)):(size(img_wrap_mos,2)+(bb_ij(2))-1))=img_wrap_mos(:,:);

end

if ((offs(1)==0) && (offs(2)>0))
mosaic_ref(1:size(img1,1),offs(2):(size(img1,2)+offs(2)-1))=img1(:,:);
mosaic_mov((bb_ij(1)):(size(img_wrap_mos,1)+(bb_ij(1))-1),1:size(img_wrap_mos,2))=img_wrap_mos(:,:);
end

if ((offs(1)==0) && (offs(2)==0))
mosaic_ref(1:size(img1,1),1:size(img1,2))=img1(:,:);
mosaic_mov((bb_ij(1)):(size(img_wrap_mos,1)+bb_ij(1)-1),(bb_ij(2)):(size(img_wrap_mos,2)+bb_ij(2)-1))=img_wrap_mos(:,:);



end

mosaic = mosaic_ref + mosaic_mov;








% merging and cropping the two images

ind=find(isnan(mosaic_ref));
mosaic_ref(ind)=0; 

ind=find(isnan(mosaic_mov));
mosaic_mov(ind)=0;

mask = uint8(mosaic_ref & mosaic_mov); % check where we have conjugate points


mosaic = mosaic_ref + mosaic_mov;




ind = find(mask > 0);

mosaic(ind) = mosaic(ind) * 0.5;



mosaic = uint8(mosaic);

%mosaic = imCut(mosaic,createMask(mosaic));









end