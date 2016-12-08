% function S = systematic_resample(S_bar)
% This function performs systematic re-sampling
% Inputs:   
%           S_bar(t):       4XM
% Outputs:
%           S(t):           4XM
function S = systematic_resample(S_bar)
cdf = cumsum(S_bar(4, :));
M = size(S_bar, 2);
S_X = zeros(3, M);
r_0 = rand / M;

for m = 1 : M
    i = find(cdf >= r_0 + (m-1) / M, 1, 'first');     
    if i ~= 0
        S_X(1:3, m) = S_bar(1:3, i);     
    end   
end
S = [S_X; 1 / M * ones(1, M)];

end
