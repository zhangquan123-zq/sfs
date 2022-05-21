%_________________________________________________________________________%
function [Best_score,Best_pos,curve]=SPTLBO(pop,Max_iter,lb,ub,dim,fobj)
if(max(size(ub)) == 1)
   ub = ub.*ones(1,dim);
   lb = lb.*ones(1,dim);  
end
c = 0.2;%���ҷ�ʡ����
tf=0.3;
%��Ⱥ��ʼ��
X=initialization(pop,dim,ub,lb);
%�����ʼ��Ӧ��ֵ
fitness = zeros(1,pop);
for i = 1:pop
   fitness(i) =  fobj(X(i,:));
end
 [~, Sortindex]= sort(fitness);%����
GBestF = fitness(Sortindex(1));%ȫ��������Ӧ��ֵ
GBestX = X(Sortindex(1),:);%ȫ������λ��
GWorstF=fitness(Sortindex(pop));
GWorstX=X(Sortindex(pop),:);

curve=zeros(1,Max_iter); 
for t = 1: Max_iter
    g=1-1/exp((1-t/Max_iter)^2);
    fitness_good=[];
    Mean_score=mean(fitness);        %ƽ���ɼ�
    Mean=mean(X,1);
    w=randi(2,1,pop)-1;              %�������һ��ֻ��0 1 ������
    %% ��ʦ��ѧ�׶�
    for i = 1:pop
        if fitness(i)<=Mean_score
            fitness_good=[fitness_good fitness(i)];
            r1=i;r2=i;
            while(r1==i||r2==i||r1==r2)
                r1=randi(pop)
                r2=randi(pop)
            end
            Temp=g.*X(i,:)+rand(1,dim).*(GBestX-X(i,:))+rand(1,dim).*(X(r1,:)-X(r2,:));
        else
            
            Tf=round(1+rand(1,dim));
            Difference=rand(1,dim).*(GBestX-Tf.*Mean);
            Temp=g.*X(i,:)+Difference;
        end
        
        
        %Temp = c.*X(i,:) + rand(1,dim).*(GBestX - X(i,:));
        Temp(Temp>ub) = ub(Temp>ub);
        Temp(Temp<lb) = lb(Temp<lb);
        fTemp = fobj(Temp);
        if fTemp<fitness(i)
            fitness(i) = fTemp;
            X(i,:) = Temp;
        end
    end
    %% ѧ���໥ѧϰ�׶�
    for i = 1:pop
        if w(i)==1
            j=i;
            while j==i
                j=randi(pop);
            end
            if fitness(i)<fitness(j)
                Temp=X(i,:)+rand(1,dim).*(X(i,:)-X(j,:));
           
            else
                Temp=X(i,:)+rand(1,dim).*(X(j,:)-X(i,:));
            end
        
        else
            j=i;r3=i;r4=i;
            while (j==i||r3==i||r4==i||j==r3||j==r4||r3==r4)
                j=randi(pop);
                r3=randi(pop);
                r4=randi(pop);
            end
            if fitness(i)<fitness(j)
                Temp=tf*X(i,:)+rand(1,dim).*(X(i,:)-X(j,:))+rand(1,dim).*(X(r3,:)-X(r4,:));
            else
                Temp=tf*X(i,:)+rand(1,dim).*(X(j,:)-X(i,:))+rand(1,dim).*(X(r3,:)-X(r4,:));
            end
           
        end
        
       
           
           
       
       Temp(Temp>ub) = ub(Temp>ub);
       Temp(Temp<lb) = lb(Temp<lb);
       fTemp = fobj(Temp);
       if fTemp<fitness(i)
           fitness(i) = fTemp;
           X(i,:) = Temp;
       end
    end
    good_score=mean(fitness_good);        %�����ƽ���ɼ�
    
    %% ���ҵ��ڽ׶�
    for i=1:pop
        if fitness(i)<=good_score
            Temp=X(i,:);
        elseif fitness(i)<=Mean_score
            Temp=X(i,:)+(GBestX+GWorstX).*(rand(1,dim)-rand(1,dim));
        else
            Temp=(GBestX+GWorstX)-X(i,:);
        end
        Temp(Temp>ub) = ub(Temp>ub);
		Temp(Temp<lb) = lb(Temp<lb);
		fTemp = fobj(Temp);
		if fTemp<fitness(i)
			fitness(i) = fTemp;
			X(i,:) = Temp;
		end
    end
        
            
    
    

    [minFitness,minIndex] = min(fitness);
    if minFitness<GBestF
        GBestF = minFitness;
        GBestX = X(minIndex,:);
    end
    [maxFitness,maxIndex] =max(fitness);
    if minFitness>GWorstF
        GWorstF=maxFitness;
        GWorstX=X(maxIndex,:);
    end
        
          
   curve(t) = GBestF;
end
Best_pos = GBestX;
Best_score = curve(end);
end



