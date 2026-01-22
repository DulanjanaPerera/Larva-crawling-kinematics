% This script plots the figures of length change with mean and standard
% deviation. The following data was computed from the main.m script

clear
load('lengths_mean_time.mat')
load('simulationData_plotting.mat')

tend = t_normal(end);

figure(1)
hold on
plot(original_normal(1,:), original_normal(2,:), 'r-*', 'MarkerSize', 3, 'LineWidth',2);
plot(fwd_model(1,:), fwd_model(2,:), 'k-o', 'MarkerSize', 2, 'LineWidth',1);
hold off
title("Protopodium Trajectories (n=5)");
legend("Sample average of protopodium", "Predicted protopodium");
xlabel("x (mm)");
ylabel("y (mm)");
xlim([0.55 1.23]);
ylim([-1.16 -0.85]);
grid on;

figure(2)
plot(original_normal(1,:), original_normal(2,:), 'r-*', 'MarkerSize', 3, 'LineWidth',2);
hold on
plot(model_normal(1,:), model_normal(2,:), 'b-+', 'MarkerSize', 3, 'LineWidth',1);
hold off
title("Protopodium Trajectories (n=5)");
legend("Sample average of protopodium", "Protopodium from Predicted muscle");
xlabel("x (mm)");
ylabel("y (mm)");
xlim([0.55 1.23]);
ylim([-1.16 -0.85]);
grid on;

figure(3)
s = shadedErrorBar(t, l3',{@mean,@std},'lineprops','--g', 'patchSaturation', 0.5); 
s.patch.FaceColor = [0.1660 0.4740 0.1880];
hold on
plot(t_normal(:), l_sim_normal(3,:), 'b', 'LineWidth',2);
hold off
title("VO group Prediction (spring-3) (n=5)");
legend("Sample average of VO","Predicted VO", 'Position',[0.529166666666667 0.827380952380953 0.219642857142857 0.0837301587301585]);
xlabel("t(seconds)");
ylabel("muscle length (mm)");
xlim([0 tend]);
ylim([0.6 1.5]);
grid on;

figure(4)
s = shadedErrorBar(t, l1',{@mean,@std},'lineprops','--r', 'patchSaturation', 0.5); 
s.patch.FaceColor = [0.8500 0.3250 0.0980];
hold on
plot(t_normal, l_sim_normal(1,:), 'b', 'LineWidth',2);
hold off
title("VL group Prediction (spring-1) (n=5)");
legend("Sample average of VL","Predicted VL", 'Position',[0.529166666666667 0.827380952380953 0.219642857142857 0.0837301587301585]);
xlabel("t(seconds)");
ylabel("muscle length (mm)");
xlim([0 tend]);
ylim([0.55 1.05]);
grid on;

figure(5)
s = shadedErrorBar(t, rad2deg(tr_angle'),{@mean,@std},'lineprops','--k', 'patchSaturation', 0.5); 
s.patch.FaceColor = "#b6bbc2";
hold on
plot(t_normal, rad2deg(l_sim_normal(6,:)), 'k', 'LineWidth',2);
hold off
title("VL Angle Prediction (\theta) (n=5)");
legend("Sample average of \theta","Predicted \theta");
xlabel("t(seconds)");
ylabel("degree");
xlim([0 tend]);
ylim([-3 9]);
grid on;

figure(6)
s = shadedErrorBar(t, l2',{@mean,@std},'lineprops','--m', 'patchSaturation', 0.5); 
s.patch.FaceColor = '#987BE6'; %[0.8500 0.3250 0.0980];
hold on
plot(t_normal, l_sim_normal(2,:), 'b', 'LineWidth',2);
hold off
title("Spring-2 Prediction (n=5)");
legend("Sample average of spring-2","Predicted spring-2", 'Position',[0.529166666666667 0.827380952380953 0.219642857142857 0.0837301587301585]);
xlabel("t(seconds)");
ylabel("muscle length (mm)");
xlim([0 tend]);
ylim([0.4 0.7]);
grid on;

figure(7)
s = shadedErrorBar(t, l4',{@mean,@std},'lineprops','--m', 'patchSaturation', 0.5); 
s.patch.FaceColor = '#987BE6'; %[0.8500 0.3250 0.0980];
hold on
plot(t_normal, l_sim_normal(4,:), 'b', 'LineWidth',2);
hold off
title("Spring-4 Prediction (n=5)");
legend("Sample average of spring-4","Predicted spring-4", 'Position',[0.529166666666667 0.827380952380953 0.219642857142857 0.0837301587301585]);
xlabel("t(seconds)");
ylabel("muscle length (mm)");
xlim([0 tend]);
ylim([0.85 1.35]);
grid on;