clear
clc
N=30;
Function_name = ['F','1'];         % ��F1��F23�Ĳ��Ժ���������
Max_iteration = 5;           % ����������
% ������ѡ��׼��������ϸ��Ϣ
[lb, ub, dim, fobj] = Get_Functions_details(Function_name);

X = initialization(N, dim, ub, lb);
[XX,ChOA_Best_score(1), ChOA_Best_pos(1, :), ChOA_Curve] = ChOA(X, N, Max_iteration, lb, ub, dim, fobj);%������ԭʼ���㷨
a=XX(:,1:1)
b=XX(:,2:2);
plot(a,b,'ob')
hold on;
xlim([-10,10]);
ylim([-10,10]);
a1=0;b1=0;
plot(a1,b1,'*r');
xlabel('X1');
ylabel('X2');
legend('chimps','gbest');
title('Iteration = 5')
