% clear;
fprintf('Modularity\n\n');
% input = load('synthetic_data.mat');
% struct "input" will be generated by the "data_generator.m" file
% or it can be loaded from the disk(i.e previously saved synthetic data)
% input = load('synthetic_data_8192_5_128.mat');
% A = input.data;
% N = input.N;
% d = input.d;
% K = 2^9; %Number of Groups

A = csvread('../../Dataset/jammu_data_preprocessed_1.csv');
A = A(1:10240, :);
N = size(A,1);
d = size(A,2);
K = 2^9;

tic
fprintf('Computing Distance Matrix\n')
distanceMat = squareform(pdist(A));
fprintf('Distance Matrix computed\n\n')
% lamb = [5,7,10,13,15,17,20,25];
lamb = [5,7,10,13];
l = length(lamb);

diver_met_vect = zeros(l,1);
variance_met_vect = zeros(l,1);
uniformity_met_vect = zeros(l,1);
k=1;
for lambda=lamb
    
    fprintf('Lambda: %d\n', lambda)
    [grp_cell, grp_size] = spectral_modularity(K, lambda, distanceMat);
    fprintf('-------------SCORES------------------')
    fprintf('1st Metric: Students Distribution\n');
    
    temp1 = var(grp_size);
    variance_met_vect(k) = temp1;
    fprintf('Variance = %f\n\n', temp1);
    
    fprintf('Diversity\n');

    temp1 = 0;
    for i=1:K
        temp2 = A(grp_cell{i}, :);
        temp1 = temp1 + sum(var(temp2));    
    end
    diver_met_vect(k) = temp1;
    fprintf('Diversity Result(Cummulative Variance) = %f\n\n', temp1);

    fprintf('Uniformity\n');

    mean_vect = zeros(K, d);
    for i=1:K
        temp2 = A(grp_cell{i}, :);
        mean_vect(i, :) = mean(temp2);
    end
    
    temp1 = sum(var(mean_vect));
    uniformity_met_vect(k) = temp1;
    fprintf('Uniformity Result = %f\n\n', temp1);
    fprintf('Modularity ');
    toc
    
    k = k+1;

    % figure
    % a = A(grp_cell{1}, :);
    % plot(a(:,1), a(:,2), '*r');
    % hold on
    % a = A(grp_cell{2}, :);
    % plot(a(:,1), a(:,2), '.b');
    % hold on
    % a = A(grp_cell{3}, :);
    % plot(a(:,1), a(:,2), '+g');
    % hold on
    % a = A(grp_cell{4}, :);
    % plot(a(:,1), a(:,2), 'ok');
    % title('Modularity');
    % hold on
    fprintf('-------------------------------------\n')

end

figure
plot(lamb, variance_met_vect, '--*r')
title('variance')
xlabel('lambda')
ylabel('Variance(lower is better)')

figure
plot(lamb, diver_met_vect, '--+b')
title('Diversity')
xlabel('lambda')
ylabel('Diversity(Higher is better)')

figure
plot(lamb, uniformity_met_vect, '--ok')
title('Uniformity')
xlabel('lambda')
ylabel('Uniformity(Lower is better)')


%% -------------------------------Uniform Kmeans--------------------------------------------

tic
fprintf('\n\n Uniform Kmeans\n\n');
Kmns = floor(N/K);
[U_grp_cell, U_grp_size] = uniform_kmeans(A, Kmns, K);

fprintf('Variance = %f\n\n', var(U_grp_size));

fprintf('Diversity\n');

temp1 = 0;
for i=1:K
    temp2 = A(U_grp_cell{i}, :);
    temp1 = temp1 + sum(var(temp2));    
end

fprintf('Diversity Result(Cummulative Variance) = %f\n\n', temp1);

fprintf('Uniformity\n');

mean_vect = zeros(K, d);
for i=1:K
    temp2 = A(U_grp_cell{i}, :);
    mean_vect(i, :) = mean(temp2);
end

temp1 = sum(var(mean_vect));

fprintf('Uniformity Result = %f\n\n', temp1);
fprintf('Uniform Kmeans ');
toc


% figure
% a = A(U_grp_cell{1}, :);
% plot(a(:,1), a(:,2), '*r');
% hold on
% a = A(U_grp_cell{2}, :);
% plot(a(:,1), a(:,2), '.b');
% hold on
% a = A(U_grp_cell{3}, :);
% plot(a(:,1), a(:,2), '+g');
% hold on
% a = A(U_grp_cell{4}, :);
% plot(a(:,1), a(:,2), 'ok');
% title('Uniform K-Means');
% hold on

%% -------------------------------- Random ------------------------------------
fprintf('\n\nRandom\n\n');
R_grp_cell = cell(K, 1);
R_grp_size = ones(K, 1);
% temp = randperm(N);

for i=1:N
    temp = randi(K);
    R_grp_cell{temp}(R_grp_size(temp)) = i;
    R_grp_size(temp) = R_grp_size(temp) + 1;
end

fprintf('Variance = %f\n\n', var(R_grp_size));

fprintf('Diversity\n');

temp1 = 0;
for i=1:K
    temp2 = A(R_grp_cell{i}, :);
    temp1 = temp1 + sum(var(temp2));    
end

fprintf('Diversity Result(Cummulative Variance) = %f\n\n', temp1);

fprintf('Uniformity\n');

mean_vect = zeros(K, d);
for i=1:K
    temp2 = A(R_grp_cell{i}, :);
    mean_vect(i, :) = mean(temp2);
end

temp1 = sum(var(mean_vect));

fprintf('Uniformity Result = %f\n\n', temp1);
fprintf('Random took ');
toc

% figure
% a = A(R_grp_cell{1}, :);
% plot(a(:,1), a(:,2), '*r');
% hold on
% a = A(R_grp_cell{2}, :);
% plot(a(:,1), a(:,2), '.b');
% hold on
% a = A(R_grp_cell{3}, :);
% plot(a(:,1), a(:,2), '+g');
% hold on
% a = A(R_grp_cell{4}, :);
% plot(a(:,1), a(:,2), 'ok');
% title('Random');
% hold on

