%---------------------- QUESTION 2 Part 1-------------------------%
clc
close all
tic
M=[10; 20];          % Buffer Size
q2=1/2;
p1=[1/4; 2/4; 3/4]; % Packet Arrival Probability
BP=0.01;            % Blocking Probability
%% Part 1 M=10, 20 and p1=1/4, 2/4, 3/4
for i=1:1
   for j=1:1
       q1=zeros(2*M(j)+2,2);
       P=TrMatrix('Transmission Control' , p1(i), 1, q2, M(j));
       r=Reward('Transmission Control' , p1(i), 1, q2, M(j));
       c=[zeros(2*M(j),2);p1(i)*[ q2, 1;q2/2 , 1] ];
%        c=[zeros(2*M(j),2);[ q2, 1;q2/2 , 1] ];

       cvx_begin 
            variable X(2*M(j)+2,2)
            variable Y(2*M(j)+2,2)
            maximize sum(sum(r.*X))
                subject to
                X*(ones(2,1))-P(:,:,1)'*X(:,1)-P(:,:,2)'*X(:,2)==zeros(2*M(j)+2,1)
                X*(ones(2,1))+Y*(ones(2,1))-P(:,:,1)'*Y(:,1)-P(:,:,2)'*Y(:,2)==ones(2*M(j)+2,1)/(2*M(j)+2)
                sum(sum(c.*X))<=BP
                -X<=zeros(2*M(j)+2,2)
                -Y<=zeros(2*M(j)+2,2)
       cvx_end
    for k=1:2*M(j)+2
       if sum(X(k),2)>0
            q1(k,1)=X(k,1)/sum(X(k,:),2);
       else
            q1(k,1)=Y(k,1)/sum(Y(k,:),2)
       end
    end
   
%    disp( ['M=', num2str(M(j)), ', p1=', num2str(p1(i))])
%    disp('Optimal Decision: ')
%    disp(q1(:,1))
   end
    
end
% X
% Y
disp([' Average Delay= ', num2str(-sum(sum(r.*X)))]);