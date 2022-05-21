%% �����������
clear 
clc
for z=16:16
    disp(num2str(z));
    Q=z;
    Q=-10+10*Q;
    ze=z;
    str3=num2str(ze);
   %% ��������
    N = 30;             % ��Ⱥ��ģ
    Function_name = ['F',str3];         % ��F1��F23�Ĳ��Ժ���������
    Max_iteration = 500;           % ����������
    cnt_max = 10;
    % ������ѡ��׼��������ϸ��Ϣ
    [lb, ub, dim, fobj] = Get_Functions_details(Function_name);
    

%     Curve_PSO = zeros(1, Max_iteration);
%     Curve_ABC = zeros(1, Max_iteration);
%     Curve_DE = zeros(1, Max_iteration);
    
    Curve_SMIGWO = zeros(1, Max_iteration);
    Curve_MGWO = zeros(1, Max_iteration);
    Curve_SPTLBO = zeros(1, 167);
    
    Curve_ChOA = zeros(1, Max_iteration);
    Curve_WChOA = zeros(1, Max_iteration);
    Curve_SLWChOA = zeros(1, Max_iteration);

    for cnt = 1:cnt_max
        % ��ʼ����Ⱥλ��
        X = initialization(N, dim, ub, lb);

%         [PSO_Best_score(cnt), PSO_Best_pos(cnt, :), PSO_Curve] = PSO(X, N, Max_iteration, lb, ub, dim, fobj);%����Ⱥ�㷨
%         [ABC_Best_score(cnt), ABC_Best_pos(cnt, :), ABC_Curve] = abc(fobj, N, dim, lb, ub,Max_iteration);%�˹���Ⱥ�㷨
%         [DE_Best_score(cnt), DE_Best_pos(cnt, :), DE_Curve] = DE(N, Max_iteration,  lb, ub, dim,fobj);%��ֽ���
        
        lb2=lb(1);ub2=ub(1);
        [SMIGWO_Best_score(cnt), SMIGWO_Best_pos(cnt, :), SMIGWO_Curve] = SMIGWO(N,Max_iteration,lb2,ub2,dim,fobj);
        
        [MGWO_Best_score(cnt), MGWO_Best_pos(cnt, :), MGWO_Curve] = MGWO(N,Max_iteration,lb2,ub2,dim,fobj);
        
        [SPTLBO_Best_score(cnt), SPTLBO_Best_pos(cnt, :), SPTLBO_Curve] = SPTLBO(N,167,lb,ub,dim,fobj);
        
        X = initialization(N, dim, ub, lb);
        [ChOA_Best_score(cnt), ChOA_Best_pos(cnt, :), ChOA_Curve] = ChOA(X, N, Max_iteration, lb, ub, dim, fobj);%������ԭʼ���㷨
        X = initialization(N, dim, ub, lb);
        [WChOA_Best_score(cnt), WChOA_Best_pos(cnt, :), WChOA_Curve] = WChOA(X, N, Max_iteration, lb, ub, dim, fobj);%��Ȩ�صĺ������㷨
        X = initializationNew_Tent(N, dim, ub2, lb2);
        [SLWChOA_Best_score(cnt), SLWChOA_Best_pos(cnt, :), SLWChOA_Curve] = RLChOA(X, N, Max_iteration, lb, ub, dim, fobj);      

%         Curve_PSO = Curve_PSO + PSO_Curve;
%         Curve_ABC = Curve_ABC + ABC_Curve;
%         Curve_DE = Curve_DE + DE_Curve;
        
        Curve_SMIGWO = Curve_SMIGWO + SMIGWO_Curve;
        Curve_MGWO = Curve_MGWO + MGWO_Curve;
        Curve_SPTLBO = Curve_SPTLBO + SPTLBO_Curve;
        
        Curve_ChOA = Curve_ChOA+ChOA_Curve;
        Curve_WChOA = Curve_WChOA+WChOA_Curve;
        Curve_SLWChOA = Curve_SLWChOA+SLWChOA_Curve;

    end
%     Curve_PSO = Curve_PSO/cnt_max;
%     Curve_ABC = Curve_ABC/cnt_max;
%     Curve_DE = Curve_DE/cnt_max;
    
    Curve_SMIGWO = Curve_SMIGWO/cnt_max;
    Curve_MGWO = Curve_MGWO/cnt_max;
    Curve_SPTLBO = Curve_SPTLBO/cnt_max;
    
    Curve_ChOA = Curve_ChOA/cnt_max;
    Curve_WChOA = Curve_WChOA/cnt_max;
    Curve_SLWChOA = Curve_SLWChOA/cnt_max;

