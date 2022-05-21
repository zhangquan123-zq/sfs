clc;
clear;

%% ������к�Sobol���жԱ�
dim = 2;           % ά��
N = 100;
% Sobol����
p = sobolset(dim);
for i = 1:N
    X(i, :) = p(i, :);
end
figure;
plot(X(:, 1), X(:, 2), 'b.', 'MarkerSize', 16);
% xlabel '�����һά����ֵ'; ylabel '����ڶ�ά����ֵ';
title 'Sobol��������ɢ��ͼ';
% �������
Y = rand(N, dim);
figure;
plot(Y(:, 1), Y(:, 2), 'b.', 'MarkerSize', 16);
% xlabel '�����һά����ֵ'; ylabel '����ڶ�ά����ֵ';
title '������ɸ���ɢ��ͼ';

