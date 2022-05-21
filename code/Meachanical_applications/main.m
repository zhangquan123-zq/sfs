%% �����������
clear 
clc

%% ��������
N = 30;             % ��Ⱥ��ģ
Function_name = 'F2';         % ��F1��F3�Ĳ��Ժ���������
Max_iteration = 1000;           % ����������
cnt_max = 10;
% ������ѡ��׼��������ϸ��Ϣ
[lb, ub, dim, fobj] = Get_Functions_details(Function_name);

Curve_SCA = zeros(1, Max_iteration);
Curve_GWO = zeros(1, Max_iteration);
Curve_MVO = zeros(1, Max_iteration);
Curve_SSA = zeros(1, Max_iteration);
Curve_ChOA = zeros(1, Max_iteration);
Curve_SLWChOA = zeros(1, Max_iteration);

for cnt = 1:cnt_max
    % ��ʼ����Ⱥλ��
    X = initialization(N, dim, ub, lb);
    
    [SCA_Best_score(cnt), SCA_Best_pos(cnt, :), SCA_Curve] = SCA(X, N, Max_iteration, lb, ub, dim, fobj);
    [GWO_Best_score(cnt), GWO_Best_pos(cnt, :), GWO_Curve] = GWO(X, N, Max_iteration, lb, ub, dim, fobj);
    [MVO_Best_score(cnt), MVO_Best_pos(cnt, :), MVO_Curve] = MVO(X, N, Max_iteration, lb, ub, dim, fobj);
    [SSA_Best_score(cnt), SSA_Best_pos(cnt, :), SSA_Curve] = SSA(X, N, Max_iteration, lb, ub, dim, fobj);
    [ChOA_Best_score(cnt), ChOA_Best_pos(cnt, :), ChOA_Curve] = ChOA(X, N, Max_iteration, lb, ub, dim, fobj);    
    [SLWChOA_Best_score(cnt), SLWChOA_Best_pos(cnt, :), SLWChOA_Curve] = SLWChOA(X, N, Max_iteration, lb, ub, dim, fobj);
    
    
    Curve_SCA = Curve_SCA+SCA_Curve;
    Curve_GWO = Curve_GWO+GWO_Curve;
    Curve_MVO = Curve_MVO+MVO_Curve;
    Curve_SSA = Curve_SSA+SSA_Curve;
    Curve_ChOA = Curve_ChOA+ChOA_Curve;
    Curve_SLWChOA = Curve_SLWChOA+SLWChOA_Curve;
    
end

Curve_SCA = Curve_SCA/cnt_max;
Curve_GWO = Curve_GWO/cnt_max;
Curve_MVO = Curve_MVO/cnt_max;
Curve_SSA = Curve_SSA/cnt_max;
Curve_ChOA = Curve_ChOA/cnt_max;
Curve_SLWChOA = Curve_SLWChOA/cnt_max;

std_SCA = std(SCA_Best_score);
std_GWO = std(GWO_Best_score);
std_MVO = std(MVO_Best_score);
std_SSA = std(SSA_Best_score);
std_ChOA = std(ChOA_Best_score);
std_SLWChOA = std(SLWChOA_Best_score);

worst_SCA = max(SCA_Best_score);
worst_GWO = max(GWO_Best_score);
worst_MVO = max(MVO_Best_score);
worst_SSA = max(SSA_Best_score);
worst_ChOA = max(ChOA_Best_score);
worst_SLWChOA = max(SLWChOA_Best_score);

best_SCA = min(SCA_Best_score);
best_GWO = min(GWO_Best_score);
best_MVO = min(MVO_Best_score);
best_SSA = min(SSA_Best_score);
best_ChOA = min(ChOA_Best_score);
best_SLWChOA = min(SLWChOA_Best_score);

mean_SCA = mean(SCA_Best_score);
mean_GWO = mean(GWO_Best_score);
mean_MVO = mean(MVO_Best_score);
mean_SSA = mean(SSA_Best_score);
mean_ChOA = mean(ChOA_Best_score);
mean_SLWChOA = mean(SLWChOA_Best_score);

%% ��ͼ
% ����Ŀ�꺯��ֵ�仯����ͼ
figure;
t = 1:Max_iteration;
semilogy(t, Curve_SCA, 'cx-', t, Curve_GWO, 'bs-', t, Curve_MVO, 'k*-', ...
    t, Curve_SSA, 'g^-', t, Curve_ChOA, 'mo-', t, Curve_SLWChOA, 'rd-',...
    'linewidth', 1.5, 'MarkerSize', 8, 'MarkerIndices', 1:50:Max_iteration);
% title ('\fontsize{15}\bf Welded Beam Design');
title ('\fontsize{15}\bf Compression Spring Design');
% title ('\fontsize{15}\bf Pressure Vessel Design');
xlabel('Iteration#');
ylabel('Best Score obtained so far');
axis fill
grid on
box on
legend('SCA', 'GWO', 'MVO', 'SSA', 'ChOA', 'SLWChOA');

%% ��ʾ���
disp(['������', num2str(Function_name)]);
disp(['SCA�����ֵ: ', num2str(worst_SCA), ',����ֵ:', num2str(best_SCA), ',ƽ��ֵ:', num2str(mean_SCA), ',��׼��:', num2str(std_SCA), ...
    ',�Ⱥͼ���:', num2str(ranksum(SCA_Best_score, SLWChOA_Best_score))]);
disp(['GWO�����ֵ: ', num2str(worst_GWO), ',����ֵ:', num2str(best_GWO), ',ƽ��ֵ:', num2str(mean_GWO), ',��׼��:', num2str(std_GWO), ...
    ',�Ⱥͼ���:', num2str(ranksum(GWO_Best_score, SLWChOA_Best_score))]);
disp(['MVO�����ֵ: ', num2str(worst_MVO), ',����ֵ:', num2str(best_MVO), ',ƽ��ֵ:', num2str(mean_MVO), ',��׼��:', num2str(std_MVO), ...
    ',�Ⱥͼ���:', num2str(ranksum(MVO_Best_score, SLWChOA_Best_score))]);
disp(['SSA�����ֵ: ', num2str(worst_SSA), ',����ֵ:', num2str(best_SSA), ',ƽ��ֵ:', num2str(mean_SSA), ',��׼��:', num2str(std_SSA), ...
    ',�Ⱥͼ���:', num2str(ranksum(SSA_Best_score, SLWChOA_Best_score))]);
disp(['ChOA�����ֵ: ', num2str(worst_ChOA), ',����ֵ:', num2str(best_ChOA), ',ƽ��ֵ:', num2str(mean_ChOA), ',��׼��:', num2str(std_ChOA), ...
    ',�Ⱥͼ���:', num2str(ranksum(ChOA_Best_score, SLWChOA_Best_score))]);
disp(['SLWChOA�����ֵ: ', num2str(worst_SLWChOA), ',����ֵ:', num2str(best_SLWChOA), ',ƽ��ֵ:', num2str(mean_SLWChOA), ',��׼��:', num2str(std_SLWChOA), ...
    ',�Ⱥͼ���:', num2str(ranksum(SLWChOA_Best_score, SLWChOA_Best_score))]);



