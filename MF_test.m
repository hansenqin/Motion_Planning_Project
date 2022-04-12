clear
clc
close all


syms A B C D E x
MF = D*sin(C*atan(B*x-E*(B*x-atan(B*x))));
d_MF = diff(MF, x);
dd_MF = diff(d_MF, x);
temp_MF = subs(MF, [A B C D E], [1 20 1 500 1.01]);
temp_dMF = subs(d_MF, [A B C D E], [1 10 1 1000 1.01]);
temp_ddMF = subs(dd_MF, [A B C D E], [1 10 1 1000 1.01]);
temp_dMF_func = matlabFunction(temp_dMF);
temp_ddMF_func = matlabFunction(temp_ddMF);
temp_MF_func = matlabFunction(temp_MF);

figure
plot(linspace(0,0.5,100), temp_MF_func(linspace(0,0.5,100)));

 