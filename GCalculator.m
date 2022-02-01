function G=GCalculator(A2, A1, A0, epsilon)
    %---------- Linear Progressive Algorithm-----------%
    m=size(A2,1);
%     G=zeros(m, m);
    G=A2/(eye(m,m)-A1);
    while max(abs(ones(m,1)-G*ones(m,1)))>epsilon
        U=A1+ A0* G;
        G=inv(eye(m,m)- U)*A2; % fuck you matlab for this warning
    end
end