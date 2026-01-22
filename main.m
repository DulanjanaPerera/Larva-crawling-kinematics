% Keep the following .mat file in the same folder. Numerical Simulation shows the
% predicted outputs and how the 4-bar mechanism moves as an animation. The
% script also saves computed lengths and angles for plotting and the
% Robotic simulation.
%
% The data is precomputed from excel and stored in varibles to used in
% scripts

clear all
clc
load('Length_Change_closedLoop_1Seg_wild_mean.mat')
load('X_relative_traj_fits_closedLoop_1Seg_wild_mean.mat')
load('initStates_closedLoop_1Seg_wild_mean.mat')
load('X_original_rel_traj_closedLoop_1Seg_wild_mean.mat')
load('time_closedLoop_1Seg_wild_mean.mat')
load('resampledData.mat')

% concatinate the muscles and angle data
l_act = [Length_Change, tr_angle_mean]';

% time vector for fitted curve. (the curve fitting gives smooth protopodium trajectory)
t = linspace(0,t(end),length(t));
tend = t(end);

% protopodium position vector from the curve fitting
X_sim = [xFit(t)'; yFit(t)'];

% ensure that the start and end position vectors are same as actual
X_sim(:,1) = original_rel_traj(:,1);
X_sim(:,end) = original_rel_traj(:,end);

% empty vectors and matrices
X_act = zeros(size(X_sim));
fwd_model = zeros(size(X_sim));
model = zeros(size(X_sim));
time = zeros(1,length(model));

% initial states of the system; muscle lengths
l_sim = init_states(1:5)';

% lowwer limits of the mucles and angle
lb_sim = min(l_act,[],2)'*0.95;

% upper limit of the muslces and angle
ub_sim = max(l_act,[],2)';

% initial vector of lengths and angles
l_sim = [l_sim; tr_angle_mean(1)];

% switch to record the model prediction animation (1 - recored ON; 0 - record OFF)
record = 0;

if record == 1
    videoFile = VideoWriter('Model_prediction.mp4', 'MPEG-4');
    videoFile.FrameRate = 24;
    open(videoFile);
end

fig = figure(1);

for n=1:1
    for i=1:length(X_sim) 
    
        % keep the previous lengths and angle prediction for the
        % optimization
        if i == 1
            x0_sim = l_sim(:,i)';
        else
            x0_sim = l_sim(:,i-1)';
        end
  
        % model prediction from the optimization
        [l_opt, fval, flag, output] = optimization_model_prediction(X_sim(1,i), X_sim(2,i), lb_sim, ub_sim, x0_sim, init_states);
        l_sim(:,i) = l_opt;

        % % Drawing the simulation
        out_act = linesFor4barmechanism(l_act(:,i));
        out_sim = linesFor4barmechanism(l_sim(:,i));

        % plotting
        tiledlayout(2,3);

        nexttile
        plot(out_sim(1,:, 1),out_sim(2,:,1), '-r', 'LineWidth', 3);
        hold on
        
        plot(out_sim(1,:, 2),out_sim(2,:, 2), '--m', 'LineWidth', 2);
        plot(out_sim(1,:, 3),out_sim(2,:, 3), '-b', 'LineWidth', 3);
        plot(out_sim(1,:, 4),out_sim(2,:, 4), '--g', 'LineWidth', 2);

        model(1,i) = out_sim(1,2, 3);
        model(2,i) = out_sim(2,2, 3);
        
        [T1,T2] = forwardModel(l_act(:,i));
        a = (tr_angle_mean(i));
        fwd_model(:, i) = [cos(a), -sin(a);sin(a), cos(a)]*[T2(1); T2(3)];

        plot(model(1,1:i), model(2,1:i), 'b-*', 'MarkerSize', 3);
        plot(original_rel_traj(1,1:i), original_rel_traj(2,1:i), 'r-*', 'MarkerSize', 3);        

        hold off
        axis equal
        grid on
        legend({"VL(l1)", "l2", "VO(l3)", "l4", "model", "actual gait"}, ...
            'Location','southwest', 'NumColumns',2);
        xlim([-0.05 1.3]);
        ylim([-1.3 0.2]);
        title("Gait");
        
        nexttile
        plot(t(1:i), l_sim(3,1:i), 'b');
        hold on
        plot(t(1:i), Length_Change(1:i,3), 'k');
        hold off
        title("muscle VO (l3)");
        legend("Sim","Actual");
        xlabel("t(seconds)");
        ylabel("muscle length (mm)");
        xlim([0 tend]);
        ylim([0.7 1.4]);
        grid on;

        nexttile
        plot(t(1:i), l_sim(1,1:i), 'r');
        hold on
        plot(t(1:i), Length_Change(1:i,1), 'k');
        hold off
        title("muscle Vl (l1)");
        legend("Sim","Actual");
        xlabel("t(seconds)");
        ylabel("muscle length (mm)");
        xlim([0 tend]);
        ylim([0.65 1.05]);
        grid on;

        nexttile
        plot(t(1:i), l_sim(2,1:i), 'm');
        hold on
        plot(t(1:i), Length_Change(1:i,2), 'k');
        hold off
        title("muscle (l2)");
        legend("Sim","Actual");
        xlabel("t(seconds)");
        ylabel("muscle length (mm)");
        xlim([0 tend]);
        ylim([0 1]);
        grid on;

        nexttile
        plot(t(1:i), l_sim(4,1:i), 'm');
        hold on
        plot(t(1:i), Length_Change(1:i,4), 'k');
        hold off
        title("muscle (l4)");
        legend("Sim","Actual");
        xlabel("t(seconds)");
        ylabel("muscle length (mm)");
        xlim([0 tend]);
        ylim([0.93 1.2]);
        grid on;

        nexttile
        plot(model(1,1:i), model(2,1:i), 'b-*', 'MarkerSize', 3);
        hold on
        plot(original_rel_traj(1,1:i), original_rel_traj(2,1:i), 'r-*', 'MarkerSize', 3);
        plot(fwd_model(1,1:i), fwd_model(2,1:i), 'k-*', 'MarkerSize', 3);
        hold off
        title("Gait");
        legend("Simulation", "Actual", "forward");
        xlabel("x (mm)");
        ylabel("y (mm)");
        xlim([0.55 1.24]);
        ylim([-1.145 -0.85]);
        grid on;

        drawnow


        if record == 1
            frame = getframe(fig);
            writeVideo(videoFile, frame);
        end
    
    end
end

if record == 1
    close(videoFile);
end

% save data for the plots
% X_sim_normal = X_sim;
% model_normal = model;
% original_normal = original_rel_traj;
% save("normal_paper_plots0104.mat", "X_sim_normal", "model_normal", "original_normal");
% 
% t_normal = t;
% l_sim_normal = l_sim;
% Length_Change_normal = Length_Change;
% save("normal_length_plots0104.mat", "t_normal", "l_sim_normal", "Length_Change_normal");
