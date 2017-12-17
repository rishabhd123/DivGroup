
N=10;
d=5;
grps = 2;
A = randn(N, d);
A(A<0) = -A(A<0);

D = squareform(pdist(A));               % Computing Euclidean Distance for each pair

degree_vect = sum(D,2);                 % k_i: degree of vertex
degree_mat = degree_vect * degree_vect'; % Contains pairwise product of degree k_i and k_j
m = sum(sum(D))/2;                      % Total Number of edges

lambda = 5;

Mat = D - degree_mat/(2*m) - lambda*ones(N);
[Evec, Evl] = eig(Mat);

eig_vec = Evec(:,N);

grp_1 = find(eig_vec>=0);
grp_2 = find(eig_vec<0);

size_1 = length(grp_1);
size_2 = length(grp_2);

fprintf('group-1 size: %d\n',size_1)
fprintf('group-2 size: %d\n',size_2)
fprintf('var(#student): %f\n', var([size_1, size_2]));
fprintf('Uniformity\n')

grp_1_mean = mean(A(grp_1,:));
grp_2_mean = mean(A(grp_2,:));
fprintf('group-1 mean: %f\n', grp_1_mean)
fprintf('group-2 mean: %f\n', grp_2_mean)
fprintf('Diversity\n')
grp_1_var = var(A(grp_1,:));
grp_2_var = var(A(grp_2,:));
temp = sum(grp_1_var);
temp = temp + sum(grp_2_var);
fprintf('Value: %f\n', temp);
% fprintf('group-1 var: %f\n', grp_1_var)
% fprintf('group-2 var: %f\n', grp_2_var)

