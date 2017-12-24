% Symbolically compares a to b
% returns 1 if a>b, 0 if a=b, and -1 if a<b
function result = symCompare(a,b)
    a = sym(a);
    b = sym(b);
    if isequal(a,b)
        result = 0;
    else
        if isequal(max(a,b),a)
            result = 1;
        else
            result = -1;
        end
    end
end