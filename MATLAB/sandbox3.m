close all

% u1 = 5;
% u2 = 30;
% inputs_list = generate_trajectories(100, 7, u1, u2, dt);

% SL_msg = rosmessage('A_star/state_lattice');
% traj_msg = rosmessage('A_star/trajectory_info');
% friction_msg = rosmessage('A_star/friction_map');
% 
% 
% friction_msg.Frictions = repmat(2,30,1);
% [friction_pub, ~] = rospublisher('/friction_map', 'A_star/friction_map');
% 
% send(friction_pub, friction_msg);


% 
% test_simulate

% 
% function publish_trajectories()
%     u1 = 6;
%     u2 = 30;
%     speeds = linspace(u1,u2,5);
%     dx = [-4 0 4];
%     dy = 
%     
%     for i=1:length(speeds)
%         for j=1:length(dx)
%             inputs_list = generate_trajectories(100, 7, u1, u2, dt);
%         end
%     end
% 
% end