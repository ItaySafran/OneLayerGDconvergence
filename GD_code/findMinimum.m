function [W] = findMinimum(W,V,stepsize,gradnorm_target)
% function [W] = findMinimum(W,V,stepsize,gradnorm_target)
% Given a target network x->\sum_i max(0,V(:,i)'x), initial W, stepsize and
% target maximal gradient norm (across W_i's), run gradience descent w.r.t. squared loss

stepsize = stepsize/(2*pi); % in calculations below, compute gradient times (2*pi), so fold this into step size.
gradnorm = inf;

Winit = W;

while (gradnorm>gradnorm_target)
    Wnorms = sqrt(sum(W.^2,1));
    Vnorms = sqrt(sum(V.^2,1));
    Wnormalized = W./repmat(Wnorms,size(W,1),1);
    Vnormalized = V./repmat(Vnorms,size(V,1),1);
    AnglesWW = abs(acos(Wnormalized'*Wnormalized));
    AnglesVW = abs(acos(Vnormalized'*Wnormalized));
    gWW = repmat(Wnorms*sin(AnglesWW),size(W,1),1).*Wnormalized...
        +W*(pi-AnglesWW);
    gWV = repmat(Vnorms*sin(AnglesVW),size(W,1),1).*Wnormalized...
        +V*(pi-AnglesVW);
    Grad = gWW-gWV;
    W = W-stepsize*Grad;
    gradnorm = sqrt(max(sum(Grad.^2,1)));
    if gradnorm > 10^4 % Divergence
        W = Winit;
        fprintf('Divergence, restarting and reducing step size to %f\n',stepsize*(2*pi)/2);
        stepsize = stepsize/2;
    end
end