%     std_PSO = std(PSO_Best_score);
%     std_ABC = std(ABC_Best_score);
%     std_DE = std(DE_Best_score);
    
    std_SMIGWO = std(SMIGWO_Best_score);
    std_MGWO = std(MGWO_Best_score);
    std_SPTLBO = std(SPTLBO_Best_score);
    
    std_ChOA = std(ChOA_Best_score);
    std_WChOA = std(WChOA_Best_score);
    std_SLWChOA = std(SLWChOA_Best_score);

%     worst_PSO = max(PSO_Best_score);
%     worst_ABC = max(ABC_Best_score);
%     worst_DE = max(DE_Best_score);
%     
    worst_SMIGWO = max(SMIGWO_Best_score);
    worst_MGWO = max(MGWO_Best_score);
    worst_SPTLBO = max(SPTLBO_Best_score);
    
    worst_ChOA = max(ChOA_Best_score);
    worst_WChOA = max(WChOA_Best_score);
    worst_SLWChOA = max(SLWChOA_Best_score);

%     best_PSO = min(PSO_Best_score);
%     best_ABC = min(ABC_Best_score);
%     best_DE = min(DE_Best_score);
    
    best_SMIGWO = min(SMIGWO_Best_score);
    best_MGWO = min(MGWO_Best_score);
    best_SPTLBO = min(SPTLBO_Best_score);
    
    best_ChOA = min(ChOA_Best_score);
    best_WChOA = min(WChOA_Best_score);
    best_SLWChOA = min(SLWChOA_Best_score);

%     mean_PSO = mean(PSO_Best_score);
%     mean_ABC = mean(ABC_Best_score);
%     mean_DE = mean(DE_Best_score);
    
    mean_SMIGWO = mean(SMIGWO_Best_score);
    mean_MGWO = mean(MGWO_Best_score);
    mean_SPTLBO = mean(SPTLBO_Best_score);
    
    mean_ChOA = mean(ChOA_Best_score);
    mean_WChOA = mean(WChOA_Best_score);
    mean_SLWChOA = mean(SLWChOA_Best_score);

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
    t2= 1:167;


    ylim([-2,10]);
%     semilogy(t,Curve_PSO,'-','color',[0,0,1],'Linewidth',2.5,'markerindices',1:10:length(t));
    plot(t,Curve_SMIGWO,'-','color',[0.5,0.5,0.5],'Linewidth',2.5,'markerindices',1:10:length(t));
    hold on
%     semilogy(t,Curve_ABC,'-','color',[0,1,0],'Linewidth',2.5,'markerindices',1:10:length(t));
%     semilogy(t,Curve_DE,'-','color',[0,0,0],'Linewidth',2.5,'markerindices',1:10:length(t));
    
%     semilogy(t,Curve_SMIGWO,'-','color',[0.5,0.5,0.5],'Linewidth',2.5,'markerindices',1:10:length(t));
    plot(t,Curve_MGWO,'-','color',[1,0.5,0.5],'Linewidth',2.5,'markerindices',1:10:length(t));
    plot(t2,Curve_SPTLBO,'-','color',[0.5,0.7,0.5],'Linewidth',2.5,'markerindices',1:10:length(t2));
    
    plot(t,Curve_ChOA,'-','color',[1,0,0],'Linewidth',2.5,'markerindices',1:10:length(t));
    plot(t,Curve_WChOA,'-','color',[1,0,1],'Linewidth',2.5,'markerindices',1:10:length(t));
    plot(t,Curve_SLWChOA,'-','color',[0,1,1],'Linewidth',2.5,'markerindices',1:10:length(t));
    title(Function_name)
    xlabel('Iteration');
    ylabel('Function values');
    axis fill
    grid on
    box on %ȫ���ǰ��
    set(gca,'xlim',[0,500],'xtick',[0:50:500])
    legend('SMIGWO','MGWO','SPTLBO','ChOA','WChOA','RL-ChOA');
    %legend('TACPSO','MPSO','TLBO', 'RL-GWO','ROL-GWO', 'ChOA', 'SChOA','WChOA','SLWChOA');

    %% ��ʾ���
