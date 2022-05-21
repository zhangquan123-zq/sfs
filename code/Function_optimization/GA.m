%_________________________________________________________________________%
%�Ŵ��㷨             %
%_________________________________________________________________________%
function [Best_score,Best_pos,curve]=GA(pop,Max_iter,lb,ub,dim,fobj)
%% ������ʼ��
popsize=pop;              %��Ⱥ��ģ
lenchrom=dim;              %�����ִ�����
fun = fobj;  %��Ӧ�Ⱥ���
pc=0.7;                  %���ý������
pm=0.3;                  %���ñ������
if(max(size(ub)) == 1)
   ub = ub.*ones(dim,1);
   lb = lb.*ones(dim,1);  
end
maxgen=Max_iter;   % ��������  
%��Ⱥ
bound=[lb,ub];  %������Χ

%% ������ʼ���Ӻ��ٶ�
for i=1:popsize
    %�������һ����Ⱥ
    GApop(i,:)=Code(lenchrom,bound);       %�����������
    %������Ӧ��
    [fitness(i)]=fun(GApop(i,:));            %Ⱦɫ�����Ӧ��
end

%����õ�Ⱦɫ��
[bestfitness bestindex]=min(fitness);
zbest=GApop(bestindex,:);   %ȫ�����
gbest=GApop;                %�������
fitnessgbest=fitness;       %���������Ӧ��ֵ
fitnesszbest=bestfitness;   %ȫ�������Ӧ��ֵ
%% ����Ѱ��
for i=1:maxgen
        disp(['��',num2str(i),'�ε���'])
        %��Ⱥ���� GAѡ�����
        GApop=Select2(GApop,fitness,popsize);

        % ������� GA
        GApop=Cross(pc,lenchrom,GApop,popsize,bound);

        % ������� GA����
        GApop=Mutation(pm,lenchrom,GApop,popsize,[i maxgen],bound);

        pop=GApop;
        
      for j=1:popsize
        %��Ӧ��ֵ
        [fitness(j)]=fun(pop(j,:));
        %�������Ÿ���
        if fitness(j) < fitnessgbest(j)
            gbest(j,:) = pop(j,:);
            fitnessgbest(j) = fitness(j);
        end
        
        %Ⱥ�����Ÿ���
        if fitness(j) < fitnesszbest
            zbest = pop(j,:);
            fitnesszbest = fitness(j);
        end
        
    end
    
    curve(i)=fitnesszbest;     
end
Best_score = fitnesszbest;
Best_pos = zbest;
end