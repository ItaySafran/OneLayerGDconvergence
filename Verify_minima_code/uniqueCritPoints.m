% Unifies all points in Wbad that are the same up to permutations with
% Frobenius norm tolerance at most maxTol. 

% Returns:
% WbadNew - the new, unified points.
% magnitude - a vector storing the number of points close to the matrix in WbadNew.
% maxFroDiff - the maximal difference between two unified matrices in each group.

function [WbadNew, magnitude, maxFroDiff] = uniqueCritPoints(Wbad, maxTol)
    maxTol = sym(maxTol);
    maxFroDiff = sym(0);
    i=1;
    while (size(Wbad,3) >= i)
        I = ones(1, size(Wbad,3));
        maxFroDiffTemp = sym(0);
        for j=(i+1):size(Wbad,3)
            maxDiff = isPermutation(Wbad(:,:,i), Wbad(:,:,j));
            if (symCompare(maxDiff,maxTol)<0)
                maxFroDiffTemp = max(maxDiff, maxFroDiffTemp);
                I(j) = 0;
            end
        end
        maxFroDiff(i) = maxFroDiffTemp;
        magnitude(i) = sum(ones(1, size(Wbad,3)) - I) + 1;
        i=i+1;
        Wbad = Wbad(:,:,logical(I));
    end
    WbadNew = Wbad;
end