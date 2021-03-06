% function [S_bar] = predict(S,u,R)
% This function should perform the prediction step of MCL
% Inputs:
%           S(t-1)              4XM
%           v(t)                1X1
%           omega(t)            1X1
%           R                   3X3
%           delta_t             1X1
% Outputs:
%           S_bar(t)            4XM
function [S_bar] = predict(S,v,omega,R,delta_t)
N = size(S, 1);
M = size(S, 2);
S_bar_X = S(1:3, :) + delta_t * [v * cos(S(3, :)); v * sin(S(3,:)); repmat(omega, 1, M)];

% Diffusion, assuming an uncorrelated white Gaussian with sigma_R
S_bar_X = S_bar_X + randn(N - 1, M) .* repmat(sqrt(diag(R)), 1, M); 

% S and S_bar contains the weights in their fourth element 
S_bar = [S_bar_X; S(4, :)];

end
