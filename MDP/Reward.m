function r=Reward(DecisionRule , p1, q1, q2, M)
    % returns average immediate reward of each decision rule
    r=zeros(2*(M+1),2);
    switch DecisionRule
        case 'Transmission Control'            
            immediate_reward=-(0:M)';
            P=TrMatrix('Transmission Control', p1, 1, q2, M);
            levelP=zeros(2*M+2,M+1);
            for i=1:2
                for j=1:M+1
                    levelP(:,j)=sum(P(:,2*(j-1)+1:2*j,i),2);
                end
            r(:,i)=levelP*immediate_reward;
            end
%                         disp(r)
%                         disp(levelP)
        case 'Admission Control'
            r(:,2)=0;
            r(:,1)=1;
%             immediate_reward=(0:M)';
%             P=TrMatrix('Admission Control', 1, q1, q2, M);
%             levelP=zeros(2*M+2,M+1);
%             for i=1:2
%                 for j=1:M+1
%                     levelP(:,j)=sum(P(:,2*(j-1)+1:2*j,i),2);
%                 end
%             r(:,i)=levelP*immediate_reward;
%             end
%                         disp(r)
%                         disp(levelP)
        
    end
         
end
