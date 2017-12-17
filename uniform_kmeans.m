
sprintf('\n\n--------------------Uniform Kmeans--------------------\n\n')
% Uniform K-Means
k = N/d;

IDX = kmeans(A, k);

U_size_1 = 0;
U_size_2 = 0;

U_grp_1 = [];
U_grp_2 = [];

for c=1:k
    
    clus = find(IDX==c);
    cl_sz = length(clus);
    temp = randi(2);
    for i=1:cl_sz
        
        if temp==1
            temp = 2;
            
            if U_size_1<k                
                U_grp_1 = [U_grp_1, clus(i)];
                U_size_1 = U_size_1 + 1;                
            else                
                U_grp_2 = [U_grp_2, clus(i)];
                U_size_2 = U_size_2 + 1;                
            end
            
        else
            temp = 1;
            
            if U_size_2<k
                U_grp_2 = [U_grp_2, clus(i)];
                U_size_2 = U_size_2 + 1;
            else
                U_grp_1 = [U_grp_1, clus(i)];
                U_size_1 = U_size_1 + 1;                
            end
            
        end
    end
    
end


sprintf('group-1 size: %d\n',U_size_1)
sprintf('group-2 size: %d\n',U_size_2)

grp_1_mean = mean(A(U_grp_1,:));
grp_2_mean = mean(A(U_grp_2,:));
sprintf('group-1 mean: %f\n', grp_1_mean)
sprintf('group-2 mean: %f\n', grp_2_mean)
grp_1_var = var(A(U_grp_1,:));
grp_2_var = var(A(U_grp_2,:));
sprintf('group-1 var: %f\n', grp_1_var)
sprintf('group-2 var: %f\n', grp_2_var)