function sand_box(inputs, M1, M2)
    curr_traj = [0 0 0 0 0 0 0];
    curr_inputs = [];
    for i=1:length(inputs.TrajectoryKeys)
        curr_inputs_ = M1(inputs.TrajectoryKeys{i});
        curr_traj = [curr_traj; M2(inputs.TrajectoryKeys{i})+[curr_traj(end, 1),curr_traj(end, 2),0,0,0,0,0]];
        curr_inputs = [curr_inputs; [curr_inputs_.Td curr_inputs_.Delta]];
        
    end

    
    subplot(4,1,1)
    plot(curr_traj(:,1), curr_traj(:,2), 'LineWidth',2, 'Color','b');
end




