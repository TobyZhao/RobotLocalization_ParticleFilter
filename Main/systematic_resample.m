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
%     if i ~= 0
        S_X(1:3, m) = S_bar(1:3, i);
%     end   
end
S = [S_X; 1 / M * ones(1, M)];

% cdf = cumsum(S_bar(4, :));
% M = size(S_bar,2);
% S = zeros(size(S_bar));
% r_0 = rand / M;
% for m = 1 : M
%     i = find(cdf >= r_0,1,'first');
%     if i ~= 0
%         S(1:3, m) = S_bar(1:3, i);
%     end
%     r_0 = r_0 + 1/M;
% end
% S(4, :) = 1/M * ones(1, M);
% S=zeros(size(S_bar));
%     M=size(S_bar,2);
%     CDF=zeros(1,M);
%     for m=1:M
%         CDF(m)=sum(S_bar(4,1:m)); 
%     end
%     r=rand()/M;
%     for m=1:M
%         i=find(CDF>=r+(m-1)/M, 1 );
%         S(:,m)=S_bar(:,i);
%         S(4,m)=1/M;
%     end

end