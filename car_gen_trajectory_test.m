close all; clear all;
symbolic_car_model();
% Initialize timings
dt = 0.005;
start_time = 0;
end_time = 8;

% Set desired state
n_states = 7;
n_inputs = 2;


init_x = 0;
init_y = 0;
init_h = 0;
init_u = 20;
init_v = 0;
init_r = 0;


goal_x = 500;
goal_y = 10;
goal_h = 0;
goal_u = 10;
goal_v = 0;
goal_r = 0;

end_time = (norm([goal_x, goal_y])/init_u+norm([goal_x, goal_y])/goal_u)/2;
time_span = start_time:dt:end_time;

init_state = [init_x;init_y;init_h;init_u;init_v;init_r;init_u*2]; % Define the initial state to be the origin 
target_state = [goal_x;goal_y;goal_h;goal_u;goal_v;goal_r;goal_u*2];

% Seed with random inputs centered about 0
rng(1);
initial_guess = 100*abs(randn(size(time_span,2),n_inputs)); 
initial_guess(:,2) = zeros(size(time_span,2),1);
% initial_guess = 0.5*randn(size(time_span,2),n_inputs); 

% Define weighting matrices
Q_k = zeros(n_states,n_states); % zero weight to penalties along a trajectory since we are finding a trajectory
% Q_k = 0*eye(n_states);
% Q_k(3,3) = 0;
% Q_k(6,6) = 0;


R_k = eye(n_inputs);
R_k(1,1) = 0.00001;
R_k(2,2) = 0.0001;

Q_T = 10000*eye(n_states);
Q_T(7,7) = 0;
%Q_T(3,3) = 10000;


%% Parameters of the cart pole
m=1400;
Izz=2667;
By=0.07*180/pi;
Cy=1.3;
Dy=0.7;
Ey=-1.6;
Bx=0.27*180/pi;
Cx=1.3;
Dx=0.7;
Ex=-1.6;
lf=1.35;
lr=1.45;
rw=0.5;
J = 100;
parameters = [m Izz J lf lr rw]; 

%% Specify max number of iterations
n_iterations = 50;

% Construct ilqr object
ilqr_ = ilqr(init_state,target_state,initial_guess,dt,start_time,end_time,f_disc,calc_A_disc,calc_B_disc,Q_k,R_k,Q_T,parameters,n_iterations);
% Solve
[states,inputs,k_feedforward,K_feedback,final_cost] = ilqr_.solve();

subplot(4,1,1);
plot(states(:,1), states(:,2))
title("xy")

subplot(4,1,3);
plot(inputs(:,1))
title("T_d")

subplot(4,1,2);
plot(states(:,4))
title("u")

subplot(4,1,4);
plot(inputs(:,2))
title("delta")

% save('cartpole-translate-trajectory.mat','states','inputs','dt','parameters','K_feedback','target_state');
% 
% figure(1);
% plot(ilqr_.states_(:,2),ilqr_.states_(:,4));
% hold on
% plot(target_state(2),target_state(4),'ro');
% 
% figure(2);
% plot(inputs);
% 
% figure(3);
% animate_cartpole(states,inputs, dt)