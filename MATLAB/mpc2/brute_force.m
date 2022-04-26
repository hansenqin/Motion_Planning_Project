close all
x0 = [287,5,-176,0,2,0];

%first straight
U = repmat([-0.10 70],50,1);
U = [U; [[-0.11:0.01:0]', repmat(70,length(-0.11:0.01:0),1)]];
U = [U; repmat([0 70],2650,1)];

%first corner
U = [U; [[0:-0.01:-0.028]', repmat(50,length(0:-0.01:-0.028),1)]];
U = [U; repmat([-0.024 50],2800,1)];
U = [U; [[-0.028:-0.01:-0.030]', repmat(50,length(-0.028:-0.01:-0.030),1)]];
U = [U; repmat([-0.030 50],500,1)];
U = [U; [[-0.030:0.01:0]', repmat(50,length(-0.030:0.01:0),1)]];
U = [U; repmat([0 50],2500,1)];


%second straight
U = [U; repmat([0 100],1700,1)];


%second corner
U = [U; [[0:0.01:0.024]', repmat(80,length(0:0.01:0.024),1)]];
U = [U; repmat([0.024 70],2100,1)];
U = [U; [[0.024:-0.01:0]', repmat(70,length(0.024:-0.01:0),1)]];

%third corner
U = [U; [[0:-0.01:-0.04]', repmat(70,length(0:-0.01:-0.04),1)]];
U = [U; repmat([-0.04 70],1700,1)];
U = [U; [[-0.04:0.01:0]', repmat(70,length(-0.04:0.01:0),1)]];
U = [U; repmat([0 100],200,1)];

%fourth corner
U = [U; [[0:0.01:0.038]', repmat(70,length(0:0.01:0.038),1)]];
U = [U; repmat([0.038 70],2000,1)];
U = [U; [[0.038:-0.01:0]', repmat(70,length(0.038:-0.01:0),1)]];
U = [U; repmat([0 67],300,1)];

%fifth corner
U = [U; [[0:-0.01:-0.030]', repmat(50,length(0:-0.01:-0.030),1)]];
U = [U; repmat([-0.024 50],2800,1)];
U = [U; [[-0.030:0.01:-0.010]', repmat(50,length(-0.030:0.01:-0.010),1)]];
U = [U; repmat([-0.010 50],300,1)];
U = [U; [[-0.010:-0.01:-0.034]', repmat(50,length(-0.010:-0.01:-0.034),1)]];
U = [U; repmat([-0.034 50],2300,1)];
U = [U; [[-0.034:0.01:0]', repmat(70,length(-0.034:0.01:0),1)]];
U = [U; repmat([0 150],2000,1)];

%sixth corner
U = [U; [[0:0.01:0.048]', repmat(70,length(0:0.01:0.048),1)]];
U = [U; repmat([0.048 70],1300,1)];
U = [U; [[0.048:-0.01:0]', repmat(70,length(0.048:-0.01:0),1)]];
U = [U; repmat([0 67],500,1)];


%seventh (small) corner
U = [U; [[0:0.01:0.02]', repmat(70,length(0:0.01:0.02),1)]];
U = [U; repmat([0.02 70],800,1)];
U = [U; [[0.02:-0.01:0]', repmat(70,length(0.02:-0.01:0),1)]];
U = [U; repmat([0 67],30,1)];

%eighth corner
U = [U; [[0:-0.01:-0.048]', repmat(50,length(0:-0.01:-0.048),1)]];
U = [U; repmat([-0.048 50],2600,1)];
U = [U; [[-0.048:0.01:0]', repmat(50,length(-0.048:0.01:0),1)]];

%ninth corner
U = [U; [[0:0.01:0.094]', repmat(80,length(0:0.01:0.094),1)]];
U = [U; repmat([0.094 70],900,1)];
U = [U; [[0.094:-0.01:0]', repmat(70,length(0.094:-0.01:0),1)]];
U = [U; repmat([0 150],1500,1)];
U = [U; repmat([0 50],1300,1)];

%Tenth corner
U = [U; [[0:0.01:0.034]', repmat(80,length(0:0.01:0.034),1)]];
U = [U; repmat([0.034 70],900,1)];
U = [U; [[0.034:-0.01:0]', repmat(70,length(0.034:-0.01:0),1)]];
U = [U; repmat([0 150],3500,1)];

%extra saftey in the end
U = [U; [[0:0.01:0.01]', repmat(80,length(0:0.01:0.01),1)]];
U = [U; repmat([0.01 70],900,1)];
U = [U; [[0.01:-0.01:0]', repmat(70,length(0.01:-0.01:0),1)]];
U = [U; repmat([0 70],400,1)];

[Y,T]=forwardIntegrateControlInput(U, x0);
open track.fig
hold on
plot(Y(:,1), Y(:,3))

% figure(2)
% plot(T, Y(:,2))


