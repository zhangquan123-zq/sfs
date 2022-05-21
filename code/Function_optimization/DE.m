%_________________________________________________________________________%
%��ֽ����㷨             %
%_________________________________________________________________________%
function [Best_score,Best_pos,curve]=DE(pop,Max_iter,lb,ub,dim,fobj)
%���� �ɵ�
PCr=0.8;%�������
F=0.85; %��������

if(max(size(ub)) == 1)
   ub = ub.*ones(1,dim);
   lb = lb.*ones(1,dim);  
end

%��Ⱥ��ʼ��
X0=initialization(pop,dim,ub,lb);
X = X0;
%�����ʼ��Ӧ��ֵ
fitness = zeros(1,pop);
for i = 1:pop
   fitness(i) =  fobj(X(i,:));
end
 [fitness, index]= sort(fitness);%����
GBestF = fitness(1);%ȫ��������Ӧ��ֵ
%����Ӧ������,X(1,:)��������λ�ã�X(end,:)�������λ��
for i = 1:pop
    X(i,:) = X0(index(i),:);
end

GBestX = X(1,:);%ȫ������λ��
curve=zeros(1,Max_iter);
X_new = X;
for t = 1: Max_iter
   for i = 1:pop
      %�������
      Candidates=[1:i-1 i+1:pop];
      idx=Candidates(randperm(pop-1,3));        
      x1=X(idx(1),:);
      x2=X(idx(2),:);
      x3=X(idx(3),:);        
      V=x1+F*(x2-x3);
      %%�������
      for j=1:dim     
        if(rand<=PCr)
            X_new(i,j)=V(j);
        else
            X_new(i,j)=X(i,j);
        end
      end    
   end
   %�߽����
   for j = 1:pop
       for a = 1: dim
           if(X_new(j,a)>ub)
               X_new(j,a) =ub(a);
           end
           if(X_new(j,a)<lb)
               X_new(j,a) =lb(a);
           end
       end
   end 
   %������Ӧ��ֵ
   for j=1:pop
    fitness_new(j) = fobj(X_new(j,:));
   end
   for j = 1:pop
     if(fitness_new(j) < fitness(j))
         fitness(j) = fitness_new(j);
         X(j,:) = X_new(j,:);   
     end
   end
    %�������
   [fitness, index]= sort(fitness);%����
   for j = 1:pop
      X(j,:) = X(index(j),:);
   end
   if(fitness(1)<GBestF)
       GBestF = fitness(1);
       GBestX = X(1,:);
   end
   curve(t) = GBestF;
end
Best_pos = GBestX;
Best_score = curve(end);
end



