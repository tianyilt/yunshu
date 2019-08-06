function [solution,optim]=YunShu2LinePro(Yun,Xv,Chan)
%YUNSHU2LINEPRO �ܹ��ڽ�������������������ҵ���ı����ֱ�ӷ�������������⡣
%������ȥΪ��ӭ�����Թ滮��������Լ��������
%   ���룺
% Yun����һ��������*�������ľ���i��j��Ԫ�ر�ʾ�Ӳ���j���䵽���۵�i�ļ۸�
% Xv����һ������������i��Ԫ�ر�ʾ��i�����������
% Chan����һ������������i��Ԫ�ر�ʾ��i�������ز���
%   �������һ��������*�������ľ���i��j��Ԫ�ر�ʾ�Ӳ���j���䵽���۵�i��������
% solution��
f=[];
for i=1:size(Yun,1)
    f=[f,Yun(i,:)];
end
%matlab��arr.append
b=[Xv;Chan]';
A=zeros(length(b),size(Yun,1)*size(Yun,2));
dim1=size(A,1);%�����������ǲ���+���۵�
dim1_Yun=size(Yun,1);%����
dim2_Yun=size(Yun,2);%����
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
