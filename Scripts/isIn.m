% this function check if a point belongs to a provided set
function [ret,set] = isIn(point,set)
    ret = false;
    if(isempty(set))
        return ;
    end
    len = length(set);
    for index = 1:len-1
        if(point(1,1) == set(index,1))
            if(point(1,2) == set(index,2))
                ret = true;
                set(index,1) = -inf;
                set(index,2) = inf;
                return;
            end
        end
        
    end

end