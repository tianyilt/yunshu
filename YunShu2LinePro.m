function [solution,optim]=YunShu2LinePro(Yun,Xv,Chan)
%YUNSHU2LINEPRO 能够在建立完成运输问题表上作业法的表格后，直接方便求解运输问题。
%而不用去为了迎合线性规划工具箱而自己构造参数
%   输入：
% Yun，是一个销地数*产地数的矩阵，i行j列元素表示从产地j运输到销售地i的价格
% Xv，是一个列向量，第i个元素表示第i个需求地需求
% Chan，是一个列向量，第i个元素表示第i个生产地产出
%   输出：是一个销地数*产地数的矩阵，i行j列元素表示从产地j运输到销售地i的运输量
% solution，
f=[];
for i=1:size(Yun,1)
    f=[f,Yun(i,:)];
end
%matlab版arr.append
b=[Xv;Chan]';
A=zeros(length(b),size(Yun,1)*size(Yun,2));
dim1=size(A,1);%行数，而且是产地+销售地
dim1_Yun=size(Yun,1);%行数
dim2_Yun=size(Yun,2);%列数
for i=1:dim1
    if i<=length(Xv)
        A(i,dim2_Yun*i-dim2_Yun+1:dim2_Yun*i)=1;
    else
        for j=1:dim1_Yun
            A(i,(i-length(Xv))+(j-1)*dim2_Yun)=1;
        end
    end
end
lb=zeros(1,size(Yun,1)*size(Yun,2));
ub=ones(1,size(Yun,1)*size(Yun,2))*inf;
[solve,optim]=linprog(f,[],[],A,b,lb,ub);
solution=[];
for i=1:size(Yun,1)
    solution=[solution,solve(size(Yun,2)*i-size(Yun,2)+1:size(Yun,2)*i)];
end
solution=solution';
end

