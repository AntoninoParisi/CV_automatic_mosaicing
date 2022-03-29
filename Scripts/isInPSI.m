% this function check if a point belongs to a provided set whit a
% confidence range
function [ret,set] = isInPSI(point,set,pixels,index)
    ret = false;
    if(isempty(set))
        return ;
    end
%     len = length(set);
%     for index = 1:len
        if(abs(point(1,1) - set(index,1)) < pixels)
            if(abs(point(1,2) - set(index,2)) < pixels)
                ret = true;
                set(index,1) = -inf;
                set(index,2) = inf;
                return;
            end
        end
        
%     end

end