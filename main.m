% clear;
fprintf('Modularity\n\n');
% input = load('synthetic_data.mat');
A = input.data;
N = input.N;
d = input.d;
% grps = 2^8;
tic


global lambda;
global  grp_cell;
global index;
global distanceMat;

index=1;  %Global Variable
grp_cell = cell(grps,1);
lambda = 10;
distanceMat = squareform(pdist(A));
rec_modularity(grps, 1:N, N);

fprintf('1st Metric: Students Distribution\n');
grp_size = zeros(grps,1);

for i=1:grps
    grp_size(i) = length(grp_cell{i});
end

fprintf('Variance = %f\n\n', var(grp_size));

fprintf('Diversity\n');

temp1 = 0;
for i=1:grps
    temp2 = A(grp_cell{i}, :);
    temp1 = temp1 + sum(var(temp2));    
end

fprintf('Diversity Result(Cummulative Variance) = %f\n\n', temp1);

fprintf('Uniformity\n');

mean_vect = zeros(grps, d);
for i=1:grps
    temp2 = A(grp_cell{i}, :);
    mean_vect(i, :) = mean(temp2);
end
temp1 = sum(var(mean_vect));

fprintf('Uniformity Result = %f\n\n', temp1);
fprintf('Modularity ');
toc


figure
a = A(grp_cell{1}, :);
plot(a(:,1), a(:,2), '*r');
hold on
a = A(grp_cell{2}, :);
plot(a(:,1), a(:,2), '.b');
hold on
a = A(grp_cell{3}, :);
plot(a(:,1), a(:,2), '+g');
hold on
a = A(grp_cell{4}, :);
plot(a(:,1), a(:,2), 'ok');
title('Modularity');
hold on


%% -------------------------------Uniform Kmeans--------------------------------------------
tic
fprintf('\n\n Uniform Kmeans\n\n');
K = N/grps;
[U_grp_cell, U_grp_size] = uniform_kmeans(A, K, grps);

fprintf('Variance = %f\n\n', var(U_grp_size));

fprintf('Diversity\n');

temp1 = 0;
for i=1:grps
    temp2 = A(U_grp_cell{i}, :);
    temp1 = temp1 + sum(var(temp2));    
end

fprintf('Diversity Result(Cummulative Variance) = %f\n\n', temp1);

fprintf('Uniformity\n');

mean_vect = zeros(grps, d);
for i=1:grps
    temp2 = A(U_grp_cell{i}, :);
    mean_vect(i, :) = mean(temp2);
end

temp1 = sum(var(mean_vect));

fprintf('Uniformity Result = %f\n\n', temp1);
fprintf('Uniform Kmeans ');
toc


figure
a = A(U_grp_cell{1}, :);
plot(a(:,1), a(:,2), '*r');
hold on
a = A(U_grp_cell{2}, :);
plot(a(:,1), a(:,2), '.b');
hold on
a = A(U_grp_cell{3}, :);
plot(a(:,1), a(:,2), '+g');
hold on
a = A(U_grp_cell{4}, :);
plot(a(:,1), a(:,2), 'ok');
title('Uniform K-Means');
hold on

%% -------------------------------- Random ------------------------------------
fprintf('\n\nRandom\n\n');
R_grp_cell = cell(grps, 1);

temp = randperm(N);

for i=1:grps
    R_grp_cell{i} =  temp(((i-1)*K + 1) : i*K);
end


fprintf('Variance = 0\n\n');

fprintf('Diversity\n');

temp1 = 0;
for i=1:grps
    temp2 = A(R_grp_cell{i}, :);
    temp1 = temp1 + sum(var(temp2));    
end

fprintf('Diversity Result(Cummulative Variance) = %f\n\n', temp1);

fprintf('Uniformity\n');

mean_vect = zeros(grps, d);
for i=1:grps
    temp2 = A(R_grp_cell{i}, :);
    mean_vect(i, :) = mean(temp2);
end

temp1 = sum(var(mean_vect));

fprintf('Uniformity Result = %f\n\n', temp1);
fprintf('Random took ');
toc

figure
a = A(R_grp_cell{1}, :);
plot(a(:,1), a(:,2), '*r');
hold on
a = A(R_grp_cell{2}, :);
plot(a(:,1), a(:,2), '.b');
hold on
a = A(R_grp_cell{3}, :);
plot(a(:,1), a(:,2), '+g');
hold on
a = A(R_grp_cell{4}, :);
plot(a(:,1), a(:,2), 'ok');
title('Random');
hold on

