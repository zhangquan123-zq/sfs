%% ����Ⱥ�㷨
function [Best_score,Best_pos,curve]=PSO(X,pop,Max_iter,lb,ub,dim,fobj)%��Ⱥ���� �������� �Ͻ� �½� ά�� ���� 
Vmax = 10;
Vmin = - 10;
%% ��������
w = 0.9;      % ��������
c1 = 1.5;       % ���ٳ���
c2 = 2;       % ���ٳ���

Dim = dim;            % ά��
sizepop = pop;       % ����Ⱥ��ģ
maxiter  = Max_iter;      % ����������
if(max(size(ub)) == 1)
   ub = ub.*ones(1,dim);
   lb = lb.*ones(1,dim);  
end
fun = fobj; %��Ӧ�Ⱥ���

%% ����Ⱥ��ʼ��
Range = ones(sizepop,1)*(ub-lb);
pop = X;    % ��ʼ������Ⱥ
V = rand(sizepop,Dim)*(Vmax-Vmin) + Vmin;                 % ��ʼ���ٶ�
fitness = zeros(sizepop,1);
for i=1:sizepop
    fitness(i,:) = fun(pop(i,:));                         % ����Ⱥ����Ӧֵ
end

%% ���弫ֵ��Ⱥ�弫ֵ
[bestf, bestindex]=min(fitness);
zbest=pop(bestindex,:);   % ȫ�����
gbest=pop;                % �������
fitnessgbest=fitness;              % ���������Ӧֵ
fitnesszbest=bestf;               % ȫ�������Ӧֵ

%% ����Ѱ��
iter = 0;
while( (iter < maxiter ))
    for j=1:sizepop
        % �ٶȸ���
        V(j,:) = w*V(j,:) + c1*rand*(gbest(j,:) - pop(j,:)) + c2*rand*(zbest - pop(j,:));
        if V(j,:)>Vmax
            V(j,:)=Vmax;
        end
        if V(j,:)<Vmin
            V(j,:)=Vmin;
        end
        % λ�ø���
        pop(j,:)=pop(j,:)+V(j,:);
        for k=1:Dim
            if pop(j,k)>ub(k)
                pop(j,k)=ub(k);
            end
            if pop(j,k)<lb(k)
                pop(j,k)=lb(k);
            end
        end
        % ��Ӧֵ
        fitness(j,:) =fun(pop(j,:));
        % �������Ÿ���
        if fitness(j) < fitnessgbest(j)
            gbest(j,:) = pop(j,:);
            fitnessgbest(j) = fitness(j);
        end
        % Ⱥ�����Ÿ���
        if fitness(j) < fitnesszbest
            zbest = pop(j,:);
            fitnesszbest = fitness(j);
        end
    end
    iter = iter+1;                      % ������������
    curve(iter) = fitnesszbest;
end
%% ��ͼ
Best_pos = zbest;
Best_score = fitnesszbest;
end



