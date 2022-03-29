% given two sets of point it compute the homograpy
function H = homography(points_f,points_s)

A=[];
for i=1:size(points_f,2)
   
    point=[points_s(:,i);1];
   
    prod_esterno=[0 -point(3) point(2); point(3) 0 -point(1); ...
        -point(2) point(1) 0];   
    second_img_point=[points_f(:,i);1];
    
    kro=kron(second_img_point', prod_esterno);
    A=[A; kro(1,:);kro(2,:)];
end


[u,d,v] = svd(A);

H = v(:,end);
H = reshape(H,3,3);
H=H./H(3,3);
end