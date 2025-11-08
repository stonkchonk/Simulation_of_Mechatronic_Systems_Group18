A=[-1;1;1];
B=[-1;0;-1];
C=[1;1;0];
D=[1;-1;0.3];
figure()
[d1,d2,dmin]=plotdistance(A,B,C,D,1);
function[d1,d2,dmin]=plotdistance(A,B,C,D,plotvar)
u=B-A;
v=D-C;
p=A-C;
a=dot(u,u);
b=dot(u,v);
c=dot(v,v);
d=dot(p,u);
e=dot(p,v);
p0=a*c-b*b;
if abs(p0)<1e-6
    disp('lines are parallel');
    return
else
    t1=(b*e-c*d)/p0;
    t2=(a*e-b*d)/p0;
    d1=A+t1*u;
    d2=C+t2*v;
    dmin=norm(d1-d2);
end
if plotvar==1
    figure; hold on; grid on; axis equal;
    plot3(A(1),A(2),A(3),'o',B(1),B(2),B(3),'o',C(1),C(2),C(3),'o',D(1),D(2),D(3),'o')
    plot3([A(1),B(1)],[A(2),B(2)],[A(3),B(3)],'r');
    plot3([C(1),D(1)],[C(2),D(2)],[C(3),D(3)],'y');
    plot3([d1(1),d2(1)],[d1(2),d2(2)],[d1(3),d2(3)],'m');
    xlabel('x values');
    ylabel('y values');
    zlabel('z values');
    title('shortest distance');
    view(3)
end
end
