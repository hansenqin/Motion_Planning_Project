clear
load Lin_A_B.mat 
load Y.mat 
load U.mat

A_lin = {};
B_lin = {};

for i=1:length(Y)
    A_lin{i} = J_A_fun([Y(i,:), U(i,:)]);
    B_lin{i} = J_B_fun([Y(i,:), U(i,:)]);
end

