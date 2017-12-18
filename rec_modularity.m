
function temp = rec_modularity(flag, data_index, data_len)
    
    global distanceMat lambda;
    global  grp_cell;
    global index;
    
    if flag==1    
        grp_cell{index}=data_index;
%         length(grp_cell{index})
        index = index + 1;       
        return;
    end

    D = distanceMat(data_index, data_index);
    
    degree_vect = sum(D,2);
    degree_mat = degree_vect * degree_vect';
    m = sum(sum(D))/2;

    Mat = D - degree_mat/(2*m) - lambda*ones(data_len);
    [Evec, Evl] = eig(Mat);
    
    a = diag(Evl);
    a(data_len)
    
    eig_vec = Evec(:,data_len);
    grp_1 = data_index(find(eig_vec>=0));
    grp_2 = data_index(find(eig_vec< 0));
    
    
    flag = flag/2;
    
    rec_modularity(flag, grp_1, length(grp_1));
    rec_modularity(flag, grp_2, length(grp_2));
    
    
end