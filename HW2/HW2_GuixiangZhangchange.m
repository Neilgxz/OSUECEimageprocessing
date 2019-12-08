clear all
close all
a= load('3D vectors sample.mat');  
x= cell2mat(struct2cell(a));
b=size(x);
c=zeros(b(1),1);
x=[x c];
x(:,4)=-1;
Q=x'*x;         % positive semi definite matrix
[V,D] = eig(Q); % eigenvalue decomposition
%% find solution plane
fmesh(@(x,y) V(1,1)/-V(3,1)*x+V(2,1)/-V(3,1)*y+V(4,1)/V(3,1));
hold on
plot3(x(:,1),x(:,2),x(:,3),'k.','markersize',10);