function [U_grp_cell, grp_size] = uniform_kmeans(A, K, grps)
    
    U_grp_cell = cell(grps, 1);
    
    for i=1:grps
        U_grp_cell{i} = zeros(K,1);
    end
    
    IDX = kmeans(A, K);
    grp_size = zeros(grps, 1);
    for c = 1:K
        clus = find(IDX==c);
        cl_sz = length(clus);
        grp = randi(grps);
        while(cl_sz>0)
            
            if grp_size(grp)<K
                grp_size(grp) = grp_size(grp) + 1;
                U_grp_cell{grp}(grp_size(grp)) = clus(cl_sz);
                cl_sz = cl_sz - 1;
            end
            grp = mod(grp, grps) + 1;
            
        end
        
    end    
end