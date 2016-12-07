% function S_bar = weight(S_bar,Psi,outlier)
%           S_bar(t)            4XM
%           outlier             1Xn
%           Psi(t)              1XnXM
% Outputs: 
%           S_bar(t)            4XM
function S_bar = weight(S_bar,Psi,outlier)
p1 = Psi(1, find(~outlier), :);
p = prod(p1,2);
p = p/sum(p);
S_bar(4,:) = p;

end
