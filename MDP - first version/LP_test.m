%---------------------- QUESTION 2 Part 1-------------------------%
% clc
close all
tic
M=[1; 10];          % Buffer Size
q2=1/2;
p1=[1/10; 2/4; 3/4]; % Packet Arrival Probability
BP=0.01;            % Blocking Probability
%% Part 1 M=10, 20 and p1=1/2, 2/4, 3/4
for i=1:1
   for j=1:1
       P=TrMatrix('Transmission Control' , p1(i), 1, q2, M(j));
       r=Reward('Transmission Control' , p1(i), 1, q2, M(j));
       cvx_begin 
            variable X(2*(4*M(j)+4),1)
            variable Y(2*(4*M(j)+4),1)
            maximize [r(:,1)', r(:,2)']*X
                subject to
                for i=1:4*M(j)+4
                    
                end
                X*ones(2,1)-P(:,:,1)'*X(:,1)-P(:,:,2)'*X(:,2)==zeros(4*M(j)+4,1)
                X*ones(2,1)-Y*ones(2,1)-P(:,:,1)'*Y(:,1)-P(:,:,2)'*Y(:,2)==ones(4*M(j)+4,1)/(4*M(j)+4)
                -X<=zeros(4*M(j)+4,2)
                -Y<=zeros(4*M(j)+4,2)
%                 X(4,1)>=0
       cvx_end
   end
end