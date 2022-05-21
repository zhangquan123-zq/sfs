
%%%[1]����,��ά��,������,����.������ά���к�����ζ����ԵĻ����㷨[J].�������ѧ,2020,47(08):291-296.
function [Alpha_score,Alpha_pos,Convergence_curve]=GWOS(SearchAgents_no,Max_iter,lb,ub,dim,fobj)

 w = 0.75;%�������Ӳ���
% initialize alpha, beta, and delta_pos
Alpha_pos=zeros(1,dim);
Alpha_score=inf; %change this to -inf for maximization problems

Beta_pos=zeros(1,dim);
Beta_score=inf; %change this to -inf for maximization problems

Delta_pos=zeros(1,dim);
Delta_score=inf; %change this to -inf for maximization problems

%Initialize the positions of search agents
Positions=initialization(SearchAgents_no,dim,ub,lb);

Convergence_curve=zeros(1,Max_iter);

l=0;% Loop counter

% Main loop
while l<Max_iter
    for i=1:size(Positions,1)  
        
       % Return back the search agents that go beyond the boundaries of the search space
        Flag4ub=Positions(i,:)>ub;
        Flag4lb=Positions(i,:)<lb;
        Positions(i,:)=(Positions(i,:).*(~(Flag4ub+Flag4lb)))+ub.*Flag4ub+lb.*Flag4lb;               
        
        % Calculate objective function for each search agent
        fitness=fobj(Positions(i,:));
        
        % Update Alpha, Beta, and Delta
        if fitness<Alpha_score 
            Alpha_score=fitness; % Update alpha
            Alpha_pos=Positions(i,:);
            indexA = i;
        end
        
        if fitness>Alpha_score && fitness<Beta_score 
            Beta_score=fitness; % Update beta
            Beta_pos=Positions(i,:);
        end
        
        if fitness>Alpha_score && fitness>Beta_score && fitness<Delta_score 
            Delta_score=fitness; % Update delta
            Delta_pos=Positions(i,:);
        end
    end
    %% �Ľ��㣺���������Levy���л����������
    if(rand<0.5-0.5*l/(w))
        L=Levy(dim);
        Temp = Alpha_pos + L.*(Alpha_pos);
        %�߽紦��
        Flag4ub=Temp>ub;
        Flag4lb=Temp<lb;
        Temp=(Temp.*(~(Flag4ub+Flag4lb)))+ub.*Flag4ub+lb.*Flag4lb; 
        %�������Ӧ��ֵ
        fTemp = fobj(Temp);
        if(fTemp<Alpha_score)
            Alpha_score = fTemp;
            Alpha_pos = Temp;
            Positions(indexA,:)=Alpha_pos;     
        end
    else %������߲���   
        indexR = randi(SearchAgents_no,[1,2]);%���ѡȡ��������
        e =rand();
        Temp = Alpha_pos + e.*(Positions(indexR(1),:) - Positions(indexR(2),:));
        %�߽紦��
        Flag4ub=Temp>ub;
        Flag4lb=Temp<lb;
        Temp=(Temp.*(~(Flag4ub+Flag4lb)))+ub.*Flag4ub+lb.*Flag4lb; 
        %�������Ӧ��ֵ
        fTemp = fobj(Temp);
        if(fTemp<Alpha_score)
            Alpha_score = fTemp;
            Alpha_pos = Temp;
            Positions(indexA,:)=Alpha_pos;     
        end        
    end
        
    
    
    
    %% �Ľ��㣺�������ӸĽ���������ʽ��8��   
    if(l/Max_iter<w)
        a = 2 - l/(w*Max_iter);
    else
        a = (1 - l/Max_iter)/(1-w);
    end
    
    % Update the Position of search agents including omegas
    for i=1:size(Positions,1)
        for j=1:size(Positions,2)     
                       
            r1=rand(); % r1 is a random number in [0,1]
            r2=rand(); % r2 is a random number in [0,1]
            
            A1=2*a*r1-a; % Equation (3.3)
           %% �Ľ��㣺������ʽ��9��
            r2=rand() + 0.5;
            C1=2*r2-a; % Equation (3.4)
            
            D_alpha=abs(C1*Alpha_pos(j)-Positions(i,j)); % Equation (3.5)-part 1
            X1=Alpha_pos(j)-A1*D_alpha; % Equation (3.6)-part 1
                       
            r1=rand();
            r2=rand();
            
            A2=2*a*r1-a; % Equation (3.3)
            %% �Ľ��㣺������ʽ��9��
            r2=rand() + 0.5;
            C2=2*r2-a; % Equation (3.4)
            
            D_beta=abs(C2*Beta_pos(j)-Positions(i,j)); % Equation (3.5)-part 2
            X2=Beta_pos(j)-A2*D_beta; % Equation (3.6)-part 2       
            
            r1=rand();
            r2=rand(); 
            
            A3=2*a*r1-a; % Equation (3.3)
           %% �Ľ��㣺������ʽ��9��
            r2=rand() + 0.5;
            C3=2*r2-a; % Equation (3.4)
            
            D_delta=abs(C3*Delta_pos(j)-Positions(i,j)); % Equation (3.5)-part 3
            X3=Delta_pos(j)-A3*D_delta; % Equation (3.5)-part 3             
            
            Positions(i,j)=(X1+X2+X3)/3;% Equation (3.7)
            
        end
    end
    l=l+1;    
    Convergence_curve(l)=Alpha_score;
end



