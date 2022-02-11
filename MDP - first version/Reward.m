function r=Reward(DecisionRule , p1, q1, q2, M)
    % returns average immediate reward of each decision rule
    r=zeros(4*(M+1),2);
    switch DecisionRule
        case 'Transmission Control'            
            immediate_reward=-(0:M)';
            P=TrMatrix('Transmission Control', p1, 1, q2, M);
            levelP=zeros(4*M+4,M+1);
            for i=1:2
                for j=1:M+1
                    levelP(:,j)=sum(P(:,4*(j-1)+1:4*j,i),2);
                end
            r(:,i)=levelP*immediate_reward;
            end
%                         disp(r)
%                         disp(levelP)
        case 'Admission Control'
            immediate_reward=(0:M)';
            P=TrMatrix('Admission Control', 1, q1, q2, M);
            levelP=zeros(4*M+4,M+1);
            for i=1:2
                for j=1:M+1
                    levelP(:,j)=sum(P(:,4*(j-1)+1:4*j,i),2);
                end
            r(:,i)=levelP*immediate_reward;
            end
%                         disp(r)
%                         disp(levelP)
        
    end
         
end


%% Old Version
%             r(1:4,1)=[-p1*q2; -p1*q2/2; -p1*(q2+1)/2; -p1*(q2/2+1)/2];     % r(:,1)=r(s,q1=1)
%             r(1:4,2)=-p1;                                                  % r(:,2)=r(s,q1=0)
% 
%             for n=1:M-1
%                r(4*n+1:4*n+4,1)=-[p1*q2*(n+1)+ (p1+q2-2*p1*q2)*n+ (1-p1)*(1-q2)*(n-1);...
%                                   p1*q2/2*(n+1)+ (p1+q2/2-p1*q2)*n+ (1-p1)*(1-q2/2)*(n-1);...
%                                   p1*(q2+1)/2*(n+1)+ (1+q2-2*p1*q2)/2*n + (1-p1)*(1-q2)/2*(n-1);...
%                                   p1*(1+q2/2)/2*(n+1)+ (1+q2/2-p1*q2/2)/2*(n)+ (1-p1)*(1-q2/2)/2*(n-1)]; 
%                r(4*n+1:4*n+4,2)=-(p1*(n+1)+ (1-p1)*n); 
%             end
%             n=M;
%                r(4*n+1:4*n+4,1)=-[p1*q2*(n)+ (p1+q2-2*p1*q2)*n+ (1-p1)*(1-q2)*(n-1);...
%                                   p1*q2/2*(n)+ (p1+q2/2-p1*q2)*n+ (1-p1)*(1-q2/2)*(n-1);...
%                                   p1*(q2+1)/2*(n)+ (1+q2-2*p1*q2)/2*n + (1-p1)*(1-q2)/2*(n-1);...
%                                   (p1+ (1-p1)*(1/2*q2/2+ 1/2 ))*(n)+ (1-p1)*(1-q2/2)/2*(n-1)]; 
%                r(4*n+1:4*n+4,2)=-(p1*(n)+ (1-p1)*n);        
%             disp(r)
