%% ˮ����̬����Ӧ����
clear;
clc;

%% 
Max_iter = 1000;

for t = 1:Max_iter
%     lambda(t) = 1-rands(1)/Max_iter*sin(pi*t/(2*Max_iter)+2*pi);
    lambda(t) = 1-sin(pi*t/(2*Max_iter)+2*pi);
end

%% ��ͼ
figure;
plot(lambda, 'r', 'linewidth', 1);
xlabel '��������'; ylabel 'ˮ����ֵ̬';

