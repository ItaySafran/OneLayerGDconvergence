% Check that gradients/objective values are computed correctly

clear;

W = randn(4,9);
V = randn(4,5);

Wnorms = sqrt(sum(W.^2,1));
Vnorms = sqrt(sum(V.^2,1));
Wnormalized = W./repmat(Wnorms,size(W,1),1);
Vnormalized = V./repmat(Vnorms,size(V,1),1);
AnglesWW = abs(acos(Wnormalized'*Wnormalized));
AnglesVW = abs(acos(Vnormalized'*Wnormalized));
AnglesVV = abs(acos(Vnormalized'*Vnormalized));
val = (Wnorms*(sin(AnglesWW)+(pi-AnglesWW).*cos(AnglesWW))*Wnorms'/2 ...
    - Vnorms*(sin(AnglesVW)+(pi-AnglesVW).*cos(AnglesVW))*Wnorms' ...
    + Vnorms*(sin(AnglesVV)+(pi-AnglesVV).*cos(AnglesVV))*Vnorms'/2)/(2*pi);

valt = 0;
for i=1:size(W,2)
    for j=1:size(W,2)
        valt = valt+0.5*r(W(:,i),W(:,j));
    end
end
for i=1:size(W,2)
    for j=1:size(V,2)
        valt = valt-r(W(:,i),V(:,j));
    end
end
for i=1:size(V,2)
    for j=1:size(V,2)
        valt = valt+0.5*r(V(:,i),V(:,j));
    end
end
abs(val-valt)


function res= r(u,v)
nu = norm(u);
nv = norm(v);
normprod = u'*v/(nu*nv);
res = nu*nv*((sqrt(1-normprod^2))+(pi-acos(normprod))*normprod)/(2*pi);
end


%
% i = 1;
% gtWW = zeros(size(W));
% for i=1:size(W,2)
%     for j=1:size(W,2)
%         gtWW(:,i) = gtWW(:,i) + g(W(:,i),W(:,j));
%     end
% end
% gtWV = zeros(size(W));
% for i=1:size(W,2)
%     for j=1:size(V,2)
%         gtWV(:,i) = gtWV(:,i) + g(W(:,i),V(:,j));
%     end
% end
% gradt = gtWW-gtWV;
%
%
% Wnorms = sqrt(sum(W.^2,1));
% Vnorms = sqrt(sum(V.^2,1));
% Wnormalized = W./repmat(Wnorms,size(W,1),1);
% Vnormalized = V./repmat(Vnorms,size(V,1),1);
% AnglesWW = abs(acos(Wnormalized'*Wnormalized));
% AnglesVW = abs(acos(Vnormalized'*Wnormalized));
% gWW = repmat(Wnorms*sin(AnglesWW),size(W,1),1).*Wnormalized...
%     +W*(pi-AnglesWW);
% gWV = repmat(Vnorms*sin(AnglesVW),size(W,1),1).*Wnormalized...
%     +V*(pi-AnglesVW);
% grad = gWW-gWV;
%
% norm(grad-gradt) % Should be around machine precision
%
%
%
% function r = g(u,v)
% nu = norm(u);
% nv = norm(v);
% normprod = u'*v/(nu*nv);
% r = (sqrt(1-normprod^2)*nv/nu)*u+(pi-acos(normprod))*v;
% end