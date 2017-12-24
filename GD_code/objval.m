function val = objval(W,V)
% function val = objval(W,V)
% Given weight matrix W and target weights V, compute objective value

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
          

