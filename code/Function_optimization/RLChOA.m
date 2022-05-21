%% ��ϲ��ԸĽ��ĺ������Ż��㷨(SLWChOA)
function [Attacker_score, Attacker_pos, Convergence_curve] = RLChOA(X, N, Max_iter, lb, ub, dim, fobj)
% ��ʼ��������(Attacker)��������(Barrier)��׷����(Chaser)��������(Driver)
Attacker_pos = zeros(1, dim);
Attacker_score = inf;                  % ����������⣬���˸���Ϊ-inf

Barrier_pos = zeros(1, dim);
Barrier_score = inf;                     % ����������⣬���˸���Ϊ-inf

Chaser_pos = zeros(1, dim);
Chaser_score = inf;                    % ����������⣬���˸���Ϊ-inf

Driver_pos = zeros(1, dim);
Driver_score = inf;                     % ����������⣬���˸���Ϊ-inf

p = sobolset(dim);
% ������Ӧ��ֵ
for i = 1:N
    X(i, :) = p(i+3, :).*(ub-lb)+lb;
end

etamax = 10; etamin = 1;
Convergence_curve = zeros(1, Max_iter);

l = 0;                % ����������

%% ����Ѱ��
while l < Max_iter
    for i = 1:N
        % �߽紦��
        Flag4ub = X(i, :) > ub;
        Flag4lb = X(i, :) < lb;
        X(i, :) = (X(i, :).*(~(Flag4ub+Flag4lb)))+ub.*Flag4ub+lb.*Flag4lb;
        % ����ÿ��������Ӧ��ֵ
        fitness = fobj(X(i, :));
        % ����Attacker, Barrier, Chaser, and Driver
        if fitness < Attacker_score
            Attacker_score = fitness;       % ����Attacker
            Attacker_pos = X(i, :);
        end
        if fitness > Attacker_score && fitness < Barrier_score
            Barrier_score = fitness;          % ����Barrier
            Barrier_pos = X(i, :);
        end       
        if fitness > Attacker_score && fitness > Barrier_score && fitness < Chaser_score
            Chaser_score = fitness;         % ����Chaser
            Chaser_pos = X(i, :);
        end      
        if fitness > Attacker_score && fitness > Barrier_score && fitness > Chaser_score && fitness > Driver_score
            Driver_score = fitness;           % ����Driver
            Driver_pos = X(i, :);
        end
    end
    
    f = 2-l*((2)/Max_iter);                   % f��2���Եݼ���0
    % f�����Ķ�̬ϵ�����1��ʾ
    % Group 1
    C1G1 = 1.95-((2*l^(1/3))/(Max_iter^(1/3)));
    C2G1 = (2*l^(1/3))/(Max_iter^(1/3))+0.5;
    
    % Group 2
    C1G2 = 1.95-((2*l^(1/3))/(Max_iter^(1/3)));
    C2G2 = (2*(l^3)/(Max_iter^3))+0.5;
    
    % Group 3
    C1G3 = (-2*(l^3)/(Max_iter^3))+2.5;
    C2G3 = (2*l^(1/3))/(Max_iter^(1/3))+0.5;
    
    % Group 4
    C1G4 = (-2*(l^3)/(Max_iter^3))+2.5;
    C2G4 = (2*(l^3)/(Max_iter^3))+0.5;
    
    new_Attacker_pos = (lb+ub)/2+(lb+ub)/(2*10)-Attacker_pos/10;
    Flag4ub = new_Attacker_pos > ub;
    Flag4lb = new_Attacker_pos < lb;
    new_Attacker_pos = (new_Attacker_pos.*(~(Flag4ub+Flag4lb)))+ub.*Flag4ub+lb.*Flag4lb;
    if fobj(new_Attacker_pos) < Attacker_score
        Attacker_pos = new_Attacker_pos;
        Attacker_score = fobj(new_Attacker_pos);
    end
    

    
    % �������и���λ��
    for i = 1:N
        for j = 1:dim
            %% ��ע�⣬Ҫѡ�������飬��Ӧ��ʹ����ص������
            r11 = C1G1*rand(); % r1 is a random number in [0,1]
            r12 = C2G1*rand(); % r2 is a random number in [0,1]
            
            r21 = C1G2*rand(); % r1 is a random number in [0,1]
            r22 = C2G2*rand(); % r2 is a random number in [0,1]
            
            r31 = C1G3*rand(); % r1 is a random number in [0,1]
            r32 = C2G3*rand(); % r2 is a random number in [0,1]
            
            r41 = C1G4*rand(); % r1 is a random number in [0,1]
            r42 = C2G4*rand(); % r2 is a random number in [0,1]
            
            A1 = 2*f*r11-f;         % Equation (3)
            C1 = 2*r12;              % Equation (4)
            
            %% 
            m = chaos(3, 1, 1);          % Equation (5)
            D_Attacker = abs(C1*Attacker_pos(j)-m*X(i, j));    % Equation (6)
            X1 = Attacker_pos(j)-A1*D_Attacker;                   % Equation (7)
            
            A2 = 2*f*r21-f;  % Equation (3)
            C2 = 2*r22;       % Equation (4)
            
            D_Barrier = abs(C2*Barrier_pos(j)-m*X(i, j));      % Equation (6)
            X2 = Barrier_pos(j)-A2*D_Barrier;                     % Equation (7)
            
            A3 = 2*f*r31-f;     % Equation (3)
            C3 = 2*r32;          % Equation (4)
            
            D_Driver = abs(C3*Chaser_pos(j)-m*X(i, j));       % Equation (6)
            X3 = Chaser_pos(j)-A3*D_Driver;                      % Equation (7)
            
            A4 = 2*f*r41-f;     % Equation (3)
            C4 = 2*r42;          % Equation (4)
            
            D_Driver = abs(C4*Driver_pos(j)-m*X(i, j));         % Equation (6)
            X4 = Chaser_pos(j)-A4*D_Driver;                       % Equation (7)
            
            X(i, j) = (X1+X2+X3+X4)/4;              % Equation (8)
            
        end
    end
    l = l+1;
    Convergence_curve(l) = Attacker_score;
    %disp(['SLWChOA: At iteration ', num2str(l), ' ,the best fitness is ', num2str(Convergence_curve(l))]);
end



