function [grp_cell, grp_size] = spectral_modularity(K, lambda, distanceMat)
    
    degree_vect = sum(distanceMat,2);
    degree_mat = degree_vect * degree_vect';
    m = sum(sum(distanceMat))/2;
    data_len = size(distanceMat, 1);
    Mat = distanceMat - degree_mat/(2*m) - lambda*ones(data_len);
    tic
    fprintf('Eigen Decomposition Initiated\n')
    [Evec, Evl] = eig(Mat);
    fprintf('Eigen Decomposition completed\n')
    toc
    
    [~, I] = sort(diag(Evl), 'descend');
    Evec = Evec(:, I);   
    
%     figure
%     plot(diag(log2(-Evl)),'*');
%     D = zeros(data_len, K);
    
    fprintf('Selecting eigen vectors for K-Means\n')
    eig_vect_cnt=1;
    
    for i=1:K
        eig_vec = Evec(:, eig_vect_cnt);
        while( (sum(eig_vec>=0) == 0 || sum(eig_vec<0) == 0) )
            eig_vect_cnt = eig_vect_cnt+1;
            eig_vec = Evec(:, eig_vect_cnt);
        end
        D(:, i) = eig_vec;
%         Evl(eig_vect_cnt, eig_vect_cnt)
        eig_vect_cnt = eig_vect_cnt+1;
    end
    
    fprintf('Eigen Vectors for KMeans has been selected\n\n')

    tic
    fprintf('Performing Kmeans Clustering\n')    
    IDX = kmeans(D, K);
    fprintf('Kmeans Clustering completed\n')
    toc
    grp_cell = cell(K,1);
    grp_size = zeros(K,1);
    
    for i=1:K
        grp_cell{i} = find(IDX==i);
        grp_size(i) = length(grp_cell{i});
    end
   
end
