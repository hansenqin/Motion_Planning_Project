
function [u_, a] = ROB535_ControlProject_part2_Team01(curr_state, Y, U)
    a = 0;
    
    N = 15;
    num_states = 7;
    num_inputs = 2;
    load dMatrices.mat
    A_lin_fun = Ad_;
    B_lin_fun = Bd_;
    

    x = curr_state(1);
    y = curr_state(2);
    h = curr_state(3);
    u = curr_state(4);
    v = curr_state(5);
    r = curr_state(6);
    w = curr_state(7);


    closest_traj_idx = get_closest([Y(:,1) Y(:,3)]', [x;y]);
    
     
    Y_used = Y(closest_traj_idx:closest_traj_idx+N-1, :);
    U_used = U(closest_traj_idx:closest_traj_idx+N-1, :);

    %% get linearized matrices
    xu_cell = num2cell([Y_used U_used],2);

    A_cell = cellfun(A_lin_fun, xu_cell, 'UniformOutput',false);
    B_cell = cellfun(B_lin_fun, xu_cell, 'UniformOutput',false);

    %% construct offline QP-MPC matrices
    
    W = [];
    
    Q = [10,    0,  0, 0, 0, 0, 0;
         0,    10,  0, 0, 0, 0, 0;
         0,     0, 10, 0, 0, 0, 0;
         0,     0,  0, 10,0, 0, 0;
         0,     0,  0, 0, 10, 0, 0;
         0,     0,  0, 0, 0, 10, 0
         0,     0,  0, 0, 0, 0, 10];
    R = [0.005, 0;
         0, 10];
     
    Q_bar = blkdiag(1000*kron(eye(N-1),Q),1000*Q);
    R_bar = blkdiag(10*kron(eye(N),R));

    %% MPC formulation 1 loop
    x_list = [];
    x0 = curr_state';
    x_list = [x0];
    u_list = [];
    options =  optimset('Display','off');

    %% Solve MPC
    
    [S, M, G, T] = construct_QPMPC_mats(A_cell(1:1+N-1), B_cell(1:1+N-1), num_states, num_inputs, N);
    U = qp_mpc(Q_bar, R_bar, S, M, G, T, W, x0 - Y_used(1,:)', options, num_inputs);
% 
%     v_ = U(1:num_inputs,1);
%     u_ = v_ + U_used(1,:)';
    v_ = U;
    u_ = v_ + reshape(U_used',[],1);
    u_ = reshape(u_,2,[])';
    

end

    
function Y = modify_traj(Y, obs, bl_world_new, br_world_new, cline, heading, traj_to_track_mapping)
    %Modifies trajectory upon seeing obstacle


    obs_center = mean(obs);
    
    closest_traj_idx = get_closest([Y(:,1) Y(:,3)]', obs_center');
    closest_track_idx = get_closest(cline, obs_center');
    leftside = get_obs_side(obs_center, cline, heading, closest_track_idx);
    
    curr_mapping = traj_to_track_mapping(closest_traj_idx-500:closest_traj_idx+500);
    
    if ~leftside
        
        
        Y(closest_traj_idx-500:closest_traj_idx-401, 1) = linspace(Y(closest_traj_idx-500, 1), (cline(1, curr_mapping(100)) + bl_world_new(1, curr_mapping(100)))'/2, 100);
        Y(closest_traj_idx-500:closest_traj_idx-401, 3) = linspace(Y(closest_traj_idx-500, 3), (cline(2, curr_mapping(100)) + bl_world_new(2, curr_mapping(100)))'/2, 100);
        
        Y(closest_traj_idx-400:closest_traj_idx+400, 1) = (cline(1, curr_mapping(101:901)) + bl_world_new(1, curr_mapping(101:901)))'/2;
        Y(closest_traj_idx-400:closest_traj_idx+400, 3) = (cline(2, curr_mapping(101:901)) + bl_world_new(2, curr_mapping(101:901)))'/2;
        
        
        Y(closest_traj_idx+401:closest_traj_idx+500, 1) = linspace((cline(1, curr_mapping(902)) + bl_world_new(1, curr_mapping(902)))'/2, Y(closest_traj_idx+500, 1), 100);
        Y(closest_traj_idx+401:closest_traj_idx+500, 3) = linspace((cline(2, curr_mapping(902)) + bl_world_new(2, curr_mapping(902)))'/2, Y(closest_traj_idx+500, 3), 100);
        
      
    else
        Y(closest_traj_idx-500:closest_traj_idx-401, 1) = linspace(Y(closest_traj_idx-500, 1), (cline(1, curr_mapping(100)) + br_world_new(1, curr_mapping(100)))'/2, 100);
        Y(closest_traj_idx-500:closest_traj_idx-401, 3) = linspace(Y(closest_traj_idx-500, 3), (cline(2, curr_mapping(100)) + br_world_new(2, curr_mapping(100)))'/2, 100);
        
        Y(closest_traj_idx-400:closest_traj_idx+400, 1) = (cline(1, curr_mapping(101:901)) + br_world_new(1, curr_mapping(101:901)))'/2;
        Y(closest_traj_idx-400:closest_traj_idx+400, 3) = (cline(2, curr_mapping(101:901)) + br_world_new(2, curr_mapping(101:901)))'/2;
        
        
        Y(closest_traj_idx+401:closest_traj_idx+500, 1) = linspace((cline(1, curr_mapping(902)) + br_world_new(1, curr_mapping(902)))'/2, Y(closest_traj_idx+500, 1), 100);
        Y(closest_traj_idx+401:closest_traj_idx+500, 3) = linspace((cline(2, curr_mapping(902)) + br_world_new(2, curr_mapping(902)))'/2, Y(closest_traj_idx+500, 3), 100);
        
    end


    end

function leftside = get_obs_side(obs_center, cline, heading, closest_track_idx)
    %Check if obstacle is on leftside

    
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
%     This function takes the given bounds of the racing track and up
%     samples them
    
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
