function [verts, faces] = gen_rect_points_flat(X, Y)
    length = 4;
    width = 30;
    X_pt = [];
    Y_pt = [];
    
    X_pt(end+1) = X-width/2;
    X_pt(end+1) = X-width/2;
    X_pt(end+1) = X+width/2;
    X_pt(end+1) = X+width/2;
    
    Y_pt(end+1) = Y-length/2;
    Y_pt(end+1) = Y+length/2;
    Y_pt(end+1) = Y+length/2;
    Y_pt(end+1) = Y-length/2;
    
    verts = [X_pt', Y_pt', repmat(0.01, 4, 1)];
    faces = [1 2 3 4];

end

