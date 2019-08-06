function [mydistance,mypath]=mindistance(a,sb,db)
%输入：a——邻接矩阵；a(i,j)——i到j之间的距离，可以是有向的
%sb——起点的标号，db——终点的标号
%输出：mydistance——最短路的距离，mypath——最短路径
%初始化
n=size(a,1); u=sb;
parent(1:n)=0; visited(1:n)=0;
distance(1:n)=inf;
distance(sb)=0;
visited(sb)=1;
for i=1:n-1
    id=find(visited==0);
    for v = id%这里的u更新的是路径的末端
        if distance(u)+a(u,v)<distance(v)%由于distance(u)是当前的最短的所以用来更新别的点
            distance(v) = distance(u)+a(u,v);
            parent(v)=u;%parent存的是前驱节点
        end
    end
    temp=distance;
    temp(visited==1)=inf;%已经标号的距离换成无穷
    [t,u]=min(temp);%找到标号值最小的顶点
    visited(u)=1;%标记已经标号的顶点
end
%上面的循环的得到的是起始点到其他点的最短路
%然后下面的程序用来提取起点到你想要的终点的最短路径
mypath = [];
if parent(db)~=0%如果存在路
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

