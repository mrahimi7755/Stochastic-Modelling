%% part 1
clc
close all
tic
M=20;     % Buffer Size
q1=1/2;
q2=q1;              % Packet Arrival Probability
BP=0.01;            % Blocking Probability
%% Part 1 M=10, 20
    p1=zeros(2*M+2,2);
   P=TrMatrix('Admission Control' , 1, q1, q2, M);
   r=Reward('Admission Control', 1, q1, q2, M);
   c=[zeros(2*M,2);[ 1-q1+q1*q2, 0; 1-q1+q1*q2/2 , 0] ];
   cvx_begin 
        variable x(2*M+2,2) 
        variable y(2*M+2,2)
        maximize sum(sum(r.*x))
            subject to
%             x*(ones(2,1))-P(:,:,1)*x(:,1)-P(:,:,2)*x(:,2)==zeros(2*M+2,1)
%             x*(ones(2,1))-y*7(ones(2,1))-P(:,:,1)*y(:,1)-P(:,:,2)*y(:,2)==ones(2*M+2,1)/(2*M+2)
            x*(ones(2,1))-P(:,:,1)'*x(:,1)-P(:,:,2)'*x(:,2)==zeros(2*M+2,1)
            x*(ones(2,1))+y*(ones(2,1))-P(:,:,1)'*y(:,1)-P(:,:,2)'*y(:,2)==ones(2*M+2,1)/(2*M+2)
            sum(sum(c.*x))<BP
            -x<=zeros(2*M+2,2)
            -y<=zeros(2*M+2,2)
%             X(:,1)==simplex(2*M+2)
%             X(:,2)==simplex(2*M+2)
   cvx_end
   for i=1:2*M+2
       if sum(x(i),2)>0
            p1(i,1)=x(i,1)/sum(x(i,:),2);
       else
            p1(i,1)=y(i,1)/sum(y(i,:),2)
       end
   end
   
%    disp( ['M=', num2str(M)])
%    disp('Optimal Decision: ')
%    disp(p1(:,1))
% p1=[ones(2*M,2);0 1 ;0 1];
%% 
q1_max=1/2;
q2_max=1/2;
N=1e6;
X=zeros(N,1);
Blocked=0;
Sent=0;
Collision=0;
Generated=0;
q1=q1_max;
q2=q2_max;
p=p1(:,1);
s1=0;
s2=0;
m=1;
for t=1:N
    p1=p(2*X(t)+m);
    s1=ceil(X(t)/M)*binornd(1,q1);
    s2=binornd(1,q2);
%     
    switch s1+s2
        case 1
            if s1==1
                X(t)=X(t)-1;
                q1=q1_max;
                Sent=Sent+1;
            else
                q2=q2_max;
            end
            
        case 2
            
            q1=q1_max;
            q2=q2_max/2;
            Collision=Collision+1;
            m=2;
    end
    a=binornd(1,p1);
    Generated=Generated+a;
    if X(t)<=M-1
        X(t)=X(t)+a;  
    else
        Blocked=Blocked+a;
    end
    X(t+1)=X(t);
end
disp(['Throughput=', num2str(Sent/N),'  ,' ,...
      'Collision', num2str(Collision),'  ,',...
      'Blocking Probability=', num2str(Blocked/Generated),...
        ', Average Delay= ', num2str(sum(X/N))]);
%       bar(X)
%       ylim([1;M])
%       xlabel('t')
%       ylabel('level(Packet)')
%       legend('M=20')