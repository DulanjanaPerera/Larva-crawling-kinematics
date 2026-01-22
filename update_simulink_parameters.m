% Run the main.m file first ------
% The this file before running the simulation (you need to open the
% simulink file before run this script)
%
% This script update the simulink file with environemnt parameters. You can
% play with the parameters to see how environment and each muscle affect
% the crawling locomotion.


% This is how to get the block parameters
% p = Simulink.Mask.get('robotic_larva_simscape/Sub1/RJ3');

% 1 second for gait
gait_t = 1; 
percent = 0.2;

% time gap between adjucent segments
t_d = gait_t*percent; 

ll_sim = l_sim;

% this the datapoints for single gait
len = length(ll_sim); 

% point-time gap between adjucent segments
t_dp = floor(len*percent); 

% number of segments
s = 7; 

% total time for the peristaltic
T_sec = (s-1)*t_d + gait_t; 

% total time for the full wave
time = linspace(0,T_sec, len + (s-1)*t_dp); 

% fill the data points until wave propagates to the front
% equation looks like: (len + (segments-1)*t_d)
l_cycle = [ll_sim, ll_sim(:,1).*ones(size(ll_sim, 1),t_dp*(s-1))];

% normalized to 1
l_sim_scaled = l_cycle./(l_cycle(1,1)); 

% (0.08 + 0.xx + 0.04) - is the initial value of the each actuator. middle
% point. probably need the Solidworks file to check it. Simulink model is
% defined for 1mm.

L1 = l_sim_scaled(1,:)' - (0.08 + 0.5 + 0.04);
% L1 = ones(size(L1))*L1(1); % uncomment to silence VL muscle

L2 = l_sim_scaled(2,:)' - (0.08 + 0.32 + 0.04);

L3 = l_sim_scaled(3,:)' - (0.08 + 0.655 + 0.04);
% L3 = ones(size(L3))*L3(1); % uncomment to silence VO muscle

L4 = l_sim_scaled(4,:)' - (0.08 + 0.6 + 0.04);

% % Set the model parameters
s = 7;
mdl = 'robotic_larva_simscape';


% % % initial lengths
Initout = [round(L1(1),4); round(L2(1),4); round(L3(1),4); round(L4(1),4)];

% % colors for the VL and VO
colorVL = [0.6 0.6 0.0];
colorVL_move = [0.8 0.8 0.0];
colorVO = [0.6 0.0 0.6];
colorVO_move = [0.8 0.0 0.8];
colorStruct = [0.88235295 0.88235295 0.88235295];
colorStruct_move = [0.9137255 0.9137255 0.9137255];

% % weight of the plate
path0 = [mdl,'/File Solid1'];
mass_plate = 10000;
set_param(path0,'Mass', num2str(mass_plate), 'MassUnits', 'kg');

for i = 1:s

    mass_larvae = 0.1;
    kg = 'kg';
    path0 = [mdl,'/Sub', num2str(i),'/File Solid'];
    set_param(path0,'Mass', num2str(mass_larvae), 'MassUnits', kg);

     for j = [2, 3, 4, 5, 6, 8, 9, 11 ]
         if (j~=2)
            path = [mdl,'/Sub', num2str(i),'/File Solid', num2str(j)];
            set_param(path,'Mass', num2str(mass_larvae), 'MassUnits', kg);
         end
     end

    path = [mdl,'/Sub', num2str(i),'/RJ3'];
    set_param(path, 'SpringStiffness', num2str(0.001));   

    % Friction properties of the plate
    path = [mdl,'/Sub', num2str(i),'/SCF2'];
    set_param(path,'CoefficientOfStaticFriction', num2str(20));
    set_param(path,'CoefficientOfDynamicFriction', num2str(10));
    set_param(path,'FrictionalCriticalVelocity', num2str(0.5));

    % % Change the transport delay for the phase shift
    if i~=7 
        path = [mdl,'/Sub', num2str(i),'/Transport Delay'];
        % set_param(path,'DelayTime', num2str((i-s)*-tsec/(s*10)));
        set_param(path,'DelayTime', num2str((i-s)*-t_d));
        set_param(path, 'BufferSize', num2str(1024*15));
        set_param(path,'InitialOutput', 'Initout');
    end

end

for i =1:9
    % % Color change
    solidColoring(mdl, i);

    mass_larvae = 0.01;
    kg = 'kg';
    if (i>7)
     for j = [2, 3, 4, 5, 6, 8, 9, 11 ]
         if (j~=2)
            path = [mdl,'/Sub', num2str(i),'/File Solid', num2str(j)];
            set_param(path,'Mass', num2str(mass_larvae), 'MassUnits', kg);
         end
     end
    end
end

function solidColoring(mdl, i)

    path = [mdl, '/Sub', num2str(i), '/File Solid'];
    set_param(path, 'GraphicType', 'FromGeometry', ...
        'GraphicVisPropType', 'AdvancedVisualProperties', ...
        'GraphicDiffuseColor', 'colorVL');
    path = [mdl, '/Sub', num2str(i), '/File Solid3'];
    set_param(path, 'GraphicType', 'FromGeometry', ...
        'GraphicVisPropType', 'AdvancedVisualProperties', ...
        'GraphicDiffuseColor', 'colorVL_move');

    path = [mdl, '/Sub', num2str(i), '/File Solid9'];
    set_param(path, 'GraphicType', 'FromGeometry', ...
        'GraphicVisPropType', 'AdvancedVisualProperties', ...
        'GraphicDiffuseColor', 'colorVO');
    path = [mdl, '/Sub', num2str(i), '/File Solid8'];
    set_param(path, 'GraphicType', 'FromGeometry', ...
        'GraphicVisPropType', 'AdvancedVisualProperties', ...
        'GraphicDiffuseColor', 'colorVO_move');

    path = [mdl, '/Sub', num2str(i), '/File Solid4'];
    set_param(path, 'GraphicType', 'FromGeometry', ...
        'GraphicVisPropType', 'AdvancedVisualProperties', ...
        'GraphicDiffuseColor', 'colorStruct');
    path = [mdl, '/Sub', num2str(i), '/File Solid5'];
    set_param(path, 'GraphicType', 'FromGeometry', ...
        'GraphicVisPropType', 'AdvancedVisualProperties', ...
        'GraphicDiffuseColor', 'colorStruct_move');

    path = [mdl, '/Sub', num2str(i), '/File Solid11'];
    set_param(path, 'GraphicType', 'FromGeometry', ...
        'GraphicVisPropType', 'AdvancedVisualProperties', ...
        'GraphicDiffuseColor', 'colorStruct');
    path = [mdl, '/Sub', num2str(i), '/File Solid6'];
    set_param(path, 'GraphicType', 'FromGeometry', ...
        'GraphicVisPropType', 'AdvancedVisualProperties', ...
        'GraphicDiffuseColor', 'colorStruct_move');

end