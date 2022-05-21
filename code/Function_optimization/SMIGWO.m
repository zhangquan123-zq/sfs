% [1]������,����Ƽ,������.����Iterativeӳ��͵����η��ĸĽ������Ż��㷨[J].�����Ӧ��,2018,38(S2):16-20+54.
function [Alpha_score,Alpha_pos,Convergence_curve]=SMIGWO(SearchAgents_no,Max_iter,lb,ub,dim,fobj)
%�������Ӳ���
amax = 2;
amin = 0;

% initialize alpha, beta, and delta_pos
Alpha_pos=zeros(1,dim);
Alpha_score=inf; %change this to -inf for maximization problems

Beta_pos=zeros(1,dim);
Beta_score=inf; %change this to -inf for maximization problems

Delta_pos=zeros(1,dim);
Delta_score=inf; %change this to -inf for maximization problems

%% �Ľ��㣺Iterative����ӳ��
Positions=initializationNew(SearchAgents_no,dim,ub,lb);

Convergence_curve=zeros(1,Max_iter);

l=0;% Loop counter
fitness = zeros(1,dim);
% Main loop
while l<Max_iter
     for i=1:size(Positions,1)  
        
       % Return back the search agents that go beyond the boundaries of the search space
        Flag4ub=Positions(i,:)>ub;
        Flag4lb=Positions(i,:)<lb;
        Positions(i,:)=(Positions(i,:).*(~(Flag4ub+Flag4lb)))+ub.*Flag4ub+lb.*Flag4lb;               
        
        % Calculate objective function for each search agent
        fitness(i)=fobj(Positions(i,:));
        
        % Update Alpha, Beta, and Delta
        if fitness(i)<Alpha_score 
            Alpha_score=fitness(i); % Update alpha
            Alpha_pos=Positions(i,:);
        end
        
        if fitness(i)>Alpha_score && fitness(i)<Beta_score 
            Beta_score=fitness(i); % Update beta
            Beta_pos=Positions(i,:);
        end
        
        if fitness(i)>Alpha_score && fitness(i)>Beta_score && fitness(i)<Delta_score 
            Delta_score=fitness(i); % Update delta
            Delta_pos=Positions(i,:);
        end
    end
    %% �Ľ��㣺 �����η��Ľ����λ��
    [~,indexWorst]=max(fitness);%��ȡ���λ��
    Xs = Positions(indexWorst,:);%��ȡ���λ��
    Xc = (Alpha_pos + Beta_pos)/2;
    % ���з���
    Xr = Xc + (Xc-Xs);
    Xr(Xr>ub) = ub;
    Xr(Xr<lb) = lb;
    if(fobj(Xr)<Alpha_score)
        Xe = Xc + 2.*(Xr-Xc);%��������
        Xr(Xr>ub) = ub;
        Xr(Xr<lb) = lb;
        if(fobj(Xe)<Alpha_score)
            Xs = Xe;
        else
            Xs = Xr;
        end
    else
        Xt = Xc + 0.5.*(Xs-Xc);%������
        Xt(Xt>ub) = ub;
        Xt(Xt<lb) = lb;
        if(fobj(Xt)<fobj(Xs))
            Xs = Xt;
        end
    end
    if(Alpha_score<fobj(Xr)&&fobj(Xr)<fobj(Xs))
        Xw = Xc - 0.5.*(Xs-Xc);%������
        Xw(Xw>ub) = ub;
        Xw(Xw<lb) = lb;
        if(fobj(Xw)<fobj(Xs))
            Xs = Xw;
        else
            Xs=Xt;
        end
    end
    Positions(indexWorst,:) = Xs;    
    %% �Ľ��㣺 �������ӸĽ�,�治��ȫ �� ��������������
    lamba = 0.01;
    a = amin + (amax -amin)*gammaincinv(lamba,1 - (l+1)/Max_iter)/lamba; %���ָĽ�Ч���ܲ��á�
    a=2-l*((2)/Max_iter); %
    % Update the Position of search agents including omegas
    for i=1:size(Positions,1)
        for j=1:size(Positions,2)     
                       
            r1=rand(); % r1 is a random number in [0,1]
            r2=rand(); % r2 is a random number in [0,1]
            
            A1=2*a*r1-a; % Equation (3.3)
            C1=2*r2; % Equation (3.4)
            
            D_alpha=abs(C1*Alpha_pos(j)-Positions(i,j)); % Equation (3.5)-part 1
            X1=Alpha_pos(j)-A1*D_alpha; % Equation (3.6)-part 1
                       
            r1=rand();
            r2=rand();
            
            A2=2*a*r1-a; % Equation (3.3)
            C2=2*r2; % Equation (3.4)
            
            D_beta=abs(C2*Beta_pos(j)-Positions(i,j)); % Equation (3.5)-part 2
            X2=Beta_pos(j)-A2*D_beta; % Equation (3.6)-part 2       
            
            r1=rand();
            r2=rand(); 
            
            A3=2*a*r1-a; % Equation (3.3)
            C3=2*r2; % Equation (3.4)
            
            D_delta=abs(C3*Delta_pos(j)-Positions(i,j)); % Equation (3.5)-part 3
            X3=Delta_pos(j)-A3*D_delta; % Equation (3.5)-part 3             
            
            Positions(i,j)=(X1+X2+X3)/3;% Equation (3.7)
            
        end
    end
    l=l+1;    
    Convergence_curve(l)=Alpha_score;
end



