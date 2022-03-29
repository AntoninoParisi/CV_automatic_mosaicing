

dir_im = dir('sample_images/casaBig/');
output_dir = 'sample_images/casaGray/';
output_name = 'casaGray';
names = {};
imgs = {};

n_imgs = {};

for index = 3:size(dir_im,1)
    names{index-2} = dir_im(index).name;    
end



for index = 1:size(names,2)
    imgs{index,1} = imread(names{index});
end

for index = 1:size(names,2)
    n_imgs{index,1} = rgb2gray(imresize(imgs{index,1},[720,1280]))';
end



for index = 1:size(names,2)
    imwrite(n_imgs{index,1},[output_dir output_name '_' num2str(index) '.png'],'png');
end
