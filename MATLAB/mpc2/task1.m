close all 
clear all

% open('track.fig')

load TestTrack.mat
load traj_to_track_mapping.mat
load Y
load U
load dMatrices



interp_const = 100;
[bl_world_new, br_world_new, cline, heading] = get_track_bounds_and_goals(TestTrack, interp_const);

modify_traj_ = @modify_traj;
get_obs_side_ = @get_obs_side;
get_closest_ = @get_closest;



Xobs = generateRandomObstacles(10,TestTrack);
x0 = [287,5,-176,0,2,0];

% traj_to_track_idx = zeros(1, length(Y));
% tic
% for i = 1:length(Y)
%     curr_pos = [Y(i,1);Y(i,3)];
%     traj_to_track_idx(i) = get_closest(curr_pos, cline);
%     cline(:, traj_to_track_idx(i));
% end
% toc

% obstacles = [];
% for i=1:length(Xobs)
%     obs = Xobs{i};
%     obstacles(i) = plot(obs(:,1), obs(:,2));
%     Y = modify_traj(Y, obs, bl_world_new, br_world_new, cline, heading, traj_to_track_mapping);
% end
% 
% x0 = [287,5,-176,0,2,0];



trajectory = scatter(x0(1), x0(3), '.');
hold on
plot(bl_world_new(1,:), bl_world_new(2,:))
plot(br_world_new(1,:), br_world_new(2,:))

num_Xobs_seen = 0;
init = 1;
Xobs_already_seen = {};
obs = [];
for i=1:length(Y)
    
    curr_pos = [Y(i,1);Y(i,3)];
    Xobs_seen = senseObstacles(curr_pos, Xobs);
    
    
    if init
        num_Xobs_seen = length(Xobs_seen);
        if num_Xobs_seen > 0
            for j = 1:length(num_Xobs_seen)
                obs = Xobs_seen{j};
                Xobs_already_seen{end+1} = obs;
                plot(obs(:,1), obs(:,2));
                Y = modify_traj(Y, obs, bl_world_new, br_world_new, cline, heading, traj_to_track_mapping);
            end
        end
        init = 0;
    else
        num_Xobs_seen = length(Xobs_seen);
        if num_Xobs_seen > 0
            latest_obs = Xobs_seen{end};
            if ~any(cellfun(@(x) isequal(x, latest_obs), Xobs_already_seen))
                disp('new obs detected')
               plot(latest_obs(:,1), latest_obs(:,2));
               Xobs_already_seen{end+1} = latest_obs;
               Y = modify_traj(Y, latest_obs, bl_world_new, br_world_new, cline, heading, traj_to_track_mapping);
            end
        end
        
    end
    
    trajectory.XData(end+1) = Y(i,1);
    trajectory.YData(end+1) = Y(i,3);
    
    
    pause(0.0001)
end



