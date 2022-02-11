%---------------------- QUESTION 2 Part 1-------------------------%
clc
close all
tic
M=[10; 20];          % Buffer Size
q2=1/2;
p1=[1/4; 2/4; 3/4]; % Packet Arrival Probability
BP=0.01;            % Blocking Probability
%% Part 1 M=10, 20 and p1=1/2, 2/4, 3/4
for i=1:3
   for j=1:2
       P=TrMatrix('Transmission Control' , p1(i), 1, q2, M(j));
       r=Reward('Transmission Control' , p1(i), 1, q2, M(j));
       c=[zeros(4*M(j),2);ones(4,2)];
       cvx_begin 
            variable X(4*M(j)+4,2)
            variable Y(4*M(j)+4,2)
            maximize sum(sum(r.*X))
                subject to
                X*(ones(2,1))-P(:,:,1)*X(:,1)-P(:,:,2)*X(:,2)==zeros(4*M(j)+4,1)
                X*(ones(2,1))-Y*(ones(2,1))-P(:,:,1)*Y(:,1)-P(:,:,2)*Y(:,2)==ones(4*M(j)+4,1)/(4*M(j)+4)
                sum(sum(c.*X))<=BP
                -X<=zeros(4*M(j)+4,2)
                -Y<=zeros(4*M(j)+4,2)
       cvx_end
   q1=X./sum(X,2);
   disp( ['M=', num2str(M(j)), ', p1=', num2str(p1(i))])
   disp('Optimal Decision: ')
   disp(q1)
   end
    
end
% X
% Y
