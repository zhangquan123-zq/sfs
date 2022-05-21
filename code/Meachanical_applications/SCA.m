function [fitnessgbest, gbest, Curve] = SCA(X, N, maxgen, lb, ub, dim, fobj)

%% SCA����
for i = 1:N
    fitness(i) = fobj(X(i, :));
end
% ��ʼ����
[bestfitness, bestindex] = min(fitness);
gbest = X(bestindex, :);              % Ⱥ�����ż�ֵ
fitnessgbest = bestfitness;         % ��Ⱥ������Ӧ��ֵ

%% ����Ѱ��
for t = 1:maxgen
    % Eq. (3.4)
    a = 2;
    r1 = a-t*((a)/maxgen);    % r1��a���Եݼ���0
    % ���¸���λ��
    for i = 1:N
        for j = 1:dim 
            % ��Eq. (3.3)����r2,r3,r4
            r2 = (2*pi)*rand();
            r3 = 2*rand;
            r4 = rand();
            
            % Eq. (3.3)
            if r4 < 0.5
                % Eq. (3.1)
                X(i, j) =  X(i, j)+(r1*sin(r2)*abs(r3*gbest(j)-X(i, j)));
            else
                % Eq. (3.2)
                X(i, j) = X(i, j)+(r1*cos(r2)*abs(r3*gbest(j)-X(i, j)));
            end
        end
    end
    
    for i = 1:N
        % �߽紦��
        Flag4ub = X(i, :) > ub';
        Flag4lb = X(i, :) < lb';
        X(i, :) = (X(i, :).*(~(Flag4ub+Flag4lb)))+ub'.*Flag4ub+lb'.*Flag4lb;
        % ������Ӧ��ֵ
        fitness(i) = fobj(X(i, :));
        
        % �������Ž�
        if fitness(i) < fitnessgbest
            gbest = X(i, :);
            fitnessgbest = fitness(i);
        end
    end
   
    % ��¼ÿ�����Ž�
    Curve(t) = fitnessgbest;
    % ��ʾ������Ϣ
    display(['SCA:At iteration ', num2str(t), ' the best fitness is ', num2str(Curve(t))]);
end