function Y = modify_traj(Y, obs, bl_world_new, br_world_new, cline, heading, traj_to_track_mapping)
    obs_center = mean(obs);
    
    closest_traj_idx = get_closest([Y(:,1) Y(:,3)]', obs_center');
    closest_track_idx = get_closest(cline, obs_center');
    leftside = get_obs_side(obs_center, cline, heading, closest_track_idx);
    
    curr_mapping = traj_to_track_mapping(closest_traj_idx-500:closest_traj_idx+500);
    
    if ~leftside
     
        Y(closest_traj_idx-400:closest_traj_idx+400, 1) = (cline(1, curr_mapping) + 2*bl_world_new(1, curr_mapping))'/3;
        Y(closest_traj_idx-400:closest_traj_idx+400, 3) = (cline(2, curr_mapping) + 2*bl_world_new(2, curr_mapping))'/3;

    else

        Y(closest_traj_idx-400:closest_traj_idx+400, 1) = (cline(1, curr_mapping) + 2*br_world_new(1, curr_mapping))'/3;
        Y(closest_traj_idx-400:closest_traj_idx+400, 3) = (cline(2, curr_mapping) + 2*br_world_new(2, curr_mapping))'/3;
       
    end
    

end

function leftside = get_obs_side(obs_center, cline, heading, closest_track_idx)
    rotated_obs_x = [rotmat(-(heading(closest_track_idx)-pi/2))*obs_center'];
    rotated_obs_x = rotated_obs_x(1);
    
    rotated_cline_x = [rotmat(-(heading(closest_track_idx)-pi/2))*cline(:,closest_track_idx)];
    rotated_cline_x = rotated_cline_x(1);
    
    leftside = rotated_obs_x < rotated_cline_x;
    
end


function idx = get_closest(a, b)
    [~,idx] = min(vecnorm(a-b));

end





function [bl_world_new, br_world_new, cline_new, track_heading_new] = get_track_bounds_and_goals(TestTrack, interp_const)
%     This function takes the given bounds of the racing track and convert them
%     to 
    
    bl_world = TestTrack.bl;
    br_world = TestTrack.br;
    track_heading = TestTrack.theta;
    cline = TestTrack.cline;
    
    bl_world_new(1, :) = interp1(1:1:length(bl_world(1, :)), bl_world(1, :), 1:1/interp_const:length(bl_world(1, :)));
    bl_world_new(2, :) = interp1(1:1:length(bl_world(2, :)), bl_world(2, :), 1:1/interp_const:length(bl_world(2, :)));
    br_world_new(1, :) = interp1(1:1:length(br_world(1, :)), br_world(1, :), 1:1/interp_const:length(br_world(1, :)));
    br_world_new(2, :) = interp1(1:1:length(br_world(2, :)), br_world(2, :), 1:1/interp_const:length(br_world(2, :)));
    track_heading_new = interp1(1:1:length(track_heading), track_heading, 1:1/interp_const:length(track_heading));
    cline_new_x = interp1(1:1:length(cline), cline(1,:), 1:1/interp_const:length(cline));
    cline_new_y = interp1(1:1:length(cline), cline(2,:), 1:1/interp_const:length(cline));
    cline_new = [cline_new_x;cline_new_y];
    
    
    
%     lb_car = rotmat(-track_heading_new)*reshape(lb_world_new, [], 1);
%     ub_car = rotmat(-track_heading_new)*reshape(ub_world_new, [], 1);
%     Xmin = reshape(lb_world_new, 2, []);
%     Xmin = Xmin(1,:);
%     
%     Xmax = reshape(ub_world_new, 2, []);
%     Xmax = Xmax(1,:);
    
    goals.center = cline_new;
    goals.heading = track_heading_new;
end




function R = rotmat(h, sparse_flag)
% Given an angle in radians h, produce the 2-by-2 rotation matrix R that
% can rotate a point in \R^2 by the angle h about the origin
%
% If h is a vector (1-by-n or n-by-1), return a 2n-by-2n matrix in which
% each 2-by-2 block on the diagonal corresponds to each entry of h. This
% matrix is returned as a double if h has up to 100 entries, and a sparse
% matrix otherwise. Sparse output can also be forced by the argument
% sparse_flag.
    if nargin < 2
        sparse_flag = false ;
    end

    n = length(h) ;
    if n == 1
        R = [cos(h) -sin(h) ; sin(h) cos(h)] ;
    else
        h = h(:)' ;
        ch = cos(h) ; sh = sin(h) ;
        Rtall = [ch ; sh ; -sh ; ch] ;
        Rlong = reshape(Rtall,2,[]) ;
        if n <= 100 && ~sparse_flag
            % for smallish matrices, don't return sparse
            Rbig = repmat(Rlong, length(h),1) ;
            Icell = repmat({ones(2)},1,size(Rbig,2)/2,1) ;
            II = blkdiag(Icell{:}) ;
            R = Rbig.*II ;
        else
            io = 1:2:(2*n) ; % odd indices
            ie = 2:2:(2*n) ; % even indices
            
            % make row indices
            rio = repmat(io,2,1) ;
            rie = repmat(ie,2,1) ;
            rstack = [rio(:) rie(:)]' ;
            r = rstack(:) ;
            
            % make column indices
            c = repmat(1:2*n,2,1) ;
            c = c(:) ;
            
            % create sparse matrix
            R = sparse(r,c,Rlong(:)) ;
        end
    end
end
