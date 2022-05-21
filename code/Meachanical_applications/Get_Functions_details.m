%% ���Ժ���
function [lb,ub,dim,fobj] = Get_Functions_details(F)


switch F
    %% �������������(Welded Beam Design, WBD)
    case 'F1'
        fobj = @F1;
        lb = [0.10; 0.10; 0.10; 0.10];  % �½�
        ub = [2; 10; 10; 2];               % �Ͻ�
        dim = 4;
        
    %% ѹ�������������(Compression Spring Design, CSD)
    case 'F2'
        fobj = @F2;
        lb = [0.05; 0.25; 2.00];   % �½�
        ub = [2.00; 1.30; 15.0];        % �Ͻ�
        dim = 3;
        
    %% ѹ�������������(Pressure Vessel Design, PVD)
    case 'F3'
        fobj = @F3;
        lb = [0; 0; 10; 10];           % �½�
        ub = [99; 99; 200; 200];        % �Ͻ�
        dim = 4;
        
end

end

% F1

function PHI = F1(x)
P = 6000;                         % ĩ���غ� APPLIED TIP LOAD
E = 30e6;                         % ��������ģ�� YOUNGS MODULUS OF BEAM
G = 12e6;                        % ���ļ���ģ�� SHEAR MODULUS OF BEAM
tem = 14;                        % �������۲��ֳ��� LENGTH OF CANTILEVER PART OF BEAM
PCONST = 100000;          % ���������� PENALTY FUNCTION CONSTANT
TAUMAX = 13600;           % ���������Ӧ�� MAXIMUM ALLOWED SHEAR STRESS
SIGMAX = 30000;            % �����������Ӧ�� MAXIMUM ALLOWED BENDING STRESS
DELTMAX = 0.25;             % ������������غ� MAXIMUM ALLOWED TIP DEFLECTION
M =  P*(tem+x(2)/2);        % ���ӵ㴦����� BENDING MOMENT AT WELD POINT
R = sqrt((x(2)^2)/4+((x(1)+x(3))/2)^2);                         % һЩ���� SOME CONSTANT
J =  2*(sqrt(2)*x(1)*x(2)*((x(2)^2)/4+((x(1)+x(3))/2)^2)); % �����Ծ� POLAR MOMENT OF INERTIA
PHI =  1.10471*x(1)^2*x(2)+0.04811*x(3)*x(4)*(14+x(2)); % Ŀ�꺯�� OBJECTIVE FUNCTION
SIGMA = (6*P*tem)/(x(4)*x(3)^2);             % ����Ӧ�� BENDING STRESS
DELTA = (4*P*tem^3)/(E*x(3)^3*x(4));      % ĩ��ƫ�� TIP DEFLECTION
PC = 4.013*E*sqrt((x(3)^2*x(4)^6)/36)*(1-x(3)*sqrt(E/(4*G))/(2*tem))/(tem^2); % �����غ� BUCKLING LOAD
TAUP =  P/(sqrt(2)*x(1)*x(2));  % ��Ӧ����һ�׵��� 1ST DERIVATIVE OF SHEAR STRESS
TAUPP = (M*R)/J;                  % ��Ӧ���Ķ��׵��� 2ND DERIVATIVE OF SHEAR STRESS
TAU = sqrt(TAUP^2+2*TAUP*TAUPP*x(2)/(2*R)+TAUPP^2); % ��Ӧ�� SHEAR STRESS
G1 = TAU-TAUMAX;         % �����Ӧ��Լ�� MAX SHEAR STRESS CONSTRAINT
G2 =  SIGMA-SIGMAX;     % �������Ӧ��Լ�� MAX BENDING STRESS CONSTRAINT
%G3 = L(1)-L(4);                % ���츲��Լ�� WELD COVERAGE CONSTRAINT
G3 = DELTA-DELTMAX;
G4 = x(1)-x(4);
G5 = P-PC;
G6 = 0.125-x(1);
%G4 = 0.10471*L(1)^2+0.04811*L(3)*L(4)*(14+L(2))-5; % ���ɱ�Լ�� MAX COST CONSTRAINT
%G5 =  0.125-L(1);               % ��󺸷���Լ�� MAX WELD THICKNESS CONSTRAINT
%G6 =  DELTA-DELTMAX;   % ���ĩ��ƫ��Լ�� MAX TIP DEFLECTION CONSTRAINT
%G7 =  P-PC;                      % �����غ�Լ�� BUCKLING LOAD CONSTRAINT
G7 = 1.10471*x(1)^2+0.04811*x(3)*x(4)*(14+x(2))-5;
% ������
PHI = PHI + PCONST*(max(0, G1)^2+max(0, G2)^2+...
    max(0, G3)^2+max(0, G4)^2+max(0, G5)^2+...
    max(0, G6)^2+max(0, G7)^2);
end

% F2

function PHI = F2(x)
PCONST = 100;                   % ������Լ��
fit = (x(3)+2)*x(2)*(x(1)^2);
G1 = 1-(x(2)^3*x(3))/(71785*x(1)^4);
G2 = (4*x(2)^2-x(1)*x(2))/(12566*(x(2)*x(1)^3-x(1)^4))+1/(5108*x(1)^2)-1;
G3 = 1-(140.45*x(1))/(x(2)^2*x(3));
G4 = ((x(1)+x(2))/1.5)-1;
% ������
PHI = fit + PCONST*(max(0, G1)^2++max(0, G2)^2+...
    max(0, G3)^2+max(0, G4)^2);
end

% F3

function PHI = F3(x)
PCONST=10000;           % ������Լ��
fit = 0.6224*x(1)*x(3)*x(4)+ 1.7781*x(2)*x(3)^2 + 3.1661 *x(1)^2*x(4) + 19.84 * x(1)^2*x(3);
G1 = -x(1)+ 0.0193*x(3);
G2 = -x(2) + 0.00954* x(3);
G3 = -pi*x(3)^2*x(4)-(4/3)* pi*x(3)^3 +1296000;
G4 = x(4) - 240;
% ������
PHI = fit + PCONST*(max(0, G1)^2+max(0, G2)^2+...
    max(0, G3)^2+max(0, G4)^2);
end