%     disp(['������', num2str(Function_name)]);
%     disp(['PSO�����ֵ: ', num2str(worst_PSO), ',����ֵ: ', num2str(best_PSO), ',ƽ��ֵ: ', num2str(mean_PSO), ',��׼��: ', num2str(std_PSO), ...
%         ',�Ⱥͼ���: ', num2str(ranksum(PSO_Best_score, SLWChOA_Best_score))]);
%     [P1,H1]=ranksum(PSO_Best_score, SLWChOA_Best_score);
%     xlswrite('shuju2.xlsx',best_PSO,'sheet1',['C',num2str(2+Q)]);
%     xlswrite('shuju2.xlsx',mean_PSO,'sheet1',['C',num2str(3+Q)]);
%     xlswrite('shuju2.xlsx',worst_PSO,'sheet1',['C',num2str(4+Q)]);
%     xlswrite('shuju2.xlsx',std_PSO,'sheet1',['C',num2str(5+Q)]);
%     xlswrite('shuju2.xlsx',P1,'sheet1',['C',num2str(6+Q)]);
%     xlswrite('shuju2.xlsx',H1,'sheet1',['C',num2str(7+Q)]);
%     
% 
%     disp(['ABC�����ֵ: ', num2str(worst_ABC), ',����ֵ: ', num2str(best_ABC), ',ƽ��ֵ: ', num2str(mean_ABC), ',��׼��: ', num2str(std_ABC), ...
%         ',�Ⱥͼ���: ', num2str(ranksum(ABC_Best_score, SLWChOA_Best_score))]);
%     [P2,H2]=ranksum(ABC_Best_score, SLWChOA_Best_score);
%     xlswrite('shuju2.xlsx',best_ABC,'sheet1',['D',num2str(2+Q)]);
%     xlswrite('shuju2.xlsx',mean_ABC,'sheet1',['D',num2str(3+Q)]);
%     xlswrite('shuju2.xlsx',worst_ABC,'sheet1',['D',num2str(4+Q)]);
%     xlswrite('shuju2.xlsx',std_ABC,'sheet1',['D',num2str(5+Q)]);
%     xlswrite('shuju2.xlsx',P2,'sheet1',['D',num2str(6+Q)]);
%     xlswrite('shuju2.xlsx',H2,'sheet1',['D',num2str(7+Q)]);
%     
%     
%     disp(['DE�����ֵ: ', num2str(worst_DE), ',����ֵ: ', num2str(best_DE), ',ƽ��ֵ:', num2str(mean_DE), ',��׼��: ', num2str(std_DE), ...
%         ',�Ⱥͼ���: ', num2str(ranksum(DE_Best_score, SLWChOA_Best_score))]);
%     [P3,H3]=ranksum(DE_Best_score, SLWChOA_Best_score);
%     xlswrite('shuju2.xlsx',best_DE,'sheet1',['E',num2str(2+Q)]);
%     xlswrite('shuju2.xlsx',mean_DE,'sheet1',['E',num2str(3+Q)]);
%     xlswrite('shuju2.xlsx',worst_DE,'sheet1',['E',num2str(4+Q)]);
%     xlswrite('shuju2.xlsx',std_DE,'sheet1',['E',num2str(5+Q)]);
%     xlswrite('shuju2.xlsx',P3,'sheet1',['E',num2str(6+Q)]);
%     xlswrite('shuju2.xlsx',H3,'sheet1',['E',num2str(7+Q)]);
    
    
    disp(['SMIGWO�����ֵ: ', num2str(worst_SMIGWO), ',����ֵ: ', num2str(best_SMIGWO), ',ƽ��ֵ:', num2str(mean_SMIGWO), ',��׼��: ', num2str(std_SMIGWO), ...
        ',�Ⱥͼ���: ', num2str(ranksum(SMIGWO_Best_score, SLWChOA_Best_score))]);
    [P4,H4]=ranksum(SMIGWO_Best_score, SLWChOA_Best_score);
%     xlswrite('shuju2.xlsx',best_SMIGWO,'sheet1',['F',num2str(2+Q)]);
%     xlswrite('shuju2.xlsx',mean_SMIGWO,'sheet1',['F',num2str(3+Q)]);
%     xlswrite('shuju2.xlsx',worst_SMIGWO,'sheet1',['F',num2str(4+Q)]);
%     xlswrite('shuju2.xlsx',std_SMIGWO,'sheet1',['F',num2str(5+Q)]);
%     xlswrite('shuju2.xlsx',P4,'sheet1',['F',num2str(6+Q)]);
%     xlswrite('shuju2.xlsx',H4,'sheet1',['F',num2str(7+Q)]);

    disp(['MGWO�����ֵ: ', num2str(worst_MGWO), ',����ֵ: ', num2str(best_MGWO), ',ƽ��ֵ:', num2str(mean_MGWO), ',��׼��: ', num2str(std_MGWO), ...
        ',�Ⱥͼ���: ', num2str(ranksum(MGWO_Best_score, SLWChOA_Best_score))]);
    [P5,H5]=ranksum(MGWO_Best_score, SLWChOA_Best_score);
%     xlswrite('shuju2.xlsx',best_MGWO,'sheet1',['G',num2str(2+Q)]);
%     xlswrite('shuju2.xlsx',mean_MGWO,'sheet1',['G',num2str(3+Q)]);
%     xlswrite('shuju2.xlsx',worst_MGWO,'sheet1',['G',num2str(4+Q)]);
%     xlswrite('shuju2.xlsx',std_MGWO,'sheet1',['G',num2str(5+Q)]);
%     xlswrite('shuju2.xlsx',P5,'sheet1',['G',num2str(6+Q)]);
%     xlswrite('shuju2.xlsx',H5,'sheet1',['G',num2str(7+Q)]);
    
    disp(['SPTLBO�����ֵ: ', num2str(worst_SPTLBO), ',����ֵ: ', num2str(best_SPTLBO), ',ƽ��ֵ:', num2str(mean_SPTLBO), ',��׼��: ', num2str(std_SPTLBO), ...
        ',�Ⱥͼ���: ', num2str(ranksum(SPTLBO_Best_score, SLWChOA_Best_score))]);
    [P6,H6]=ranksum(SPTLBO_Best_score, SLWChOA_Best_score);
