-------- MATLAB

The MATLAB scripts and Simulink Models are tested in MATLAB R2025a.
The following dependencies are required for MATLAB,

1) Optimization Toolbox
2) Simscape Multibody (for Simulink)


Steps to run the Robot simulation in Simulink.

1) Open the robotic_larva_simscape.slx
2) Run the main.m MATLAB script
3) Run the update_simulink_parameters.m
4) Run the Simulink file (It will automatically open the viewer. The simulation will take a significant time to simulate)

The plotting_gait_muscles.m script generates the figures shown in the paper.



-------- Kinovea

The Kinovea tracking is tested in Kinovea 2023.1.2. Load the video into Kinovea, and it automatically loads the *.kva files (tracked and annotated)
