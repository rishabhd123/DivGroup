function a = isValid(X, ri_1, ri_2, mu )
 temp = norm(X-mu);
 
 if (temp >=ri_1 && temp <= ri_2)
     a = true;
 else
     a = false;
 end
end

