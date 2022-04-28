close all
% clear
dt = 0.05;

SL_msg = rosmessage('A_star/state_lattice');
friction_msg = rosmessage('A_star/friction_map');

default_mu = 0.9;
friction_msg.Frictions = repmat(default_mu,30,1);
friction_msg.Frictions(10) = -1;
friction_msg.Frictions(11) = -1;

friction_msg.Frictions(20) = -1;
friction_msg.Frictions(21) = -1;
friction_msg.Frictions(14) = 0.14;
friction_msg.Frictions(13) = 0.14;
friction_msg.Frictions(16) = 0.14;
friction_msg.Frictions(17) = 0.14;

[friction_pub, ~] = rospublisher('/friction_map', 'A_star/friction_map');
[SL_pub, ~] = rospublisher('/state_lattice', 'A_star/state_lattice');

figure(1)
subplot(4,1,1);
hold on
world_width = 3;
world_length = 10;
ylim([-6,6])
xlim([0,500])
friction_array = [[]];

temp = gca;
temp.XGrid = 'on';
temp.YTick = [-4 0 4];
temp.YGrid = 'on';

for i=0:world_length-1
    for j=1:world_width
        curr_x = (j-2)*4;
        curr_y = i*50;

        friction_array(i+1, j) = friction_msg.Frictions(i*world_width+j);

        if(friction_msg.Frictions(i*world_width+j) == -1)
            [verts, faces] = gen_rect_points_flat(curr_y, curr_x);
            obs = patch(verts(:,1), verts(:,2), 'k');

        elseif(friction_msg.Frictions(i*world_width+j) ~= default_mu)
            [verts, faces] = gen_rect_points(curr_y+25, curr_x);
            obs = patch(verts(:,1), verts(:,2), 'b', 'FaceAlpha',.3);
        end
    end
end

[SL_msg,M1, M2] = publish_trajectories(dt, SL_msg);
% send(SL_pub, SL_msg);
% send(friction_pub, friction_msg);


traj_key_sub = rossubscriber('/trajectory_keys', 'A_star/trajectory_keys', @(pub, msg) trajectory_cb(msg, M1, M2,friction_array));

function trajectory_cb(msg, M1, M2,friction_array)
%TODO: change this:
    states = [0;0;0;8;0;0;16];
%     simulate(states, msg, M1, M2,friction_array)

end

function [SL_msg, M1, M2] = publish_trajectories(dt, SL_msg)
    u1 = 8;
    u2 = 20;
    speeds = linspace(u1,u2,4);
    dx = [-4 0 4];
    dy = 50;
    traj_msg = rosmessage('A_star/trajectory_info');
    key_set = [""];
    value_set1 = {traj_msg};
    value_set2 = {0};
%     M = containers.Map("KeyType","string","ValueType","trajectory_info");

    for k=1:length(speeds)
        for i=1:length(speeds)
            for j=1:length(dx)

                [inputs_list, total_distance, reference_traj] = generate_trajectories(dy, dx(j), speeds(k), speeds(i), dt);
                [F_yfw_max, F_yr_max, F_xfw_max, F_xr_max]=test_simulate(inputs_list, speeds(k), dt);
                if(speeds(k) == 8 && speeds(i) == 8)
                    temp = 1;
                end

                traj_msg = rosmessage('A_star/trajectory_info');
                traj_msg.Td = inputs_list(1,:);
                traj_msg.Delta = inputs_list(2,:);
                traj_msg.MaxFXr = F_xr_max;
                traj_msg.MaxFXf = F_xfw_max;
                traj_msg.MaxFYr = F_yr_max;
                traj_msg.MaxFYf = F_yfw_max;
                traj_msg.TExecution = length(inputs_list)*dt;
                traj_msg.Dx = dx(j);
                traj_msg.Dy = dy;
                traj_msg.U1 = speeds(k);
                traj_msg.U2 = speeds(i);
                traj_msg.Length = total_distance;

                key_set(end+1) = strcat(int2str(dx(j)),"-",int2str(dy),"-",int2str(speeds(k)),"-",int2str(speeds(i)));
                value_set1(end+1) = {traj_msg};
                value_set2(end+1) = {reference_traj};


                
                SL_msg.StateLattice(end+1) = traj_msg;
            end
        end
    end
    M1 = containers.Map(key_set,value_set1);
    M2 = containers.Map(key_set,value_set2);


end