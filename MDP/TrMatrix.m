function P=TrMatrix(DecisionRule , p1, q1, q2, M)
    % returns transition matrix of each decision rule
    P=zeros(2*(M+1), 2*(M+1), 2);
    switch  DecisionRule
        case 'Transmission Control'
            q1=[1;0];
            for i=1:2 
                B=[1-p1* (1- q1(i)+ q1(i)* q2), 0;...
                    (1-p1)*(q2/2), (1-q2/2)*(1-p1+p1*q1(i))];

                A2=[(1-p1)*q1(i)*(1-q2), 0;...
                    0, (1-p1)*q1(i)*(1-q2/2)];
                    
                A1=[(1-p1)*(1-q1(i))+p1*q1(i)*(1-q2), (1-p1)*q1(i)*q2;...
                    (1-p1)*(1-q1(i))*q2/2, (1-q2/2)*(1-p1-q1(i)+2*p1*q1(i))+(1-p1)*q1(i)*q2/2];
                
                A0=[p1*(1-q1(i)), p1*q1(i)*q2;...
                    p1*(1-q1(i))*q2/2, p1*(1-q1(i))*(1-q2/2)+p1*q1(i)*q2/2];
                P( 1:2,:, i)=[B, A0, zeros(2, 2*M-2)];
                for k=1:M-1
                    P( 2*k+1:2*k+2,:, i)=[zeros(2, 2*k-2), A2, A1, A0, zeros(2, 2*(M-k)-2)];     
                end
                P(2*M+1:end,:,i)=[zeros(2,2*M-2), A2, A1+A0];
            end            
        case 'Admission Control'
            p1=[1;0];
            for i=1:2 
                B=[1-p1(i)* (1- q1+ q1* q2), 0;...
                    (1-p1(i))*(q2/2), (1-q2/2)*(1-p1(i)+p1(i)*q1)];

                A2=[(1-p1(i))*q1*(1-q2), 0;...
                    0, (1-p1(i))*q1*(1-q2/2)];
                    
                A1=[(1-p1(i))*(1-q1)+p1(i)*q1*(1-q2), (1-p1(i))*q1*q2;...
                    (1-p1(i))*(1-q1)*q2/2, (1-q2/2)*(1-p1(i)-q1+2*p1(i)*q1)+(1-p1(i))*q1*q2/2];
                
                A0=[p1(i)*(1-q1), p1(i)*q1*q2;...
                    p1(i)*(1-q1)*q2/2, p1(i)*(1-q1)*(1-q2/2)+p1(i)*q1*q2/2];
                P( 1:2,:, i)=[B, A0, zeros(2, 2*M-2)];
                for k=1:M-1
                    P( 2*k+1:2*k+2,:, i)=[zeros(2, 2*k-2), A2, A1, A0, zeros(2, 2*(M-k)-2)];     
                end
                P(2*M+1:end,:,i)=[zeros(2,2*M-2), A2, A1+A0];
            end            
            
            
    end
end