%% �����������
clear 
clc
for z=7:7
    disp(num2str(z));
    Q=z;
    Q=-7+7*Q;
    ze=z;
    str3=num2str(ze);
   %% ��������
    N = 30;             % ��Ⱥ��ģ
    Function_name = ['F',str3];         % ��F1��F23�Ĳ��Ժ���������
    Max_iteration = 500;           % ����������
    cnt_max = 1;
    % ������ѡ��׼��������ϸ��Ϣ
    [lb, ub, dim, fobj] = Get_Functions_details(Function_name);

    Curve_PSO = zeros(1, Max_iteration);
    Curve_ABC = zeros(1, Max_iteration);
    Curve_DE = zeros(1, Max_iteration);
    Curve_ChOA = zeros(1, Max_iteration);

    for cnt = 1:cnt_max
        % ��ʼ����Ⱥλ��
        X = initialization(N, dim, ub, lb);

        [PSO_Best_score(cnt), PSO_Best_pos(cnt, :), PSO_Curve] = SLWChOA1(X, N, Max_iteration, lb, ub, dim, fobj);
        [ABC_Best_score(cnt), ABC_Best_pos(cnt, :), ABC_Curve] = SLWChOA10(X, N, Max_iteration, lb, ub, dim, fobj);
        [DE_Best_score(cnt), DE_Best_pos(cnt, :), DE_Curve] = SLWChOA100(X, N, Max_iteration, lb, ub, dim, fobj);
        [ChOA_Best_score(cnt), ChOA_Best_pos(cnt, :), ChOA_Curve] = SLWChOA1000(X, N, Max_iteration, lb, ub, dim, fobj);
  

        Curve_PSO = Curve_PSO + PSO_Curve;
        Curve_ABC = Curve_ABC + ABC_Curve;
        Curve_DE = Curve_DE + DE_Curve;
        Curve_ChOA = Curve_ChOA+ChOA_Curve;

    end
    Curve_PSO = Curve_PSO/cnt_max;
    Curve_ABC = Curve_ABC/cnt_max;
    Curve_DE = Curve_DE/cnt_max;
    Curve_ChOA = Curve_ChOA/cnt_max;


    std_PSO = std(PSO_Best_score);
    std_ABC = std(ABC_Best_score);
    std_DE = std(DE_Best_score);
    std_ChOA = std(ChOA_Best_score);


    worst_PSO = max(PSO_Best_score);
    worst_ABC = max(ABC_Best_score);
    worst_DE = max(DE_Best_score);
    worst_ChOA = max(ChOA_Best_score);


    best_PSO = min(PSO_Best_score);
    best_ABC = min(ABC_Best_score);
    best_DE = min(DE_Best_score);
    best_ChOA = min(ChOA_Best_score);

    mean_PSO = mean(PSO_Best_score);
    mean_ABC = mean(ABC_Best_score);
    mean_DE = mean(DE_Best_score);
    mean_ChOA = mean(ChOA_Best_score);

    %% ��ͼ
    % 1��������ѡ��׼��������ά����ͼ��
    figure;
    func_plot(Function_name);
    title(Function_name)
    xlabel('x_1');
    ylabel('x_2');
    zlabel([Function_name,'( x_1 , x_2 )'])

    % 2������Ŀ�꺯��ֵ�仯����ͼ
    figure;
    t = 1:Max_iteration;



    semilogy(t,Curve_PSO,'*-','color',[0,0,1],'Linewidth',1,'markerindices',1:5:length(t));
    hold on
    semilogy(t,Curve_ABC,'p-','color',[0,1,0],'Linewidth',1,'markerindices',1:5:length(t));
    semilogy(t,Curve_DE,'o-','color',[0,0,0],'Linewidth',1,'markerindices',1:5:length(t));
    semilogy(t,Curve_ChOA,'X-','color',[1,0,0],'Linewidth',1,'markerindices',1:5:length(t));

    title('Function_name')
    xlabel('Iteration');
    ylabel('Function values');
    axis fill
    grid on
    box on %ȫ���ǰ��
    set(gca,'xlim',[0,500],'xtick',[0:50:500])
    legend('PSO','ABC','DE','ChOA');
    %legend('TACPSO','MPSO','TLBO', 'RL-GWO','ROL-GWO', 'ChOA', 'SChOA','WChOA','SLWChOA');

    %% ��ʾ���
    disp(['������', num2str(Function_name)]);
    disp(['PSO�����ֵ: ', num2str(worst_PSO), ',����ֵ: ', num2str(best_PSO), ',ƽ��ֵ: ', num2str(mean_PSO), ',��׼��: ', num2str(std_PSO)]);
    xlswrite('shuju_mingandu.xlsx',best_PSO,'sheet1',['C',num2str(2+Q)]);
    xlswrite('shuju_mingandu.xlsx',mean_PSO,'sheet1',['C',num2str(3+Q)]);
    xlswrite('shuju_mingandu.xlsx',worst_PSO,'sheet1',['C',num2str(4+Q)]);
    xlswrite('shuju_mingandu.xlsx',std_PSO,'sheet1',['C',num2str(5+Q)]);
    

    disp(['ABC�����ֵ: ', num2str(worst_ABC), ',����ֵ: ', num2str(best_ABC), ',ƽ��ֵ: ', num2str(mean_ABC), ',��׼��: ', num2str(std_ABC)]);
    xlswrite('shuju_mingandu.xlsx',best_ABC,'sheet1',['D',num2str(2+Q)]);
    xlswrite('shuju_mingandu.xlsx',mean_ABC,'sheet1',['D',num2str(3+Q)]);
    xlswrite('shuju_mingandu.xlsx',worst_ABC,'sheet1',['D',num2str(4+Q)]);
    xlswrite('shuju_mingandu.xlsx',std_ABC,'sheet1',['D',num2str(5+Q)]);
    
    
    disp(['DE�����ֵ: ', num2str(worst_DE), ',����ֵ: ', num2str(best_DE), ',ƽ��ֵ:', num2str(mean_DE), ',��׼��: ', num2str(std_DE)]);
    xlswrite('shuju_mingandu.xlsx',best_DE,'sheet1',['E',num2str(2+Q)]);
    xlswrite('shuju_mingandu.xlsx',mean_DE,'sheet1',['E',num2str(3+Q)]);
    xlswrite('shuju_mingandu.xlsx',worst_DE,'sheet1',['E',num2str(4+Q)]);
    xlswrite('shuju_mingandu.xlsx',std_DE,'sheet1',['E',num2str(5+Q)]);
    
    
    disp(['ChOA�����ֵ: ', num2str(worst_ChOA), ',����ֵ: ', num2str(best_ChOA), ',ƽ��ֵ: ', num2str(mean_ChOA), ',��׼��: ', num2str(std_ChOA)]);
    xlswrite('shuju_mingandu.xlsx',best_ChOA,'sheet1',['F',num2str(2+Q)]);
    xlswrite('shuju_mingandu.xlsx',mean_ChOA,'sheet1',['F',num2str(3+Q)]);
    xlswrite('shuju_mingandu.xlsx',worst_ChOA,'sheet1',['F',num2str(4+Q)]);
    xlswrite('shuju_mingandu.xlsx',std_ChOA,'sheet1',['F',num2str(5+Q)]);
    

 
end