%     xlswrite('shuju2.xlsx',best_SPTLBO,'sheet1',['H',num2str(2+Q)]);
%     xlswrite('shuju2.xlsx',mean_SPTLBO,'sheet1',['H',num2str(3+Q)]);
%     xlswrite('shuju2.xlsx',worst_SPTLBO,'sheet1',['H',num2str(4+Q)]);
%     xlswrite('shuju2.xlsx',std_SPTLBO,'sheet1',['H',num2str(5+Q)]);
%     xlswrite('shuju2.xlsx',P6,'sheet1',['H',num2str(6+Q)]);
%     xlswrite('shuju2.xlsx',H6,'sheet1',['H',num2str(7+Q)]);

    disp(['ChOA�����ֵ: ', num2str(worst_ChOA), ',����ֵ: ', num2str(best_ChOA), ',ƽ��ֵ: ', num2str(mean_ChOA), ',��׼��: ', num2str(std_ChOA), ...
        ',�Ⱥͼ���: ', num2str(ranksum(ChOA_Best_score, SLWChOA_Best_score))]);
    [P7,H7]=ranksum(ChOA_Best_score, SLWChOA_Best_score);
%     xlswrite('shuju2.xlsx',best_ChOA,'sheet1',['I',num2str(2+Q)]);
%     xlswrite('shuju2.xlsx',mean_ChOA,'sheet1',['I',num2str(3+Q)]);
%     xlswrite('shuju2.xlsx',worst_ChOA,'sheet1',['I',num2str(4+Q)]);
%     xlswrite('shuju2.xlsx',std_ChOA,'sheet1',['I',num2str(5+Q)]);
%     xlswrite('shuju2.xlsx',P7,'sheet1',['I',num2str(6+Q)]);
%     xlswrite('shuju2.xlsx',H7,'sheet1',['I',num2str(7+Q)]);
    
    disp(['WChOA�����ֵ: ', num2str(worst_WChOA), ',����ֵ: ', num2str(best_WChOA), ',ƽ��ֵ: ', num2str(mean_WChOA), ',��׼��: ', num2str(std_WChOA), ...
        ',�Ⱥͼ���: ', num2str(ranksum(WChOA_Best_score, SLWChOA_Best_score))]);
    [P8,H8]=ranksum(WChOA_Best_score, SLWChOA_Best_score);
%     xlswrite('shuju2.xlsx',best_WChOA,'sheet1',['J',num2str(2+Q)]);
%     xlswrite('shuju2.xlsx',mean_WChOA,'sheet1',['J',num2str(3+Q)]);
%     xlswrite('shuju2.xlsx',worst_WChOA,'sheet1',['J',num2str(4+Q)]);
%     xlswrite('shuju2.xlsx',std_WChOA,'sheet1',['J',num2str(5+Q)]);
%     xlswrite('shuju2.xlsx',P8,'sheet1',['J',num2str(6+Q)]);
%     xlswrite('shuju2.xlsx',H8,'sheet1',['J',num2str(7+Q)]);
    
    
    disp(['SLWChOA�����ֵ: ', num2str(worst_SLWChOA), ',����ֵ: ', num2str(best_SLWChOA), ',ƽ��ֵ:', num2str(mean_SLWChOA), ',��׼��: ', num2str(std_SLWChOA), ...
        ',�Ⱥͼ���: ', num2str(ranksum(SLWChOA_Best_score, SLWChOA_Best_score))]);
    [P9,H9]=ranksum(SLWChOA_Best_score, SLWChOA_Best_score);
%     xlswrite('shuju2.xlsx',best_SLWChOA,'sheet1',['K',num2str(2+Q)]);
%     xlswrite('shuju2.xlsx',mean_SLWChOA,'sheet1',['K',num2str(3+Q)]);
%     xlswrite('shuju2.xlsx',worst_SLWChOA,'sheet1',['K',num2str(4+Q)]);
%     xlswrite('shuju2.xlsx',std_SLWChOA,'sheet1',['K',num2str(5+Q)]);
%     xlswrite('shuju2.xlsx',P6,'sheet1',['K',num2str(6+Q)]);
%     xlswrite('shuju2.xlsx',H6,'sheet1',['K',num2str(7+Q)]);
 
end



