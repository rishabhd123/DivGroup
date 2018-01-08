% N = 2^10 * 5;
% d = 5;
% K = 2^8; %Number of groups
% conc_crcl = 64;
N = 2^8;
d = 2;
K = 2^3; %Number of groups
% n = N/K; % size of each group
conc_crcl = 2^2;
mn = 500;
mu = ones([1 ,d])*mn;
R = cell(conc_crcl, 1);
temp=0;

for i = 1:conc_crcl
    R{i} = zeros(2,1);
    R{i}(1) = temp + randi([8,12]);
    R{i}(2) = R{i}(1) + randi([1,2]);
    temp = R{i}(2);
end

data = zeros(N,d);
cnt1=1;
pnts_in_each = N/conc_crcl;
for i = 1:conc_crcl
    ri_1 = R{i}(1);
    ri_2 = R{i}(2);
    sig = 2*ri_2;
    cnt2 = pnts_in_each;
    while cnt2>0
        X = abs(normrnd(mu, sig, [1,d]));
        if isValid(X, ri_1, ri_2, mu)
            data(cnt1, :) = X;
            cnt1 = cnt1 + 1;
            cnt2 = cnt2 - 1;
        end
    end
end

input.data = data;
input.N = N;
input.d = d;

plot(data(:,1), data(:,2), '.r');




