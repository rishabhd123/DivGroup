fprintf('Modularity\n\n');
N=1000;
d=5;
grps = 4;
tic


global lambda;
global  grp_cell;
global index;
global distanceMat;
global globalDegreeVect;
index=1;

A = randn(N, d);
A(A<0) = -A(A<0);
grp_cell = cell(4,1);
lambda = 10;
distanceMat = squareform(pdist(A));
globalDegreeVect = sum(distanceMat, 2);
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

%% -------------------------------Uniform Kmeans--------------------------------------------
tic
fprintf('\n\n Uniform Kmeans\n\n');
K = N/grps;
% U_grp_cell = cell(grps, 1);
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














