clear
clc
close all


syms A B C D E x
By=0.27*180/pi;
Cy=1.3;
Dy=0.7;
Ey=-1.6;
Bx=0.47*180/pi;
Cx=1.3;
Dx=0.7;
Ex=-1.6;


MF = D*sin(C*atan(B*x-E*(B*x-atan(B*x))));
d_MF = diff(MF, x);
dd_MF = diff(d_MF, x);
temp_MF = 13734*subs(MF, [B C D E], [Bx Cx Dx Ex]);
% temp_dMF = subs(d_MF, [B C D E], [1 10 1 1000 1.01]);
% temp_ddMF = subs(dd_MF, [B C D E], [1 10 1 1000 1.01]);
% temp_dMF_func = matlabFunction(temp_dMF);
% temp_ddMF_func = matlabFunction(temp_ddMF);
temp_MF_func = matlabFunction(temp_MF);

figure
plot(linspace(0,0.5,100), temp_MF_func(linspace(0,0.5,100)), 'LineWidth', 6);

xlabel("slip parameter")
title('Tire Charcteristic Curve')
ylabel("Force")
set(gca,'fontsize', 35)
hold on

% plot(linspace(0,0.04,100), 276051.666666667*linspace(0,0.04,100), 'LineWidth', 6);


plot(linspace(0,0.03,100), temp_MF_func(linspace(0,0.03,100)), 'LineWidth', 6);
% plot(linspace(0.04,0.5,100), temp_MF_func(linspace(0.04,0.5,100)), 'LineWidth', 6);
% 
scatter(0.03, temp_MF_func(0.03), 250, 'k', 'filled')
legend(["Chacteristic Curve", "Linear Region", "Max Allowed Force"])
% legend(["Chacteristic Curve", "Linear Approximation"])

 