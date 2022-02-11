clc
close all
q2_max=1/2;
p1=3/4;
M=10;
N=4000;
X=zeros(N,1);
Blocked=0;
Sent=0;
Collision=0;
q1=q1_max;
q2=q2_max;
q=zeros(4*M+4,1);
m=1;
s1=0;
s2=0;
for t=1:N
    if X(t)<=M-1
        X(t)=X(t)+binornd(1,p1);  
    else
        Blocked=Blocked+binornd(1,p1);
    end
%     disp(['t=', num2str(t), ',','X(t)=', num2str(X(t))]);
    q1_max=q(4*x(t)+m);
    if m==1||m==2
        q1=q1_max;
    else
        q1=q1_max/2;
    end
    s1=ceil(X(t)/M)*binornd(1,q1);
    s2=binornd(1,q2);
    
    switch s1+s2
        case 1
            if s1==1
                X(t)=X(t)-1;
                if (m==2)||(m==4)
                    m=2;
                else 
                    m=1;
                end
%                 q1=q1_max;
                Sent=Sent+1;
                
            else 
                if (m==1)||(m==2)
                    m=1;
                else
                    m=3;
                end
                q2=q2_max;
                
            end
            
        case 2
            m=4;
%             q1=q1_max/2;
            q2=q2_max/2;
            Collision=Collision+1;
    end
    
    X(t+1)=X(t);
    disp(['t=', num2str(t), ',','X(t)=', num2str(X(t)), ',',...
          'q1=', num2str(q1/q1_max), ',','q2=', num2str(q2/q2_max), ',',...
          's1=', num2str(s1), ',','s2=', num2str(s2)])
%       pause(0.005)
      bar(X)
      ylim([1;M])
      bar(X)
      xlabel('t')
      ylabel('level(Packet)')
%       hold on
end
disp(['Sent=', num2str(Sent),'  ,' ,...
      'Collision', num2str(Collision),'  ,',...
      'Blocking Probability=', num2str(Blocked/(N*p1))]);