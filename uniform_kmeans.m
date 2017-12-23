function [U_grp_cell, U_grp_size] = uniform_kmeans(A, Kmns, K)
    
    U_grp_cell = cell(K, 1);
    
    for i=1:K
        U_grp_cell{i} = zeros(Kmns,1);
    end
    
    IDX = kmeans(A, Kmns);
    U_grp_size = zeros(K, 1);
    for c = 1:Kmns
%         c
        clus = find(IDX==c);
        cl_sz = length(clus);
        grp = randi(K);
        
        while(cl_sz>0)
%             cl_sz
            if U_grp_size(grp)<Kmns
                U_grp_size(grp) = U_grp_size(grp) + 1;
                U_grp_cell{grp}(U_grp_size(grp)) = clus(cl_sz);
                cl_sz = cl_sz - 1;
            end
            grp = mod(grp, K) + 1;
            
        end
        
    end    
end