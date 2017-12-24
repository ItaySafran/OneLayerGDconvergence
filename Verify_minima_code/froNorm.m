% Upper bounds the Frobenius norm of the input matrix A 
function result = froNorm(A)
    A = double(A);
    A = A + eps(A);
    result = double(sum(sum(sym(A).^2))^0.5);
    result = result + eps(result);
    result = sym(result);
end