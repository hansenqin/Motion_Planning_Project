b = 1.5 ; 
L = 3 ;
nsteps=121;
dt=0.05;

%z=[x0 y0 th0 x1 y1 th1 ... xn yn thn u0 d0 ... u(n-1) d(n-1)]';



options = optimoptions('fmincon','SpecifyConstraintGradient',true,...
                       'SpecifyObjectiveGradient',true) ;
                   
ub = zeros(5*nsteps-2,1);
ub(1:3:3*nsteps) = 8 ;
ub(2:3:3*nsteps) = 3 ;
ub(3:3:3*nsteps) = pi/2 ;
ub(3*nsteps+1:2:5*nsteps-2) = 1 ;
ub(3*nsteps+2:2:5*nsteps-2) = 0.5 ;

lb = zeros(5*nsteps-2,1);
lb(1:3:3*nsteps) = -1 ;
lb(2:3:3*nsteps) = -3 ;
lb(3:3:3*nsteps) = -pi/2 ;
lb(3*nsteps+1:2:5*nsteps-2) = 0 ;
lb(3*nsteps+2:2:5*nsteps-2) = -0.5 ;



x0=zeros(1,5*nsteps-2);
cf=@costfun;
nc=@nonlcon;

% removed for timeout issues and since this portion is already coded for the
% learner and is worth 0 points.
z=fmincon(cf,x0,[],[],[],[],lb',ub',nc,options);

Y0=reshape(z(1:3*nsteps),3,nsteps)';
U=reshape(z(3*nsteps+1:end),2,nsteps-1);
u=@(t) [interp1(0:dt:119*dt,U(1,:),t,'previous','extrap');...
       interp1(0:dt:119*dt,U(2,:),t,'previous','extrap')];
% [T1,Y1]=ode45(@(t,x) odefun(x,u(t)),[0:dt:120*dt],[0 0 0]);
% [T2,Y2]=ode45(@(t,x) odefun(x,u(t)),[0:dt:120*dt],[0 0 -0.01]);
plot(Y0(:,1),Y0(:,2))%,Y1(:,1),Y1(:,2),Y2(:,1),Y2(:,2))
theta = 0:0.01:2*pi;
hold on
plot((0.7*cos(theta)+3.5),(0.7*sin(theta)-0.5))
hold on
plot(0,0,'x');
% legend('fmincon trajectory','ode45 trajectory using x0 = [0;0;0]',...
%     'ode45 trajectory using x0 = [0;0;-0.01]','Buffered Obstacle','Start');
% ylim([-2,2]);
% xlim([-1,8]);
xlabel('x');
ylabel('y');

function [J, dJ] = costfun(z)
    if size(z,2)>size(z,1)
        z = z' ;
    end
    nsteps = (size(z,1)+2)/5 ;

    zx = z(1:3*nsteps) ;
    zu = z(3*nsteps+1:end) ;
    R=eye(2*nsteps-2)*0.01;

    nom=zeros(3*nsteps,1) ;
    nom(1:3:3*nsteps) = 3 ;
    nom(2:3:3*nsteps+1) = -3 ;
    nom(3:3:3*nsteps+2) = 1 ;
    Q=eye(3*nsteps);
    Q(361, 361) = 1000;
    Q(362, 362) = 1000;
    Q(363, 363) = 1000;

    J = zu'*R*zu+(zx-nom)'*Q*(zx-nom) ;
    dJ = [2*Q*zx-2*Q*nom;...
          2*R*zu]' ;
end
function [g,h,dg,dh]=nonlcon(z)
    if size(z,2)>size(z,1)
        z = z' ;
    end
    nsteps = (size(z,1)+2)/5 ;
    b = 1.5 ; 
    L = 3 ;
    dt = 0.05 ;

    zx=z(1:nsteps*3);
    zu=z(nsteps*3+1:end);

    g = zeros(nsteps,1) ;
    dg = zeros(nsteps,5*nsteps-2) ;

    h = zeros(3*nsteps,1) ;
    dh = zeros(3*nsteps,5*nsteps-2);

    h(1:3) = z(1:3,:) ;
    dh(1:3,1:3)=eye(3);

    for i=1:nsteps
        if i==1
            h(1:3) = z(1:3,:) ;
            dh(1:3,1:3)=eye(3); 
        else
            h(3*i-2:3*i) = zx(3*i-2:3*i)-zx(3*i-5:3*i-3)-...
                               dt*odefun(zx(3*i-5:3*i-3),zu(2*i-3:2*i-2)) ;
            dh(3*i-2:3*i,3*i-5:3*i) = [-eye(3)-dt*statepart(zx(3*i-5:3*i-3),zu(2*i-3:2*i-2)),eye(3)] ;
            dh(3*i-2:3*i,3*nsteps+2*i-3:3*nsteps+2*i-2) = -dt*inputpart(zx(3*i-5:3*i-3),zu(2*i-3:2*i-2)) ;
        end
        g(i) = (0.7^2)-((z(3*i-2)-3.5)^2+(z(3*i-1)+0.5)^2) ;
        dg(i,3*i-2:3*i-1) = -2*[z(3*i-2)-3.5, z(3*i-1)+0.5] ;
    end

    dg = dg' ;
    dh= dh' ;
end

function [dx] = odefun(x,u)
    b = 1.5 ; 
    L = 3 ;
    dx = [u(1)*cos(x(3))-(b/L)*u(1)*tan(u(2))*sin(x(3)) ;...
          u(1)*sin(x(3))+(b/L)*u(1)*tan(u(2))*cos(x(3)) ;...
          u(1)*tan(u(2))/L] ;
end

function [pd] = statepart(x,u)
    b = 1.5 ; 
    L = 3 ;
    pd = zeros(3,3) ;
    pd(:,3) = [-u(1)*sin(x(3))-(b/L)*u(1)*tan(u(2))*cos(x(3)) ;...
                u(1)*cos(x(3))-(b/L)*u(1)*tan(u(2))*sin(x(3)) ;...
                0] ;
end

function [ip] = inputpart(x,u)
    b = 1.5 ; 
    L = 3 ;
    ip = [cos(x(3))-(b/L)*tan(u(2))*sin(x(3)) -(b*u(1)*sin(x(3)))/(L*cos(u(2))^2) ;...
          sin(x(3))+(b/L)*tan(u(2))*cos(x(3))  (b*u(1)*cos(x(3)))/(L*cos(u(2))^2) ;...
          tan(u(2))/L                          u(1)/(L*cos(u(2))^2)] ;
end