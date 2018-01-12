% N = 2^10 * 5;
% d = 5;
% K = 2^8; %Number of groups
% conc_crcl = 64;
N_array = [2^5, 2^6, 2^7, 2^8, 2^9, 2^10];
K_array = [2^2, 2^3, 2^4, 2^5, 2^6, 2^7];
cc_array = [2, 2^2, 2^3, 2^4, 2^5, 2^6];
len = length(N_array);
d_array = [2,3,4,5,6];

for d=d_array
    figure
    
    for l=1:len
        
        N = N_array(l);
        K = K_array(l);
        conc_crcl = cc_array(l);
        mn = 500;
        mu = ones([1 ,d])*mn;
        R = cell(conc_crcl, 1);
        temp=0;
        for i = 1:conc_crcl
            R{i} = zeros(2,1);
            R{i}(1) = temp + randi([8,12]);
            R{i}(2) = R{i}(1) + randi([1,2]);
            temp = R{i}(2);
        end

        data = zeros(N,d);
        cnt1=1;
        pnts_in_each = N/conc_crcl;
        for i = 1:conc_crcl
            ri_1 = R{i}(1);
            ri_2 = R{i}(2);
            sig = 2*ri_2;
            cnt2 = pnts_in_each;
            while cnt2>0
                X = abs(normrnd(mu, sig, [1,d]));
                if isValid(X, ri_1, ri_2, mu)
                    data(cnt1, :) = X;
                    cnt1 = cnt1 + 1;
                    cnt2 = cnt2 - 1;
                end
            end
        end

        input.data = data;
        input.N = N;
        input.d = d;
        
        %plot(data(:,1), data(:,2), '.r');
        
    end
    title(str)
    xlabel()
    ylabel()    
    close
end






