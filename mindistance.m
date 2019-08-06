function [mydistance,mypath]=mindistance(a,sb,db)
%���룺a�����ڽӾ���a(i,j)����i��j֮��ľ��룬�����������
%sb�������ı�ţ�db�����յ�ı��
%�����mydistance�������·�ľ��룬mypath�������·��
%��ʼ��
n=size(a,1); u=sb;
parent(1:n)=0; visited(1:n)=0;
distance(1:n)=inf;
distance(sb)=0;
visited(sb)=1;
for i=1:n-1
    id=find(visited==0);
    for v = id%�����u���µ���·����ĩ��
        if distance(u)+a(u,v)<distance(v)%����distance(u)�ǵ�ǰ����̵������������±�ĵ�
            distance(v) = distance(u)+a(u,v);
            parent(v)=u;%parent�����ǰ���ڵ�
        end
    end
    temp=distance;
    temp(visited==1)=inf;%�Ѿ���ŵľ��뻻������
    [t,u]=min(temp);%�ҵ����ֵ��С�Ķ���
    visited(u)=1;%����Ѿ���ŵĶ���
end
%�����ѭ���ĵõ�������ʼ�㵽����������·
%Ȼ������ĳ���������ȡ��㵽����Ҫ���յ�����·��
mypath = [];
if parent(db)~=0%�������·
    mypath = [db];
    t =db;
    while t~=sb
        p=parent(t);
        mypath = [p mypath];
        t=p;
    end
end
mydistance=distance(db);
end

