function answer = M2_variance_of_grp_means( grp_cll, K ,d, A)
      mean_mat = zeros(K,d);
      
      for k=1:K
        temp = grp_cll{k};
        mean_mat(k, :) = mean(A(temp, :));
      end
      
      cov_mat = cov(mean_mat);
      answer = det(cov_mat);
end

