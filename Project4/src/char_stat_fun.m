function [ y ] = stat_val( u )
    load stat.mat
    if (u>=-1 && u<=1)
        y = Ys( int8((u+1)*50 + 1) );
    end

end

