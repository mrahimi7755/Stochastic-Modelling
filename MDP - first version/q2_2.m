%---------------------- QUESTION 2 Part 2-------------------------%
clc
close all
tic
M=[10; 20];          % Buffer Size
q1=1/2;
q2=q1; % Packet Arrival Probability
BP=0.01;            % Blocking Probability
%% Part 1 M=10, 20
for j=1:2
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
   disp( ['M=', num2str(M(j))])
   disp('Optimal Decision: ')
   disp(p1(:,1))
end
% X
% Y
% 
% % epsilon=0.00001;
% q_step=0.001;
% delay=1000*ones(floor(1/q_step),3);
% mu=zeros(floor(1/q_step),3);
% for i=1:3
%     for q1=q_step:q_step:1
%         q2=q1;
%         [B, A2, A1, A0]=TrMatrix(p1(i), q1, q2); 
%         A=A1+A2+A0;
%         alpha=(A^200);
%         alpha=alpha(1,:);
%         m=size(A2,1);
%         mu(floor(q1/q_step),i)=alpha*A0*ones(m,1)-alpha*A2*ones(m,1);
%         if mu(floor(q1/q_step),i)<=0
%             %% G calaulation
%             G=GCalculator(A2, A1, A0, epsilon);
%             U=A1+A0*G;
%             R=A0*inv(eye(m,m)-U);
%             %% Boundary Stationary State Distribution
%             [pi_vector0, pi_vector]=SteadyStateDistribution(B, A2, A1, A0, G, N);
%             delay(floor(q1/q_step),i)=sum(pi_vector)*(1:N)';
%         end
%     end
%     
% end
% 
% %% 
% tiledlayout(1,2);
% % left tile
% nexttile
% title('Stability')
% plot((q_step:q_step:1),mu(:,1)/p1(1),'linewidth',1.25)
%     hold on
% plot((q_step:q_step:1),mu(:,2)/p1(2),'linewidth',1.25)
% hold on
% plot((q_step:q_step:1),mu(:,3)/p1(3),'linewidth',1.25,'color','g')
% grid on
% ylim([-1 1])
% xlabel('q1')
% ylabel('Average Delay')
% legend('p1=1/4', 'p1=2/4', 'p1=3/4')
% % right tile  
% nexttile
% title('Average delay')
% plot((q_step:q_step:1),delay(:,1)/p1(1),'linewidth',1.25)
%     hold on
% plot((q_step:q_step:1),delay(:,2)/p1(2),'linewidth',1.25)
% hold on
% plot((q_step:q_step:1),delay(:,3)/p1(3),'linewidth',1.25,'color','g')
% grid on
% ylim([0 1350])
% xlabel('q1')
% ylabel('Average Delay')
% legend('p1=1/4', 'p1=2/4', 'p1=3/4')
