function [pi_vector0, pi_vector]=SteadyStateDistribution(B, A2, A1, A0, G, N)
    %---------- Stationary State Distribution-----------%
    m=size(A2,1);
    pi_vector=zeros(m,N);
    U=A1+A0*G;
    R=A0*inv(eye(m,m)-U);
    P=B+A0*G;
    X=transpose(P-eye(m,m));
    [U,S,V] = svd(X);
    X1=X(1:end-1,:);
    
    X2=transpose(inv(eye(m,m)-R)*ones(m,1));
    X3=[X1;X2];
    pi_vector0=inv(X3)*[zeros(m-1,1);1];
    pi_vector0'*P-pi_vector0';
    pi_vector0'*(inv(eye(m,m)-R)*ones(m,1));
    for n=1:N
        pi_vector(:,n)=R^n*pi_vector0;
    end
end