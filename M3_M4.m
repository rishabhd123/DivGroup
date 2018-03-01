function [M3, M4] = M3_M4(grp_cll, K, d, A)
    % M3 - Var of group variance
    % M4 - Diversity
    
    cov_cell = cell(K,1);
    mean_cov = zeros(d, d);
    
    for i=1:K
        cov_cell{i} = cov(A(grp_cll{i}, :));
        mean_cov = mean_cov + cov_cell{i};
    end
    
    mean_cov = mean_cov/K;
    M3 = 0;
    M4 = 0;
    
    for i=1:K        
        M4 = M4 + det(cov_cell{i});        
        M3 = M3 + norm(cov_cell{i}-mean_cov, 'fro')^2;
    end    
    
end