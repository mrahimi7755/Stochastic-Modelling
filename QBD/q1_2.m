%---------------------- QUESTION 1 Part 1-------------------------%
clc
close all
tic
%% Scenario Parameters(QBD)
N=2000;
%% Part 1 P1= 1/4, 2/4, 3/4 
epsilon=0.00001;
q_step=0.001;
p1=[1/4, 2/4, 3/4];
delay=1000*ones(floor(1/q_step),3);
mu=zeros(floor(1/q_step),3);
for i=1:3
    for q1=q_step:q_step:1
        q2=q1;
        [B, A2, A1, A0]=TrMatrix(p1(i), q1, q2); 
        A=A1+A2+A0;
        alpha=(A^200);
        alpha=alpha(1,:);
        m=size(A2,1);
        mu(floor(q1/q_step),i)=alpha*A0*ones(m,1)-alpha*A2*ones(m,1);
        if mu(floor(q1/q_step),i)<=0
            %% G calaulation
            G=GCalculator(A2, A1, A0, epsilon);
            U=A1+A0*G;
            R=A0*inv(eye(m,m)-U);
            %% Boundary Stationary State Distribution
            [pi_vector0, pi_vector]=SteadyStateDistribution(B, A2, A1, A0, G, N);
            delay(floor(q1/q_step),i)=sum(pi_vector)*(1:N)';
        end
    end
    
end

%% plot
tiledlayout(1,2);
% left tile
nexttile
title('Stability')
plot((q_step:q_step:1),mu(:,1)/p1(1),'linewidth',1.25)
    hold on
plot((q_step:q_step:1),mu(:,2)/p1(2),'linewidth',1.25)
hold on
plot((q_step:q_step:1),mu(:,3)/p1(3),'linewidth',1.25,'color','g')
grid on
ylim([-1 1])
xlabel('q1')
ylabel('mu')
legend('p1=1/4', 'p1=2/4', 'p1=3/4')
% right tile  
nexttile
title('Average delay')
plot((q_step:q_step:1),delay(:,1)/p1(1),'linewidth',1.25)
    hold on
plot((q_step:q_step:1),delay(:,2)/p1(2),'linewidth',1.25)
hold on
plot((q_step:q_step:1),delay(:,3)/p1(3),'linewidth',1.25,'color','g')
grid on
ylim([0 1350])
xlabel('q1')
ylabel('Average Delay')
legend('p1=1/4', 'p1=2/4', 'p1=3/4')
