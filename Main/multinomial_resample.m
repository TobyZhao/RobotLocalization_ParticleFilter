% function S = multinomial_resample(S_bar)
% This function performs systematic re-sampling
% Inputs:   
%           S_bar(t):       4XM
% Outputs:
%           S(t):           4XM
function S = multinomial_resample(S_bar)
cdf = cumsum(S_bar(4, :));
M = size(S_bar, 2);
S_X = zeros(3, M);

for m = 1 : M
    r_m = rand;
    i = find(cdf >= r_m, 1, 'first');
    if i ~= 0
        S_X(:, m) = S_bar(1:3, i);
    end
end
S = [S_X; 1 / M * ones(1, M)];

end
