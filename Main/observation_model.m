% function h = observation_model(S,W,j)
% This function is the implementation of the observation model
% The bearing should lie in the interval [-pi,pi)
% Inputs:
%           S           4XM
%           W           2XN
%           j           1X1
% Outputs:  
%           h           2XM
function h = observation_model(S,W,j)
M = size(S, 2);
h1 = sqrt((W(1, j) * ones(1, M) - S(1, :)).^2 + (W(2, j) * ones(1, M) - S(2, :)).^2);
h2 = atan2(W(2, j) * ones(1, M) - S(2, :), W(1, j) * ones(1, M) - S(1, :)) - S(3, :);
h2 = mod(h2 + pi, 2 * pi) - pi;
h = [h1; h2];
end