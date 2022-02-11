
clc
close all
tic
M=[10; 10];          % Buffer Size
q1=1/2;
q2=q1; % Packet Arrival Probability
BP=0.5;            % Blocking Probability
%% Part 1 M=10, 20
for j=1:1
   P=TrMatrix('Admission Control' , 1, q1, q2, M(j));
   r=Reward('Admission Control', 1, q1, q2, M(j));
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
      p1=X./sum(X,2);
%    disp( ['M=', num2str(M(j))])
%    disp('Optimal Decision: ')
%    disp(p1)
end
%% 
q1_max=1/2;
q2_max=1/2;
M=10;
N=1000;
X=zeros(N,1);
Blocked=0;
Sent=0;
Collision=0;
q1=q1_max;
q2=q2_max;
% p=1/4*ones(4*M+4,1);
p=p1;
s1=0;
s2=0;
for t=1:N
    m=4-2*ceil(q1/q1_max)-ceil(q2/q2_max);
    p1=p(4*X(t)+m);
    if X(t)<=M-1
        X(t)=X(t)+binornd(1,p1);  
    else
        Blocked=Blocked+binornd(1,p1);
    end
%     disp(['t=', num2str(t), ',','X(t)=', num2str(X(t))]);
    s1=ceil(X(t)/M)*binornd(1,q1);
    s2=binornd(1,q2);
    
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
            
            q1=q1_max/2;
            q2=q2_max/2;
            Collision=Collision+1;
    end
    X(t+1)=X(t);
%     disp(['t=', num2str(t), ',','X(t)=', num2str(X(t)), ',',...
%           'q1=', num2str(q1/q1_max), ',','q2=', num2str(q2/q2_max), ',',...
%           's1=', num2str(s1), ',','s2=', num2str(s2)])
% %       pause(0.005)
      bar(X)
      ylim([1;M])
%       hold on
end
disp(['Throughput=', num2str(Sent/(N*mean(p(:,1)))),'  ,' ,...
      'Collision', num2str(Collision),'  ,',...
      'Blocking Probability=', num2str(Blocked/(N))]);