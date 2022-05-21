function [Alpha_score, Alpha_pos, Convergence_curve] = GWO(X, N, Max_iter, lb, ub, dim, fobj)
%% �����Ż��㷨
% ��ʼ��alpha, beta��delta_pos
Alpha_pos = zeros(1, dim);
Alpha_score = inf;  % ���˸���Ϊ-inf�Խ���������
Beta_pos = zeros(1,dim);
Beta_score = inf;    % ���˸���Ϊ-inf�Խ���������
Delta_pos = zeros(1,dim);
Delta_score = inf;   % ���˸���Ϊ-inf�Խ���������
Convergence_curve = zeros(1, Max_iter);  % ��������
l = 0;    % ѭ��������
% ��Ҫѭ��
while l < Max_iter
    for i = 1:N
        % �߽紦��
        Flag4ub = X(i, :)>ub';
        Flag4lb = X(i, :)<lb';
        X(i, :) = (X(i, :).*(~(Flag4ub+Flag4lb)))+ub'.*Flag4ub+lb'.*Flag4lb;
        % ����ÿ����Ⱥ��Ŀ�꺯��
        fitness = fobj(X(i, :));
        % ����Alpha, Beta��Delta
        if fitness < Alpha_score
            Alpha_score = fitness;        % ����alpha
            Alpha_pos = X(i, :);
        end
        if fitness > Alpha_score && fitness < Beta_score
            Beta_score = fitness;           % ����beta
            Beta_pos = X(i, :);
        end
        if fitness > Alpha_score && fitness > Beta_score && fitness < Delta_score
            Delta_score = fitness;          % ����delta
            Delta_pos = X(i, :);
        end
    end
    a = 2-l*((2)/Max_iter);      % a��2���Լ�С��0    
    % ���°���omegas���ڵ���Ⱥ��λ��
    for i = 1:N
        for j = 1:dim
            r1 = rand();             % r1��[0,1]�е������
            r2 = rand();             % r2��[0,1]�е������
            
            A1 = 2*a*r1-a;        % ��ʽ��4��
            C1 = 2*r2;               % ��ʽ��5��
            
            D_alpha = abs(C1*Alpha_pos(j)-X(i, j));  % ��ʽ��6��-��һ����
            X1 = Alpha_pos(j)-A1*D_alpha;   % ��ʽ (7)-��һ����
            
            r1 = rand();
            r2 = rand();
            
            A2 = 2*a*r1-a;         % ��ʽ��4��
            C2 = 2*r2;                % ��ʽ��5��
            
            D_beta = abs(C2*Beta_pos(j)-X(i, j));   % ��ʽ��6��-�ڶ�����
            X2 = Beta_pos(j)-A2*D_beta;       % ��ʽ (7)-�ڶ�����
            
            r1 = rand();
            r2 = rand();
            
            A3 = 2*a*r1-a;        % ��ʽ (4)
            C3 = 2*r2;               % ��ʽ (5)
            
            D_delta = abs(C3*Delta_pos(j)-X(i, j)); % ��ʽ��6��-��������
            X3 = Delta_pos(j)-A3*D_delta;      % ��ʽ (7)-��������
            
            X(i, j)=(X1+X2+X3)/3;       % ��ʽ (8)
        end
    end
    l = l+1;
    Convergence_curve(l) = Alpha_score;
    disp(['GWO: At iteration ', num2str(l), ' ,the best fitness is ', num2str(Alpha_score)]);
end
