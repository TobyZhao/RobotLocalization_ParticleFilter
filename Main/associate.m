% function [outlier,Psi] = associate(S_bar,z,W,Lambda_psi,Q)
%           S_bar(t)            4XM
%           z(t)                2Xn
%           W                   2XN
%           Lambda_psi          1X1
%           Q                   2X2
% Outputs: 
%           outlier             1Xn
%           Psi(t)              1XnXM
%BE SURE THAT YOUR innovation 'nu' has its second component in [-pi, pi]
function [outlier,Psi] = associate(S_bar,z,W,Lambda_psi,Q)
n = size(z, 2);
N = size(W, 2);
M = size(S_bar, 2);

Psi_0 = zeros(n, N, M);
Psi = zeros(1, n, M);
outlier = zeros(1, n);
z_hat = zeros(2, M, N);

for k = 1 : N
    z_hat(:, :, k) = observation_model(S_bar, W, k);
end

norm = (2 * pi * sqrt(det(Q)))^(-1);
Q_diag = diag(inv(Q));
Q_diag = repmat(Q_diag, 1, N, M);
z_hat = permute(z_hat, [1, 3, 2]);

for i = 1 : n
    nu(1, :, :) = z(1, i) - z_hat(1, :, :);
    nu(2, :, :) = z(2, i) - z_hat(2, :, :);
    nu(2, :, :) = mod(nu(2, :, :) + pi, 2 * pi) - pi;
    Psi(1, i, :) = max(norm * exp(sum(-0.5 .* nu .* Q_diag .* nu, 1)));
end

outlier = (mean(reshape(Psi, n, M), 2) <= Lambda_psi);
    
% time-consuming loops
% for i = 1 : n
%     for m = 1 : M
%         for k = 1 : N 
%             z_hat = observation_model(S_bar, W, k);
%             nu = z(:, i) - z_hat(:, m);
%             nu(2) = mod(nu(2) + pi, 2 * pi) - pi;
%             psi = 1 / (2 * pi * sqrt(det(Q))) * exp(-0.5 * nu' * inv(Q) * nu);
%             Psi_0(i, k, m) = psi;
%         end
%         c = find(Psi_0(i, :, m) == max(Psi_0(i, :, m)));
%         Psi(1, i, m) = Psi_0(i, c(1), m);
%     end
%     outlier(i) = (mean(Psi(1,i,:)) <= Lambda_psi);
% end

end
