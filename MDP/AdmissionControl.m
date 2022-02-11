%---------------------- QUESTION 2 Part 2-------------------------%
clc
close all
tic
M=[10; 20];          % Buffer Size
q1=1/2;
q2=q1; % Packet Arrival Probability
BP=0.01;            % Blocking Probability
j=1;
p1=zeros(2*M(j)+2,2);
%% Part 1 M=10, 20
for j=1:2
   P=TrMatrix('Admission Control' , 1, q1, q2, M(j));
   r=Reward('Admission Control', 1, q1, q2, M(j));
   c=[zeros(2*M(j),2);[ 1-q1+q1*q2, 0; 1-q1+q1*q2/2 , 0] ];
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
%             X(:,1)==simplex(2*M(j)+2)
%             X(:,2)==simplex(2*M(j)+2)
   cvx_end
   for i=1:2*M(j)+2
       if sum(X(i),2)>0
            p1(i,1)=X(i,1)/sum(X(i,:),2);
       else
            p1(i,1)=Y(i,1)/sum(Y(i,:),2);
       end
   end
%       p1=X./sum(X,2);
   disp( ['M=', num2str(M(j))])
   disp('Optimal Decision: ')
   disp(p1(:,1))
   sum(X)
end
