function [ ] = savePlot(X,Y,title)
%SAVEPLOT Saves figure as 2 vectors
%   Saves to file named @title two vectors of data
%   into seperate columns in order to geneate vector
%   figure in LATEX
    if size(X) > size(X')
        s = size(X);
    else
        s = size(X');
    end
    
    dane = fopen(title,'wt');
    
    for i=1:s
        fprintf(dane,'%f %f\n', X(i),Y(i));
    end
    fclose(dane);
    
end

