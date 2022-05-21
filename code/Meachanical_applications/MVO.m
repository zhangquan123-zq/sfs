function [Best_universe_Inflation_rate, Best_universe, Convergence_curve] = MVO(Universes, N, Max_time, lb, ub, dim, fobj)

%% ��ʼ���׶�
% ������������λ�ú�������(��Ӧ��)����������
Best_universe = zeros(1, dim);
Best_universe_Inflation_rate = inf;

% ��ʼ������λ��
% Universes = initialization(N, dim, ub, lb);

% �涴���ڸ��ʵ���Сֵ�����ֵ
% Eq.(3.3) 
WEP_Max = 1;
WEP_Min = 0.2;

Convergence_curve = zeros(1, Max_time);

% ����������
Time=1;

%% ����Ѱ�Ž׶�
while Time < Max_time+1
    
    % Eq. (3.3)
    WEP = WEP_Min+Time*((WEP_Max-WEP_Min)/Max_time);
    
    % �н�������--Eq. (3.4) 
    TDR = 1-((Time)^(1/6)/(Max_time)^(1/6));
    
    % ������(��Ӧ��ֵ)
    Inflation_rates = zeros(1, N);
    
    for i = 1:N
        % �߽紦��
        Flag4ub = Universes(i, :) > ub';
        Flag4lb = Universes(i, :) < lb';
        Universes(i, :) = (Universes(i, :).*(~(Flag4ub+Flag4lb)))+ub'.*Flag4ub+lb'.*Flag4lb;       
        % ���������������(��Ӧ��ֵ)
        Inflation_rates(i) = fobj(Universes(i, :));
        % ��Ӣ����
        if Inflation_rates(i) < Best_universe_Inflation_rate
            Best_universe_Inflation_rate = Inflation_rates(i);
            Best_universe = Universes(i, :);
        end
        
    end
    
    [sorted_Inflation_rates, sorted_indexes] = sort(Inflation_rates);
    
    for newindex = 1:N
        Sorted_universes(newindex, :) = Universes(sorted_indexes(newindex), :);
    end
    
    % ��׼��������(����Eq. (3.1) �е�NI��
    normalized_sorted_Inflation_rates = normr(sorted_Inflation_rates);
    
    Universes(1, :) = Sorted_universes(1, :);
    
    % ��������λ��
    for i = 2:N                     % ��2��ʼ����Ϊ��һ���Ǿ�Ӣ
        Back_hole_index = i;
        for j = 1:dim
            r1 = rand();
            if r1 < normalized_sorted_Inflation_rates(i)
                White_hole_index = RouletteWheelSelection(-sorted_Inflation_rates);  % ����������� -sorted_Inflation_ratesӦдΪsorted_Inflation_rates
                if White_hole_index == -1
                    White_hole_index = 1;
                end
                % Eq. (3.1) 
                Universes(Back_hole_index, j) = Sorted_universes(White_hole_index, j);
            end
            
            r2 = rand();
            if r2 < WEP
                r3 = rand();
                if r3 < 0.5
                    Universes(i, j) = Best_universe(1, j)+TDR*((ub(j)-lb(j))*rand+lb(j));
                end
                if r3 > 0.5
                    Universes(i, j) = Best_universe(1, j)-TDR*((ub(j)-lb(j))*rand+lb(j));
                end
            end
        end
    end
    
    % ������������
    Convergence_curve(Time) = Best_universe_Inflation_rate;
    
    % ��ʾ�������λ�ú���Ӧ��
    display(['MVO: At iteration ', num2str(Time), ' the best universes fitness is ', num2str(Best_universe_Inflation_rate)]);
    
    Time = Time+1;
end



