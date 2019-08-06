clear;clc;
%% 数据准备
% 仓库位置 列向量 8个
Hubs=[28 23 35 31 22 36 29 38]';
% 企业位置 3个
Enterprises=[24 41 34]';
% 储备库位置2个
Stores=[27 30]';
% w为距离矩阵
n=42;w=zeros(n);
    w(41,42)=26;w(28,42)=32;w(15,42)=28;
    w(6,41)=48;
    w(6,40)=30;w(5,40)=38;w(9,40)=28;w(27,40)=32;
    w(30,39)=15;w(32,39)=62;w(35,39)=102;w(5,39)=85;
    w(32,38)=68;w(37,38)=35;
    w(33,37)=38;
    w(33,36)=40;w(3,36)=60;
    w(32,35)=98;
    w(32,34)=25;w(1,34)=45;
    w(1,33)=60;
    w(31,32)=50;
    w(9,31)=52;
    w(29,30)=62;w(4,30)=70;
    w(28,29)=60;w(4,29)=40;
    w(8,28)=50;
    w(11,27)=48;w(40,27)=32;w(13,27)=50;w(7,27)=70;w(26,27)=70;w(9,27)=40;
    w(25,26)=18;w(19,26)=28;w(24,26)=30;
    w(11,25)=40;w(18,25)=30;w(15,25)=46;
    w(20,24)=50;
    w(14,23)=50;w(17,23)=52;w(16,23)=65;w(18,23)=45;
    w(19,22)=72;w(21,22)=45;w(20,22)=80;
    w(16,21)=58;
    w(13,20)=68;
    w(18,19)=22;
    w(16,18)=75;
    w(14,17)=56;

    w(8,15)=38;w(11,15)=56;
    w(8,14)=36;
    w(12,13)=80;
    w(10,12)=52;
    w(6,11)=32;
    w(7,10)=48;w(3,10)=42;
    w(2,9)=62;

    w(2,7)=50;
    w(4,6)=30;
    w(4,5)=10;
    w(2,3)=35;
    w(1,2)=40;
w=w+w';
w(w==0)=inf;%所有走不通的路都是无穷
w(1:n+1:n^2)=0;%对角线替换0
% a为路的等级矩阵 1表示边为高等级公路 0表示不是
a=zeros(n);
    a(5,40)=1;a(27,40)=1;
    a(35,39)=1;a(5,39)=1;
    a(4,29)=1;
    a(8,28)=1;
    a(11,27)=1;a(40,27)=1;a(13,27)=1;a(7,27)=1;
    a(11,25)=1;a(18,25)=1;
    a(16,18)=1;
    a(14,17)=1;
    a(8,15)=1;a(11,15)=1;
    a(8,14)=1;
    a(6,11)=1;
    a(7,10)=1;
    a(4,6)=1;
    a(4,5)=1;
    a=a+a';
a(1:n+1:n^2)=0;%对角线替换0

%% 计算价格矩阵
%每段路的价格，普通收1.2 高级收2=1.2+0.8
wp=1.2*w+0.8*a;
%% 计算3企业2仓库到各个存储地的最短费用与路线
%构造重要节点之间的最短路径矩阵minp与相应的路径元胞mpath
minp=zeros(n);
mpath=cell(n,n);
for i=1:length(Enterprises)
    for j=1:length(Hubs)
[minp(Enterprises(i),Hubs(j)),mpath{Enterprises(i),Hubs(j)}]=mindistance(wp,Enterprises(i),Hubs(j));
    end
end
for i=1:length(Enterprises)
    for j=1:length(Stores)
[minp(Enterprises(i),Stores(j)),mpath{Enterprises(i),Stores(j)}]=mindistance(wp,Enterprises(i),Stores(j));
    end
end
minp=minp+minp';
minp(minp==0)=inf;%所有走不通的路都是无穷
minp(1:n+1:n^2)=0%对角线替换0
%% 第一天，3企业2仓库全部供给国库，然后1750-1700还剩下50，这个50先不发放，单独运算
% 构建运输问题的矩阵

%% 考虑50的分配

%% 考虑每天生产量分配
