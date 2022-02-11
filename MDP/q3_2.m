%---------------------- QUESTION 3 Part 1-------------------------%
clc
close all
tic
M=20;         % Buffer Size
q2=1/2;
p1=1/4; % Packet Arrival Probability
BP=0.01;            % Blocking Probability
q1=zeros(2*M+2,2);
%% Part 3 M=10, 20 and p1=1/4, 2/4, 3/4
       P=TrMatrix('Transmission Control' , p1, 1, q2, M);
       r=Reward('Transmission Control' , p1, 1, q2, M);
       c=[zeros(2*M,2);p1*[ q2, 1;q2/2 , 1] ];
       cvx_begin 
            variable x(2*M+2,2)
            variable y(2*M+2,2)
            maximize sum(sum(r.*x))
%                 subject to
%                 x*(ones(2,1))-P(:,:,1)*x(:,1)-P(:,:,2)*x(:,2)==zeros(2*M+2,1)
%                 x*(ones(2,1))-y*(ones(2,1))-P(:,:,1)*y(:,1)-P(:,:,2)*y(:,2)==ones(2*M+2,1)/(2*M+2)
                x*(ones(2,1))-P(:,:,1)'*x(:,1)-P(:,:,2)'*x(:,2)==zeros(2*M+2,1)
                x*(ones(2,1))+y*(ones(2,1))-P(:,:,1)'*y(:,1)-P(:,:,2)'*y(:,2)==ones(2*M+2,1)/(2*M+2)
                sum(sum(c.*x))<=BP
                -x<=zeros(2*M+2,2)
                -y<=zeros(2*M+2,2)
       cvx_end
    for k=1:2*M+2
       if sum(x(k),2)>0
            q1(k,1)=x(k,1)/sum(x(k,:),2);
       else
            q1(k,1)=y(k,1)/sum(y(k,:),2)
       end
    end
%%
q2_max=q2;
N=1e5;
X=zeros(N,1);
Blocked=0;
Sent=0;
Collision=0;
q2=q2_max;
m=1;
s1=0;
s2=0;
q=q1(:,1);
for t=1:N
%     disp(['t=', num2str(t), ',','X(t)=', num2str(X(t))]);
    q1_max=q(2*X(t)+m);
    q1=q1_max;
    s1=ceil(X(t)/M)*binornd(1,q1);
    s2=binornd(1,q2);
    
    switch s1+s2
        case 1
            if s1==1
                X(t)=X(t)-1;
                
                Sent=Sent+1;
                
            else 
                q2=q2_max;
                m=1;
                
            end
            
        case 2
            q2=q2_max/2;
            Collision=Collision+1;
            m=2;
    end
    
    if X(t)<=M-1
        X(t)=X(t)+binornd(1,p1);  
    else
        Blocked=Blocked+binornd(1,p1);
    end
    X(t+1)=X(t);
%     disp(['t=', num2str(t), ',','X(t)=', num2str(X(t)), ',',...
%           'q1=', num2str(q1), ',','q2=', num2str(q2), ',',...
%           's1=', num2str(s1), ',','s2=', num2str(s2)])
%       
end
%% Plot
bar(X)
      ylim([1;M])
      bar(X)
      xlabel('t')
      ylabel('level(Packet)')
      legend('M=20')
%% Display
disp(['Throughput=', num2str(Sent/(N)),'  ,' ,...
      'Collision', num2str(Collision),'  ,',...
      'Blocking Probability=', num2str(Blocked/(N)),...
      ', Average Delay= ', num2str(sum(X/N))]);
